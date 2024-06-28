package com.edu.care.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.edu.care.dao.CourseDAO;
import com.edu.care.dto.CourseDTO;

@Service
public class CourseService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired CourseDAO courseDAO;

	public Map<String, Object> courseList(int currPage, int pagePerCnt, String searchFilter, String searchContent, String showCourse) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<CourseDTO> list = courseDAO.courseList(start, pagePerCnt, searchFilter, searchContent, showCourse);
		logger.info("list : {}", list);
		logger.info("list.size : "+list.size());
		map.put("list",list);
		map.put("totalPage",courseDAO.courseListPageCnt(pagePerCnt, searchFilter, searchContent, showCourse));
		return map;
	}

	public Map<String, Object> reservationTime(Date rez_date, String rez_room) {
		
		List<CourseDTO> dto = courseDAO.reservationTime(rez_date,rez_room);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", dto);

		return map;
	}

	@Transactional
	public Boolean reservationWrite(CourseDTO courseDTO) {
		try {
			int row = courseDAO.courseWrite(courseDTO);
			
			if(row > 0) {
				String course_space = courseDTO.getCourse_space();
				int course_no = courseDTO.getCourse_no();
				List<Date> start_time_array = courseDTO.getStart_time_array();
				List<Date> end_time_array = courseDTO.getEnd_time_array();
				
				for(int i = 0; i < start_time_array.size(); i++) {
					Date start_time = courseDTO.getStart_time_array().get(i);
					Date end_time = courseDTO.getEnd_time_array().get(i);
					courseDAO.reservationCourseWrite(course_no, course_space, start_time, end_time);
					
					logger.info("start_time : {}", start_time);
					logger.info("end_time : {}", end_time);
				}
			}
			return true;
			
		} catch (Exception e) {
			logger.info("CourseService reservationWrite 에러났어용가리!!");
			return false;
		}
		
	}

//	public Map<String, Object> courseDetail(String course_no) {
//		logger.info("##### course courseDetail service IN #####");
//		Map<String, Object> map = new HashMap<String, Object>();
//		List<CourseDTO> dto = courseDAO.courseDetail(course_no);
//		List<Date> start = ((CourseDTO) dto).getStart_time_array();
//		
//		for (Date stratDate : start) {
//			logger.info("stratDate"+stratDate);
//		}
//		
//		map.put("listlist", dto);
//		logger.info("dto:{}",dto);
//		return map;
//	}
	
	
	public List<CourseDTO> courseDetail(int course_no) {
		logger.info("##### course courseDetail service IN #####");
		
		List<CourseDTO> courseList = courseDAO.courseDetail(course_no);
		
		return courseList;
	}

	public int courseDelete(int course_no) {
		int row = courseDAO.courseReservationDelete(course_no);
		logger.info("courseDelete >> " + row);
		if( row > 0) {
			courseDAO.courseHide(course_no);
			logger.info("courseHide >> " + course_no);
		}
		return row;
	}

	public Map<String, Object> courseCheck() {
		Map<String, Object> result = new HashMap<String, Object>();
		List<CourseDTO> list = courseDAO.courseCheck();
		
		result.put("list", list);
		return result;
	}


}
