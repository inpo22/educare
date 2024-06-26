package com.edu.care.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.service.ApprovalService;

@Controller
public class ApprovalController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ApprovalService approvalService;
	
	@GetMapping(value="/getApproval/list.go")
	public String getApproval() {
		return "approval/getApproval_list";
	}
	
	@GetMapping(value="/compApproval/list.go")
	public String compApproval() {
		return "approval/compApproval_list";
	}
	
	@GetMapping(value="/viewApproval/list.go")
	public String viewApproval() {
		return "approval/viewApproval_list";
	}
	
	@GetMapping(value="/requestApproval/list.go")
	public String requestApproval() {
		return "approval/requestApproval_list";
	}
	
	@GetMapping(value="/finishApproval/list.go")
	public String finishApproval() {
		return "approval/finishApproval_list";
	}
	
	@GetMapping(value="/rejectedApproval/list.go")
	public String rejectedApproval() {
		return "approval/rejectedApproval_list";
	}
	
	@GetMapping(value="/vacaApproval/write.go")
	public String vacaApprovalWriteForm() {
		return "approval/vacaApproval_write";
	}
	
	@GetMapping(value="/busiApproval/write.go")
	public String busiApprovalWriteForm() {
		return "approval/busiApproval_write";
	}
	
	@GetMapping(value="/approval/detail.go")
	public ModelAndView approvalDetail(String au_code, HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		
		return approvalService.approvalDetail(au_code, user_code);
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
	
	@GetMapping(value="/approval/list.ajax")
	@ResponseBody
	public Map<String, Object> approvalListCall(String page, String condition, String content, String listType, HttpSession session) {
		// logger.info("전자 결재 리스트 Call");
		// logger.info("page : " + page);
		// logger.info("condition : " + condition);
		// logger.info("content : " + content);
		// logger.info("listType : " + listType);
		
		String user_code = (String) session.getAttribute("user_code");
		String team_code = (String) session.getAttribute("team_code");
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		Map<String, Object> map = approvalService.approvalListCall(currPage, pagePerCnt, user_code, team_code, condition, content, listType);
		
		return map;
	}
	
	@GetMapping(value="/approval/download")
	public ResponseEntity<Resource> download(String file_no, String new_filename) {
		// logger.info("download fileName : " + fileName);
		return approvalService.download(file_no, new_filename);
	}

	@GetMapping(value="/approval/approve.do")
	public String approve(String au_code, HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		
		approvalService.approve(user_code, au_code);
		String enc_au_code = "";
		
		try {
			enc_au_code = URLEncoder.encode(au_code, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/approval/detail.go?au_code=" + enc_au_code;
	}
	
	@GetMapping(value="/approval/reject.do")
	public String reject(String au_code, HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		
		approvalService.reject(au_code, user_code);
		String enc_au_code = "";
		
		try {
			enc_au_code = URLEncoder.encode(au_code, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/approval/detail.go?au_code=" + enc_au_code;
	}
	
}
