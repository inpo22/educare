package com.edu.care.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@GetMapping(value="/commute/att/List.ajax")
	@ResponseBody
	public Map<String, Object> attList(String page, String start_date, String end_date, HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 5;
		
		return commuteService.attList(currPage, pagePerCnt, start_date, end_date, user_code);
	}
	
}
