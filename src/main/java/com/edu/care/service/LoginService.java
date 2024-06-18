package com.edu.care.service;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.edu.care.dao.LoginDAO;
import com.edu.care.dto.LoginDTO;


@Service
public class LoginService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired LoginDAO loginDAO;
	

	public  String loginAccess(HttpSession session, Model model, String id, String pw) {
		logger.info("id : {} / pw : {}", id, pw);
		//String msg="아이디 또는 비밀번호를 다시 확인하세요";
		
		int logininfo = loginDAO.loginAccess(id, pw);
		
		
		
		int row = loginDAO.loginAccess(id,pw);
		if(row >0) {
			/*session.setAttribute("user_code", "user_code");
			session.setAttribute("user_name", "user_name");
			session.setAttribute("class_name", "class_name");
			session.setAttribute("team_name", "team_name");
			session.setAttribute("team_code", "team_code");
			session.setAttribute("classify_code", "classify_code");*/
		
			/*
			 * model.addAttribute("loginSuccess", id+ "로그인 성공");
			 * logger.info("id2 : {} / pw2 : {}", id, pw); logger.info("user_code: {}",
			 * logininfo.getUser_code()); logger.info("name: {}", logininfo.getName());
			 * logger.info("class_name: {}", logininfo.getClass_name());
			 * logger.info("team_name: {}", logininfo.getTeam_name());
			 * logger.info("classify_code: {}", logininfo.getClassify_code());
			 */
			return "redirect:/";
		}else {
			model.addAttribute("msgdo", "아이디 또는 비밀번호를 확인해주세요");
			
		}
		return "/login/login";
	}




	

}
