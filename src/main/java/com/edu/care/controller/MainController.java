package com.edu.care.controller;

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
	public String main() {
		return "main/main";
	}
	
}
