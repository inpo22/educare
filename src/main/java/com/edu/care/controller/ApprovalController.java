package com.edu.care.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.edu.care.service.ApprovalService;

@Controller
public class ApprovalController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ApprovalService approvalService;
	
	@GetMapping(value="/getApproval/list.go")
	public String getApproval() {
		return "approval/getApproval_list";
	}
	
}
