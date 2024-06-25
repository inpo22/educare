package com.edu.care.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.dao.MypageDAO;
import com.edu.care.dto.MypageDTO;

@Service
public class MypageService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MypageDAO mypageDAO;
	
	@Value("${spring.servlet.multipart.location}")
	private String root;

	public ModelAndView empMypage(String user_code) {
		ModelAndView mav = new ModelAndView("mypage/empMypage");
		
		MypageDTO dto = mypageDAO.empMypage(user_code);
		
		mav.addObject("dto", dto);
		
		return mav;
	}

	@Transactional
	public void empProfileEdit(MultipartFile photo, Map<String, String> param, String user_code) {
		MypageDTO dto = new MypageDTO();
		
		dto.setUser_code(user_code);
		dto.setEmail(param.get("email"));
		dto.setPhoto(param.get("phone"));
		
		mypageDAO.empProfileEdit(dto);
		
		fileSave(photo, user_code);
		
	}
	
	private void fileSave(MultipartFile photo, String user_code) {
		String ori_filename = photo.getOriginalFilename();
		
		if (!ori_filename.equals("")) {
			
			String ext = ori_filename.substring(ori_filename.lastIndexOf("."));
			
			String new_filename = System.currentTimeMillis() + ext;
			
			try {
				byte[] bytes = photo.getBytes();
				Path path = Paths.get(root + new_filename);
				Files.write(path, bytes);
				
				mypageDAO.profileImgSave(user_code, new_filename);
				
				Thread.sleep(1);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public int empPwEdit(Map<String, String> param, String user_code) {
		
		return 0;
	}
	
}
