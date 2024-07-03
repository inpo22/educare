package com.edu.care.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.care.service.CommuteService;

@Controller
public class CommuteController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired CommuteService commuteService;
	
	@GetMapping(value="/commuteState.go")
	public String commuteState() {
		return "commute/commute_state";
	}
	
	@GetMapping(value="/vacaHistory.go")
	public String vacaHistory() {
		return "commute/vaca_history";
	}
	
	// 연차 리스트 불러오기
	@PostMapping(value="/vacaHistory/list.ajax")
	@ResponseBody
	public Map<String, Object> vacaUseList(String page, HttpSession session){
		String user_code = (String) session.getAttribute("user_code");
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 5;
		
		Map<String, Object> map = commuteService.vacaUseList(currPage, pagePerCnt, user_code);
		return map;
	}
	
	
	
}















