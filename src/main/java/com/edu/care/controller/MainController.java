package com.edu.care.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.edu.care.service.MainService;

@Controller
public class MainController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MainService mainService;
	
	@GetMapping(value="/")
	public String main(HttpSession session) {
		if (session.getAttribute("user_code") == null) {
			session.setAttribute("user_code", "2024U010001");
			session.setAttribute("user_name", "관리자");
			session.setAttribute("class_name", "대리");
			session.setAttribute("team_name", "인사총무팀");
			session.setAttribute("team_code", "T06");
			session.setAttribute("classify_code", "U01");
		}
		return "main/main";
	}
	
}
