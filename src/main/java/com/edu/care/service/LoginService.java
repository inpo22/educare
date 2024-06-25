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
			//page = "main/superAdminMain";
			session.setAttribute("user_code", loginInfo.getUser_code());
			session.setAttribute("name", loginInfo.getName());
			session.setAttribute("class_name", loginInfo.getClass_name());
			session.setAttribute("classify_name", loginInfo.getClassify_name());
			session.setAttribute("classify_code", loginInfo.getClassify_code());
			session.setAttribute("team_name", loginInfo.getTeam_name());
			session.setAttribute("team_code", loginInfo.getTeam_code());
			session.setAttribute("photo", loginInfo.getPhoto());
			logger.info("user_code :{} ", loginInfo.getUser_code());
			logger.info("name :{} ", loginInfo.getName());
			logger.info("class_name :{} ", loginInfo.getClass_name());
			logger.info("classify_name :{} ", loginInfo.getClassify_name());
			logger.info("classify_code :{} ", loginInfo.getClassify_code());
			logger.info("team_name :{} ", loginInfo.getTeam_name());
			logger.info("team_code:{}", loginInfo.getTeam_code());
			logger.info("photo :{} ", loginInfo.getPhoto());
			
			
			String team_code = loginInfo.getTeam_code();
			String classify_code = loginInfo.getClassify_code();
			
			if (classify_code.equals("U03")) {
				  page = "redirect:/main/stuMain.go";
			}else if (team_code != null) {
				if (team_code.equals("T01") || team_code.equals("T06")) {
					   page = "redirect:/main/superAdminMain.go";
				}else {
						page = "redirect:/main/adminMain.go";
				}
			}
			
		}else {
			mav.addObject("msg", msg);
		}
		mav.setViewName(page);
		return mav;
		
		
		
	

	}

}
