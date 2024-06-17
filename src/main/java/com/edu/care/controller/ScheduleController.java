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
		
		String user_code = (String) session.getAttribute("user_code");
		String team_code = (String) session.getAttribute("team_code");
		
		scheduleDTO.setUser_code(user_code);
		scheduleDTO.setTeam_code(team_code);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int row =  scheduleService.scheduleWrite(scheduleDTO);
		if(row > 0) {
			map.put("row", row);
		}
		
		return map;
	}
	
	@PostMapping(value="/schedule/list.ajax")
	@ResponseBody
	public Map<String, Object> scheduleList(@RequestParam(value="sked_type", required=false) String sked_type, HttpSession session) {
		logger.info("##### schedule list ajax controller IN #####");
		logger.info("##### sked_type : ", sked_type);
		
		ScheduleDTO scheduleDTO = new ScheduleDTO();
		scheduleDTO.setUser_code((String) session.getAttribute("user_code"));
		scheduleDTO.setTeam_code((String) session.getAttribute("team_code"));
		scheduleDTO.setSked_type(sked_type);
		
		
		Map<String, Object> map = scheduleService.scheduleList(scheduleDTO);
		return map;
	}
	
	@PostMapping(value="/schedule/delete.ajax")
	@ResponseBody
	public Map<String, Object> scheduleDelete(@RequestParam(value="sked_no") String sked_no, HttpSession session) {
		logger.info("##### schedule delete ajax controller IN #####");
		logger.info("sked_no:{}",sked_no);
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		int row =  scheduleService.scheduleDelete(sked_no);
		if(row > 0) {
			map.put("row", row);
		}
		
		return map;
	}
	
	@PostMapping(value="/schedule/update.ajax")
	@ResponseBody
	public Map<String, Object> scheduleUpdate(@RequestParam(value="sked_no") String sked_no, HttpSession session) {
		logger.info("##### schedule update ajax controller IN #####");
		logger.info("sked_no:{}",sked_no);
		
		ScheduleDTO scheduleDTO = new ScheduleDTO();
		scheduleDTO.setUser_code((String)session.getAttribute("user_code"));
		scheduleDTO.setTeam_code((String) session.getAttribute("team_code"));
		scheduleDTO.setSked_no(Integer.parseInt(sked_no));
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String result;
		Boolean trueFalse =  scheduleService.scheduleUpdate(scheduleDTO);
		
		if(trueFalse) {
			result="success";
		}else {
			result="fail";
		}
		map.put("result", result);
		
		return map;
	}
}
