package com.edu.care.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.edu.care.service.ScheduleService;

@Controller
public class ScheduleController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ScheduleService scheduleService;
	
	@GetMapping(value="/schedule.go")
	public String schedule() {
		return "schedule/schedule";
	}
	
}
