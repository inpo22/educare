package com.edu.care.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.service.MailService;

@Controller
public class MailController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MailService mailService;
	
	@GetMapping(value="/receivedMail/list.go")
	public String receivedMail() {
		return "mail/recevicedMail_list";
	}
	
	@GetMapping(value="/writtenMail/list.go")
	public String writtenMail() {
		return "mail/writtenMail_list";
	}
	
	@GetMapping(value="/mail/detail.go")
	public ModelAndView mailDetail(String mail_no, String is_read_receiver, HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		
		return mailService.mailDetail(mail_no, is_read_receiver, user_code);
	}
	
	@GetMapping(value="/mail/write.go")
	public String mailWriteForm(String mail_no, String writeType) {
		return "mail/mail_write";
	}
	
	@GetMapping(value="/receivedMail/list.ajax")
	@ResponseBody
	public Map<String, Object> receivedMailListCall(String page, String condition, String content, HttpSession session) {
		logger.info("받은 메일 리스트 Call");
		logger.info("page : " + page);
		logger.info("condition : " + condition);
		logger.info("content : " + content);
		
		String user_code = (String) session.getAttribute("user_code");
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 15;
		
		Map<String, Object> map = mailService.receivedMailListCall(currPage, pagePerCnt, user_code, condition, content);
		
		return map;
	}
	
	@PostMapping(value="/receivedMail/read.ajax")
	@ResponseBody
	public Map<String, Object> receivedMailListRead(@RequestParam(value="readList[]") List<String> readList, HttpSession session) {
		logger.info("readList : {}", readList);
		
		String user_code = (String) session.getAttribute("user_code");
		
		mailService.receivedMailListRead(readList, user_code);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "완료");
		
		return map;
	}
	
	@PostMapping(value="/receivedMail/delete.ajax")
	@ResponseBody
	public Map<String, Object> receivedMailListDel(@RequestParam(value="delList[]") List<String> delList, HttpSession session) {
		logger.info("delList : {}", delList);
		
		String user_code = (String) session.getAttribute("user_code");
		
		int cnt = mailService.receivedMailListDel(delList, user_code);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cnt", cnt);
		
		return map;
	}
	
	@GetMapping(value="/writtenMail/list.ajax")
	@ResponseBody
	public Map<String, Object> writtenMailListCall(String page, String condition, String content, HttpSession session) {
		logger.info("보낸 메일 리스트 Call");
		logger.info("page : " + page);
		logger.info("condition : " + condition);
		logger.info("content : " + content);
		
		String user_code = (String) session.getAttribute("user_code");
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 15;
		
		Map<String, Object> map = mailService.writtenMailListCall(currPage, pagePerCnt, user_code, condition, content);
		
		return map;
	}
	
	@PostMapping(value="/writtenMail/delete.ajax")
	@ResponseBody
	public Map<String, Object> writtenMailListDel(@RequestParam(value="delList[]") List<String> delList) {
		logger.info("delList : {}", delList);
		
		int cnt = mailService.writtenMailListDel(delList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cnt", cnt);
		
		return map;
	}
	
	@RequestMapping(value="/mail/download/{fileName}")
	public ResponseEntity<Resource> download(@PathVariable String fileName) {
		// logger.info("download fileName : " + fileName);
		return mailService.download(fileName);
	}
	
	@GetMapping(value="/mail/deptList.ajax")
	@ResponseBody
	public Map<String, Object> deptList() {
		return mailService.deptList();
	}
	
}
