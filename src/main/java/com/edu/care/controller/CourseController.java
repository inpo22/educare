package com.edu.care.controller;

import java.util.Date;
import java.util.List;
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
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.dto.CourseDTO;
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
	public Map<String, Object> courseList(String page, String searchFilter, String searchContent, HttpSession session) {
		logger.info("##### course list ajax controller IN #####");
		logger.info("searchFilter : " + searchFilter);
		logger.info("searchContent : "+ searchContent);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		Map<String, Object> map =  courseService.courseList(currPage,pagePerCnt,searchFilter,searchContent);
		
		return map;
	}
	
	@PostMapping(value="/course/reservationTime.ajax")
	@ResponseBody
	public Map<String, Object> reservationTime(@RequestBody CourseDTO courseDTO, HttpSession session) {
		logger.info("##### course reservationTime ajax controller IN #####");
		
		Date rez_date = courseDTO.getStart_time();
		String rez_room = courseDTO.getCourse_space();
		
		Map<String, Object> result = courseService.reservationTime(rez_date,rez_room);
		
		return result;
	}
	
	@PostMapping(value="/course/reservationWrite.ajax")
	@ResponseBody
	public String reservationWrite(@RequestBody CourseDTO courseDTO, HttpSession session) {
		logger.info("##### course reservationWrite ajax controller IN #####");
		
		Boolean result = courseService.reservationWrite(courseDTO);
		logger.info("##### result=> ",result);
		
		if(result) {
			return "success";
		}else {
			return "fail";
		}
		
	}
	
	@GetMapping(value="/course/detail.go")
	public ModelAndView courseDetail(@RequestParam("course_no") String course_no, ModelAndView mv) {
		logger.info("##### course courseDetail controller IN #####");
		logger.info("##### course_no >>> "+course_no);
		
		//int course_no_int = Integer.parseInt(String.valueOf(course_no));
		List<CourseDTO> courseDTO = courseService.courseDetail(course_no);
		logger.info("##### courseDTO:{}",courseDTO);
		
		mv.addObject("courseDTO",courseDTO);
		mv.setViewName("course/course_detail");
		return mv;
	}
	
}
