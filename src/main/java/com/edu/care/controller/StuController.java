package com.edu.care.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.care.service.StuService;

@Controller
public class StuController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired StuService stuService;
	
	@GetMapping(value="/std/list.go")
	public String stuList() {
		return "std/std_list";
	}
	
	// 학생 리스트 불러오기(비동기)
	@ResponseBody
	@PostMapping(value="/std/list.ajax")
	public Map<String, Object> stdListCall(String page, String type, String searchbox, String startDate, String endDate){
		logger.info("page: "+page);
		logger.info("type: "+type);
		logger.info("searchbox: "+searchbox);
		logger.info("startDate: "+startDate);
		logger.info("endDate: "+endDate);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		Map<String, Object> map = stuService.stdList(currPage, pagePerCnt, type, searchbox, startDate, endDate);
		
		return map;
	}
	
	// 학생 등록 페이지 이동
	@GetMapping(value="/std/reg.go")
	public String regForm() {
		return "std/std_reg";
	}
	
	// 학생 상세보기 페이지 이동
	@GetMapping(value="/std/detail.go")
	public String stdDetail() {
		return "std/std_detail_course";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
