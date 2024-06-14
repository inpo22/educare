package com.edu.care.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.care.dao.ScheduleDAO;
import com.edu.care.dto.ScheduleDTO;

@Service
public class ScheduleService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ScheduleDAO scheduleDAO;

	public int scheduleWrite(ScheduleDTO scheduleDTO) {
		return scheduleDAO.scheduleWrite(scheduleDTO);
	}

	public Map<String, Object> scheduleList() {
		Map<String, Object> result = new HashMap<String, Object>();
		List<ScheduleDTO> list = scheduleDAO.scheduleList();
		result.put("list", list);
		return result;
	}
	
}
