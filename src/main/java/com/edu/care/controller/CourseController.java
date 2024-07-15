package com.edu.care.controller;

import java.util.Date;
import java.util.HashMap;
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
	public Map<String, Object> courseList(String page, String searchFilter, String searchContent, String showCourse, HttpSession session) {
		//logger.info("##### course list ajax controller IN #####");
		//logger.info("searchFilter : " + searchFilter);
		//logger.info("searchContent : "+ searchContent);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		Map<String, Object> map =  courseService.courseList(currPage,pagePerCnt,searchFilter,searchContent, showCourse);
		
		return map;
	}
	
	@PostMapping(value="/course/reservationTime.ajax")
	@ResponseBody
	public Map<String, Object> reservationTime(@RequestBody CourseDTO courseDTO, HttpSession session) {
		//logger.info("##### course reservationTime ajax controller IN #####");
		
		Date rez_date = courseDTO.getStart_time();
		String rez_room = courseDTO.getCourse_space();
		
		Map<String, Object> result = courseService.reservationTime(rez_date,rez_room);
		
		return result;
	}
	
	@PostMapping(value="/course/reservationWrite.ajax")
	@ResponseBody
	public Map<String, String> reservationWrite(@RequestBody CourseDTO courseDTO, HttpSession session) {
		//logger.info("##### course reservationWrite ajax controller IN #####");
		
		Boolean result = courseService.reservationWrite(courseDTO);
		//logger.info("##### result=> ",result);
		
		Map<String, String> map = new HashMap<String, String>();
		
		if(result) {
			 map.put("result", "success");
		}else {
			 map.put("result", "fail");
		}
		return map;
	}

	@GetMapping(value="/course/detail.go")
	public ModelAndView courseDetail(@RequestParam("course_no") int course_no) {
		//logger.info("##### course courseDetail controller IN #####");
		//logger.info("##### course_no >>> "+course_no);
		ModelAndView mv = new ModelAndView();
		//int course_no_int = Integer.parseInt(String.valueOf(course_no));
		List<CourseDTO> courseList = courseService.courseDetail(course_no);
		  
		mv.addObject("courseDTO",courseList);
        mv.setViewName("course/course_detail");
		
		return mv;
	}
	
	@GetMapping(value="/course/delete.go")
	public ModelAndView courseDelete(@RequestParam("course_no") int course_no) {
		//logger.info("##### course courseDelete controller IN #####");
		//logger.info("##### course_no >>> "+course_no);
		ModelAndView mv = new ModelAndView();
		//int course_no_int = Integer.parseInt(String.valueOf(course_no));
		courseService.courseDelete(course_no);
		
		mv.setViewName("course/course_list");
		
		return mv;
	}
	
	@PostMapping(value="/course/check.ajax")
	@ResponseBody
	public Map<String, Object> courseCheck(@RequestParam(value="course_space", required=false) String course_space, HttpSession session) {
		//logger.info("##### schedule list ajax controller IN #####");
		//logger.info("##### course_space : ", course_space);
		
		Map<String, Object> map = courseService.courseCheck();
		return map;
	}
	
	@PostMapping(value="/course/checkUserCode.ajax")
	@ResponseBody
	public Map<String, Object> checkUserCode(@RequestParam(value="user_code") String user_code, HttpSession session) {
		//logger.info("##### course checkUserCode ajax controller IN #####");
		//logger.info("##### user_code=> ",user_code);
		Boolean result = courseService.checkUserCode(user_code);
		//logger.info("##### result=> ",result);
		
		Map<String, Object> list = courseService.checkUserCodeInfo(user_code);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result) {
			 map.put("list", list);
			 map.put("result", "success");
		}else {
			 map.put("result", "fail");
		}
		
		return map;
	}
	
	@GetMapping(value="/course/update.go")
	public ModelAndView courseUpdate(@RequestParam("course_no") int course_no) {
		//logger.info("##### course courseUpdate controller IN #####");
		//logger.info("##### course_no >>> "+course_no);
		ModelAndView mv = new ModelAndView();
		//int course_no_int = Integer.parseInt(String.valueOf(course_no));
		List<CourseDTO> courseList = courseService.courseDetail(course_no);
		  
		
		mv.addObject("courseDTO",courseList);
        mv.setViewName("course/course_update");
		
		return mv;
	}
	
	@PostMapping(value="/course/update.ajax")
	@ResponseBody
	public Map<String, String> courseUpdateAjax(@RequestBody CourseDTO courseDTO, HttpSession session) {
		//logger.info("##### course courseUpdate Ajax controller IN #####");
		
		int course_no = courseDTO.getCourse_no();
		String course_name  = courseDTO.getCourse_name();
		String course_con = courseDTO.getCourse_con();
		
		Boolean result = courseService.courseUpdateAjax(courseDTO);
		//logger.info("##### result=> ",result);
		
		Map<String, String> map = new HashMap<String, String>();
		
		if(result) {
			 map.put("result", "success");
		}else {
			 map.put("result", "fail");
		}
		return map;
	}

	@GetMapping(value="/scheduleStu.go")
	public String scheduleStu() {
		return "course/courseReservationStu";
	}
	
	@PostMapping(value="/course/stuCheck.ajax")
	@ResponseBody
	public Map<String, Object> courseStuCheck(HttpSession session) {
		//logger.info("##### schedule courseStuCheck list ajax controller IN #####");
		String userCode = (String)session.getAttribute("user_code");
		Map<String, Object> map = courseService.courseStuCheck(userCode);
		return map;
	}
	
	@PostMapping(value="/course/getCourseSpaceList.ajax")
	@ResponseBody
	public Map<String, Object> getCourseSpaceList(HttpSession session) {
		//logger.info("##### schedule courseStuCheck list ajax controller IN #####");
		List<CourseDTO> spaceList = courseService.getCourseSpaceList();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("spaceList", spaceList);
		
		return map;
	}
}
