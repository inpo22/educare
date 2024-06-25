package com.edu.care.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.edu.care.dao.EmpDAO;
import com.edu.care.dto.EmpDTO;

@Service
public class EmpService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired EmpDAO empDAO;
	@Autowired PasswordEncoder encoder;
	
	@Value("${spring.servlet.multipart.location}")
	private String root;
	
	public Map<String, Object> empList(int currPage, int pagePerCnt, String type, String searchbox, String startDate, String endDate) {
		int start = (currPage-1) * pagePerCnt;
	
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<EmpDTO> list = empDAO.empList(start, pagePerCnt,type,searchbox,startDate,endDate);
		
		logger.info("list : {}", list);
		logger.info("list size : " + list.size());
		result.put("list", list);		
		result.put("totalPage", empDAO.empListPageCnt(pagePerCnt,type,searchbox,startDate,endDate));
		
		return result;
	}

	public int quitEmp(List<String> quitList) {
		int cnt = 0;
		
		for(String user_code : quitList) {
			cnt += empDAO.quitEmp(user_code);
		}
		return cnt;
	}

	public int overlay(String id) {
		return empDAO.overlay(id);
	}

	public int reg(MultipartFile photo, Map<String, String> param) {
		
		// 비밀번호 암호화
        String rawPassword = param.get("pw");
        String encodedPassword = encoder.encode(rawPassword);
        param.put("pw", encodedPassword);
		
		// 파일 처리 로직
        String newFileName = null;
        
        if (!photo.isEmpty()) {
            String fileName = photo.getOriginalFilename();
            String ext = "";
            
            // 파일 이름이 있는 경우에만 확장자 추출
            if (fileName != null && !fileName.isEmpty()) {
                int lastIndex = fileName.lastIndexOf(".");
                
                if (lastIndex != -1) {
                    ext = fileName.substring(lastIndex);
                }
            }
            
            newFileName = System.currentTimeMillis() + ext;
            
            try {
                byte[] bytes = photo.getBytes();
                Path path = Paths.get(root + "/" + newFileName);
                Files.write(path, bytes);
            } catch (IOException e) {
                e.printStackTrace();
                // 파일 저장 실패 시 처리 로직 추가
            }
        }
        String classify_code = param.get("classify_code");
        
        // 회원 번호 생성
        String user_code = empDAO.createUserCode(classify_code);
        
        // 파일 이름을 param에 추가
        param.put("photo", newFileName);
        param.put("user_code", user_code);
        
        int row = empDAO.reg(param);
        
        empDAO.regVaca(user_code);
        
		return row;
    }

	public Map<String, Object> deptList() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<EmpDTO> deptList = empDAO.deptList();
		
		map.put("deptList", deptList);
		
		return map;
	}

	public EmpDTO empDetail(String user_code) {
		return empDAO.empDetail(user_code);
	}

	public int edit(MultipartFile photo, Map<String, String> param, String user_code) {
		// 파일 처리 로직
        String newFileName = null;
        
        if (!photo.isEmpty()) {
            String fileName = photo.getOriginalFilename();
            String ext = "";
            
            // 파일 이름이 있는 경우에만 확장자 추출
            if (fileName != null && !fileName.isEmpty()) {
                int lastIndex = fileName.lastIndexOf(".");
                
                if (lastIndex != -1) {
                    ext = fileName.substring(lastIndex);
                }
            }
            
            newFileName = System.currentTimeMillis() + ext;
            
            try {
                byte[] bytes = photo.getBytes();
                Path path = Paths.get(root + "/" + newFileName);
                Files.write(path, bytes);
            } catch (IOException e) {
                e.printStackTrace();
                // 파일 저장 실패 시 처리 로직 추가
            }
        }
        
        // 파일 이름을 param에 추가
        param.put("photo", newFileName);
        // user_code param 에 추가
        param.put("user_code", user_code);
        
		return empDAO.edit(param);
	}

	public Map<String, Object> quitList(int currPage, int pagePerCnt, String dateType, String type, String searchbox,
			String startDate, String endDate) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<EmpDTO> Qlist = empDAO.quitList(start, pagePerCnt,dateType,type,searchbox,startDate,endDate);
		logger.info("Qlist : {}", Qlist);
		logger.info("Qlist size : " + Qlist.size());
		result.put("Qlist", Qlist);
		result.put("totalPage", empDAO.quitListPageCnt(pagePerCnt,dateType,type,searchbox,startDate,endDate));
		
		return result;
	}


	
	
	
}
