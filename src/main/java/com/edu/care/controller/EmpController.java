package com.edu.care.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.edu.care.service.EmpService;

@Controller
public class EmpController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired EmpService empService;
	
	@GetMapping(value="/emp/list.go")
	public String empList() {
		return "emp/emp_list";
	}
	
}
