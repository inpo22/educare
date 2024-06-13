package com.edu.care.controller;

import java.util.HashMap;
import java.util.List;
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

import com.edu.care.service.MailService;

@Controller
public class MailController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MailService mailService;
	
	@GetMapping(value="/receivedMail/list.go")
	public String receivedMail() {
		return "mail/recevicedMail_list";
	}
	
	@GetMapping(value="/receivedMail/list.ajax")
	@ResponseBody
	public Map<String, Object> receivedMailListCall(String page, HttpSession session) {
		logger.info("받은 메일 리스트 Call");
		logger.info("page : " + page);
		
		String user_code = (String) session.getAttribute("user_code");
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		Map<String, Object> map = mailService.receivedMailListCall(currPage, pagePerCnt, user_code);
		
		return map;
	}
	
	@PostMapping(value="/receivedMail/read.ajax")
	@ResponseBody
	public Map<String, Object> mailListRead(@RequestParam(value="readList[]") List<String> readList, HttpSession session) {
		logger.info("readList : {}", readList);
		
		mailService.mailListRead(readList);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "완료");
		
		return map;
	}
	
	@PostMapping(value="/receivedMail/delete.ajax")
	@ResponseBody
	public Map<String, Object> mailListDel(@RequestParam(value="delList[]") List<String> delList, HttpSession session) {
		logger.info("delList : {}", delList);
		
		int cnt = mailService.mailListDel(delList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cnt", cnt);
		
		return map;
	}
	
}
