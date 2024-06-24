package com.edu.care.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.care.dao.CourseDAO;
import com.edu.care.dto.CourseDTO;

@Service
public class CourseService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired CourseDAO courseDAO;

	public Map<String, Object> courseList() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CourseDTO> list = courseDAO.courseList();
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
	
}
