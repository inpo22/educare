package com.edu.care.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.edu.care.service.CourseService;

@Controller
public class CourseController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired CourseService courseService;
	
	@GetMapping(value="/course/list.go")
	public String courseList() {
		return "course/course_list";
	}
	
	@GetMapping(value="/courseReservation.go")
	public String courseReservation() {
		return "course/courseReservation";
	}
	
}
