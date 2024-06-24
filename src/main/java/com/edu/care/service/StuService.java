package com.edu.care.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.edu.care.dao.StuDAO;
import com.edu.care.dto.PaymentDTO;
import com.edu.care.dto.StuDTO;

@Service
public class StuService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired StuDAO stuDAO;
	
	public String file_root = "C:/upload/";

	public Map<String, Object> stdList(int currPage, int pagePerCnt, String type, String searchbox, String startDate,
			String endDate) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<StuDTO> list = stuDAO.stdList(start, pagePerCnt, type, searchbox, startDate, endDate);
		logger.info("list :"+list);
		logger.info("list.size : "+list.size());
		
		result.put("list", list);
		result.put("totalPage", stuDAO.stdListPageCnt(pagePerCnt, type, searchbox, startDate, endDate));
		
		return result;
	}

	public Object overlay(String id) {
		return stuDAO.overlay(id);
	}

	public int reg(MultipartFile photo, Map<String, String> param) {
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
                Path path = Paths.get(file_root + "/" + newFileName);
                Files.write(path, bytes);
            } catch (IOException e) {
                e.printStackTrace();
                // 파일 저장 실패 시 처리 로직 추가
            }
        }
        String classify_code = param.get("classify_code");
        
        // 회원 번호 생성
        String user_code = stuDAO.createUserCode(classify_code);
        
        // 파일 이름을 param에 추가
        param.put("photo", newFileName);
        param.put("user_code", user_code);
        
        int row = stuDAO.reg(param);
		return row;
	}

	public int edit(Map<String, String> param, String user_code) {
		param.put("user_code", user_code);
		return stuDAO.edit(param);
	}

	public StuDTO stuDetail(String user_code) {
		return stuDAO.stuDetail(user_code);
	}

	public Map<String, Object> payList(int currPage, int pagePerCnt, String Psearchbox, String user_code) {
		int start = (currPage-1) * pagePerCnt;
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<PaymentDTO> list = stuDAO.payList(start, pagePerCnt, Psearchbox,user_code);
		
		logger.info("list : {}", list);
		logger.info("list size : " + list.size());
		result.put("list", list);
		result.put("totalPage", stuDAO.payListPageCnt(pagePerCnt, Psearchbox,user_code));
		
		return result;
	}
	
}
