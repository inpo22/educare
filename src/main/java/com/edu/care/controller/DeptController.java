package com.edu.care.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.care.service.DeptService;

@Controller
public class DeptController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired DeptService deptService;
	
	@GetMapping(value="/dept.go")
	public String dept() {
		return "dept/dept";
	}
	
	@GetMapping(value = "/dept/list")
	@ResponseBody
	public Map<String, Object> getDept(){
		logger.info(":: 부서 리스트 ::");
		return deptService.getDept();
	}
	
}
