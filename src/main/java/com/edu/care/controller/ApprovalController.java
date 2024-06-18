package com.edu.care.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.edu.care.service.ApprovalService;

@Controller
public class ApprovalController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ApprovalService approvalService;
	
	@GetMapping(value="/getApproval/list.go")
	public String getApproval() {
		return "approval/getApproval_list";
	}
	
	@GetMapping(value="/vacaApproval/write.go")
	public String vacaApprovalWriteForm() {
		return "approval/vacaApproval_write";
	}
	
	@GetMapping(value="/busiApproval/write.go")
	public String busiApprovalWriteForm() {
		return "approval/busiApproval_write";
	}
	
	@GetMapping(value="/approval/deptList.ajax")
	@ResponseBody
	public Map<String, Object> deptList() {
		return approvalService.deptList();
	}
	
	@PostMapping(value="/vacaApproval/write.do")
	public String vacaApprovalWrite(@RequestParam(value="attachFile") MultipartFile[] attachFile, 
			@RequestParam Map<String, String> param, HttpSession session) {
		String page = "";
		String user_code = (String) session.getAttribute("user_code");
		String team_code = (String) session.getAttribute("team_code");
		
		boolean result = approvalService.vacaApprovalWrite(attachFile, param, user_code, team_code);
		
		if (result) {
			page = "redirect:/getApproval/list.go";
		}
		
		return page;
	}
	
	@PostMapping(value="/busiApproval/write.do")
	public String busiApprovalWrite(@RequestParam(value="attachFile") MultipartFile[] attachFile, 
			@RequestParam Map<String, String> param, HttpSession session) {
		String page = "";
		String user_code = (String) session.getAttribute("user_code");
		String team_code = (String) session.getAttribute("team_code");
		
		boolean result = approvalService.busiApprovalWrite(attachFile, param, user_code, team_code);
		
		if (result) {
			page = "redirect:/getApproval/list.go";
		}
		
		return page;
	}
	
}
