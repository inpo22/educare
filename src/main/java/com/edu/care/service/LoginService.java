package com.edu.care.service;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.care.dao.LoginDAO;


@Service
public class LoginService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired LoginDAO loginDAO;
	

	public  String loginAccess(HttpSession session, Model model, String id, String pw, String name, String classify_code,
		RedirectAttributes redirectAttributes) {
		logger.info("id : {} / name : {}", id, pw);
		String msg="아이디 또는 비밀번호를 다시 확인하세요";
		//String page="main/main";
		//LoginService loginservice = new LoginService();
		
		int row = loginDAO.loginAccess(id,pw, name, classify_code, redirectAttributes);
		if(row >0) {
			session.setAttribute("mem_Id", id);
			session.setAttribute("mem_pw", pw);
			session.setAttribute("mem_name", name);
			session.setAttribute("mem_class_code", classify_code);
			//model.addAttribute("loginId", id);
			model.addAttribute("loginSuccess", id+ "로그인 성공");
			logger.info("id2 : {} / name2 : {}", id, pw);
			return "redirect:/";
		}else {
			redirectAttributes.addFlashAttribute("loginError", true);
			return "redirect:/login.go";
			
		}
	}




	

}
