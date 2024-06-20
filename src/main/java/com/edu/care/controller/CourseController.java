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

import com.edu.care.dto.ScheduleDTO;
import com.edu.care.service.CourseService;

@Controller
public class CourseController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired CourseService courseService;
	
	@GetMapping(value="/course/list.go")
	public String courseList() {
		return "course/course_list";
	}
	
	@GetMapping(value="/course/write.go")
	public String courseWrtie() {
		return "course/course_write";
	}
	
	@GetMapping(value="/courseReservation.go")
	public String courseReservation() {
		return "course/courseReservation";
	}
	
	@GetMapping(value="/course/list.ajax")
	@ResponseBody
	public Map<String, Object> courseList(HttpSession session) {
		logger.info("##### course list ajax controller IN #####");
		
		Map<String, Object> map =  courseService.courseList();
		
		return map;
	}
}
