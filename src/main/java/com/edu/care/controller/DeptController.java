package com.edu.care.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.edu.care.service.DeptService;

@Controller
public class DeptController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired DeptService deptService;
	
	@GetMapping(value="/dept.go")
	public String dept() {
		return "dept/dept";
	}
	
}
