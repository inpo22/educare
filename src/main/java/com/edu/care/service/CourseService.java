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

	public Map<String, Object> courseList(int currPage, int pagePerCnt, String searchFilter, String searchContent) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<CourseDTO> list = courseDAO.courseList(start, pagePerCnt, searchFilter, searchContent);
		logger.info("list : {}", list);
		map.put("list",list);
		return map;
	}

	public Map<String, Object> reservationTime(Date rez_date, String rez_room) {
		
		List<CourseDTO> dto = courseDAO.reservationTime(rez_date,rez_room);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", dto);
		//강의실데이터없을 때 : 아직 예약이 없다는것
		return map;
	}

	/* 강의등록하는중.... 
	 * 강의등록하는중....
	 * 
	 * 아직 안해서 등록눌러도 뭐없음.. 
	 * 날짜배열 결과만보려고 만듬 */
	@Transactional
	public boolean reservationWrite(CourseDTO courseDTO) {
		try {
			//courseDAO.courseWrite(courseDTO);
			String course_space = courseDTO.getCourse_space();
			String user_code = courseDTO.getUser_code();
			List<Date> start_time_array = courseDTO.getStart_time_array();
			List<Date> end_time_array = courseDTO.getEnd_time_array();
			
			logger.info("start_time_array : {}", start_time_array);
			logger.info("end_time_array : {}", end_time_array);
			
			for(int i = 0; i < start_time_array.size(); i++) {
				Date start_time = courseDTO.getStart_time_array().get(i);
				Date end_time = courseDTO.getEnd_time_array().get(i);
				//courseDAO.reservationCourseWrite(user_code, course_space, start_time, end_time);
				
				logger.info("start_time : {}", start_time);
				logger.info("end_time : {}", end_time);
			}
			
			return false;
			
		} catch (Exception e) {
			logger.info("에러나면 reservationWrite 이쪽!!");
			return false;
		}
		
	}
	
}
