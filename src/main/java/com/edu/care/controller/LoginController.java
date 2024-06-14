package com.edu.care.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.care.service.LoginService;

@Controller
public class LoginController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	LoginService loginService;
	
	@GetMapping(value = "/login.go")
	public String login() {
		logger.info("::최초 로그인 페이지::");
		return "login/login";
	}
	//로그인
	@PostMapping(value ="/login.do")
	public String loginAccess(HttpSession session, Model model, String id, String pw,
			RedirectAttributes redirectAttributes) {
		logger.info("::최초 로그인 실행::");
		return loginService.loginAccess(session, model, id, pw, redirectAttributes);
	}
	
	
	
	
	
	
	
}