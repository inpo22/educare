package com.edu.care.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.edu.care.service.StuService;

@Controller
public class StuController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired StuService stuService;
	
	@GetMapping(value="/std/list.go")
	public String stuList() {
		return "std/std_list";
	}
	
}
