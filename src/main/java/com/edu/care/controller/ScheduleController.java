package com.edu.care.controller;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String schedule(HttpSession session) {
		String page = "";
		String classify_code = (String) session.getAttribute("classify_code");
		if (classify_code.equals("U01") || classify_code.equals("U02")) {
			page = "schedule/schedule";
		} else {
			page = "redirect:/scheduleStu.go";
		}
		
		return page;
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
	public Map<String, Object> scheduleDelete(@RequestParam(value="sked_no") String sked_no, @RequestParam(value="sked_type") String sked_type,HttpSession session) {
		logger.info("##### schedule delete ajax controller IN #####");
		logger.info("sked_no:{}",sked_no);
		logger.info("sked_typ:{}",sked_type);
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		int row =  scheduleService.scheduleDelete(sked_no,sked_type);
		if(row > 0) {
			map.put("row", row);
		}
		
		return map;
	}
	
	@PostMapping(value="/schedule/update.ajax")
	@ResponseBody
	public Map<String, Object> scheduleUpdate(@RequestBody ScheduleDTO scheduleDTO, HttpSession session) {
		logger.info("##### schedule update ajax controller IN #####");
		
		scheduleDTO.setUser_code((String)session.getAttribute("user_code"));
		scheduleDTO.setTeam_code((String) session.getAttribute("team_code"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Boolean trueFalse =  scheduleService.scheduleUpdate(scheduleDTO);
		
		map.put("result", trueFalse);
		
		return map;
	}
	
}
