package com.edu.care.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;


import com.edu.care.service.LoginService;

@Controller
public class LoginController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	LoginService loginService;
	
	/*@GetMapping(value = "/")
	public String home() {
		return "login";
	}*/
	
}