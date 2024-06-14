package com.edu.care.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.care.dto.ScheduleDTO;
import com.edu.care.service.ScheduleService;

@Controller
public class ScheduleController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ScheduleService scheduleService;
	
	@GetMapping(value="/schedule.go")
	public String schedule() {
		return "schedule/schedule";
	}
	
	@PostMapping(value="/schedule/write.ajax")
	@ResponseBody
	public Map<String, Object> scheduleWrite(@RequestBody ScheduleDTO scheduleDTO, HttpSession session) {
		logger.info("##### schedule write ajax controller IN #####");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int row =  scheduleService.scheduleWrite(scheduleDTO);
		if(row > 0) {
			map.put("row", row);
		}
		
		return map;
	}
	
	@GetMapping(value="/schedule/list.ajax")
	@ResponseBody
	public Map<String, Object> scheduleList(HttpSession session) {
		logger.info("##### schedule list ajax controller IN #####");
		
		Map<String, Object> map = scheduleService.scheduleList();
		return map;
	}
}
