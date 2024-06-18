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
	public String loginAccess(HttpSession session, Model model, String id, String pw) {
		logger.info("::최초 로그인 실행::");
		return loginService.loginAccess(session, model, id, pw);
	}
	//로그아웃
	@GetMapping(value ="/logout.do")
	public String logoutAccess(HttpSession session, Model model) {
		logger.info("::로그아웃 실행::");
		session.removeAttribute("user_code");
		session.removeAttribute("user_name");
		session.removeAttribute("class_name");
		session.removeAttribute("team_name");
		session.removeAttribute("team_code");
		session.removeAttribute("classify_code");
		model.addAttribute("msg", "로그아웃 되었습니다.");
		session.invalidate();
		return "login/login";
	}
	
	
	/*//아이디 저장하기
	@GetMapping(value = "/login.go")
	public String loginAccess(HttpServletRequest request) {
		
		String username = "";
		
		Cookie[] cookies = request.getCookies();
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("remember")) {
				username = cookie.getValue();
			}
		}
		request.setAttribute("remember", username);
		return "login/login";*/
	}
	
	
	
	
	
	
	
