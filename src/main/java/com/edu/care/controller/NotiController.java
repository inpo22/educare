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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.care.service.NotiService;

@Controller
public class NotiController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired NotiService notiService;
	
	@GetMapping(value = "noti/list.ajax")
	@ResponseBody
	public Map<String, Object> getNotis(HttpSession session){
		logger.info(":: 알림 리스트 ::");
		String user_code = (String) session.getAttribute("user_code");
		String team_code = (String) session.getAttribute("team_code");
		logger.info("user_code:",user_code,"/ team_cod:",team_code);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("user_code", user_code);
		param.put("team_code", team_code);
		logger.info("param:",param);

		return notiService.getNotis(param);
	}
	
	@PostMapping(value = "noti/read.ajax")
	@ResponseBody
	public Map<String, Object> readNotis(@RequestParam Map<String, Object> param){
		logger.info(":: 알림 읽기 ::");
		logger.info("param: "+param.get("noti_no"));
		return notiService.readNotis(param);
	}
}
