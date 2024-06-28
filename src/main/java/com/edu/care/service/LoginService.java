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
		
		//String enc_pw = (loginInfo != null) ? loginInfo.getPw() : null
		String enc_pw;
		if (loginInfo != null) {
			 enc_pw = loginInfo.getPw();
		}else {
			 enc_pw = null;
		}
		logger.info("enc_pw = {}", enc_pw);
		
		
		if (enc_pw != null) {
			success = encoder.matches(pw, enc_pw);
			
		}
		
		ModelAndView mav = new ModelAndView();
		if (success) {
			//page = "main/superAdminMain";
			session.setAttribute("user_code", loginInfo.getUser_code());
			session.setAttribute("user_name", loginInfo.getName());
			session.setAttribute("class_name", loginInfo.getClass_name());
			session.setAttribute("classify_name", loginInfo.getClassify_name());
			session.setAttribute("classify_code", loginInfo.getClassify_code());
			session.setAttribute("team_name", loginInfo.getTeam_name());
			session.setAttribute("team_code", loginInfo.getTeam_code());
			session.setAttribute("photo", loginInfo.getPhoto());
			logger.info("user_code :{} ", loginInfo.getUser_code());
			logger.info("user_name :{} ", loginInfo.getName());
			logger.info("class_name :{} ", loginInfo.getClass_name());
			logger.info("classify_name :{} ", loginInfo.getClassify_name());
			logger.info("classify_code :{} ", loginInfo.getClassify_code());
			logger.info("team_name :{} ", loginInfo.getTeam_name());
			logger.info("team_code:{}", loginInfo.getTeam_code());
			logger.info("photo :{} ", loginInfo.getPhoto());
			
			page = "redirect:/"; //MainController "/"경로로 이동시킴
			
			String team_code = loginInfo.getTeam_code();
			String classify_code = loginInfo.getClassify_code();
			
			 if (team_code != null) {
	                if (team_code.equals("T001") || team_code.equals("T006")) {
	                    page = "redirect:/main/superAdminMain.go";
	                } else {
	                    page = "redirect:/main/adminMain.go";
	                }
	            } else if (classify_code.equals("U03")) {
	                page = "redirect:/main/stdMain.go";
	            }
			
				}else {
					mav.addObject("msg", msg);
				}
					mav.setViewName(page);
					return mav;	

				}
	public Object idFindAccess(String name, String email) {
		return loginDAO.idFindAccess(name,email);
	}

}
