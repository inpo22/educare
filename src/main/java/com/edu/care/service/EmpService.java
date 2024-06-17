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
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.edu.care.dao.EmpDAO;
import com.edu.care.dto.EmpDTO;

@Service
public class EmpService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired EmpDAO empDAO;
	
	public String file_root = "C:/upload/";
	
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

        String photoFileName = fileSave(photo); // 사진 저장
        if (photoFileName != null) {
            param.put("photo", photoFileName); // 매개변수에 사진 파일명 추가
        }
        return empDAO.reg(param); // DAO를 통해 데이터베이스에 사원 정보 삽입
    }

	
	public String fileSave(MultipartFile photo) {
		if (photo == null || photo.isEmpty()) {
	        return null;
	    }
		
		String fileName = photo.getOriginalFilename();
		
		// 확장자 추출
		String ext = fileName.substring(fileName.lastIndexOf("."));
		
		// 새 파일 명 생성
		String newFileName = System.currentTimeMillis()+ext;
		logger.info(fileName+ "->"+newFileName);
		
		// 파일 저장 (만든 upload 폴더에 저장)
		try {
			byte[] bytes = photo.getBytes(); // MultipartFile 로 부터 바이너리 추출
			Path path = Paths.get(file_root+newFileName); // 저장 경로 지정
			Files.write(path, bytes); // 저장
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
}
