package com.edu.care.service;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.dao.LoginDAO;
import com.edu.care.dto.LoginDTO;

@Service
public class LoginService {

	@Autowired
	LoginDAO loginDAO;
	@Autowired
	PasswordEncoder encoder;
	Logger logger = LoggerFactory.getLogger(getClass());

	public ModelAndView loginAccess(HttpSession session, String id, String pw) {

		LoginDTO loginInfo = loginDAO.loginAccess(id);
		logger.info("loginInfo = {}", loginInfo);
		
		boolean success = false;
		String page = "login/login";
		String msg = "아이디 또는 비밀번호를 확인하세요";
		
		String enc_pw = (loginInfo != null) ? loginInfo.getPw() : null;
		logger.info("enc_pw = {}", enc_pw);
		
		if (enc_pw != null) {
			success = encoder.matches(pw, enc_pw);
			
		}
		
		ModelAndView mav = new ModelAndView();
		if (success) {
			page = "main/main";
			session.setAttribute("user_code", loginInfo.getUser_code());
			session.setAttribute("name", loginInfo.getName());
			session.setAttribute("class_name", loginInfo.getClass_name());
			session.setAttribute("team_name", loginInfo.getTeam_name());
			session.setAttribute("team_code", loginInfo.getTeam_code());
			session.setAttribute("classify_code", loginInfo.getClassify_code());
			session.setAttribute("photo", loginInfo.getPhoto());
			logger.info("user_code :{} ", loginInfo.getUser_code());
			
		}else {
			mav.addObject("msg", msg);
		}
		mav.setViewName(page);
		return mav;
		
		
		
		

		
		/*
		 * String enc_pw = loginDAO.loginAccess(id); logger.info("enc_pw=" +enc_pw);
		 * 
		 * boolean success = false; String page = "login/login"; String msg =
		 * "아이디 또는 비밀번호를 확인 하세요";
		 * 
		 * 
		 * if (enc_pw != null) { success = encoder.matches(pw, enc_pw);
		 * 
		 * }
		 * 
		 * ModelAndView mav = new ModelAndView(); if (success) { page = "main/main";
		 * session.setAttribute("loginId", id); logger.info("id:{}", id);
		 * //session.setAttribute("user_code : {}", user_code);
		 * //logger.info("user_code :{}", user_code);
		 * 
		 * 
		 * 
		 * session.setAttribute("user_code", loginInfo.getUser_code());
		 * session.setAttribute("name", loginInfo.getName());
		 * session.setAttribute("class_name", loginInfo.getClass_name());
		 * session.setAttribute("team_name", loginInfo.getTeam_name());
		 * session.setAttribute("team_code", loginInfo.getTeam_code());
		 * session.setAttribute("classify_code", loginInfo.getClassify_code()); String
		 * newFile = loginInfo.getPhoto(); session.setAttribute("photo", newFile);
		 * 
		 * logger.info("status:{}", loginInfo.getUser_code()); logger.info("status:{}",
		 * loginInfo.getName()); logger.info("status:{}", loginInfo.getClass_name());
		 * logger.info("status:{}", loginInfo.getTeam_name()); logger.info("status:{}",
		 * loginInfo.getTeam_code()); logger.info("status:{}",
		 * loginInfo.getClassify_code()); logger.info("photo", newFile);
		 * 
		 * 
		 * } else { mav.addObject("msg", msg); } mav.setViewName(page); return mav;
		 */

	}

}
