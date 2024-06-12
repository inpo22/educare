package com.edu.care.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

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
	
}
