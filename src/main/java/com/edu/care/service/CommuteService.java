package com.edu.care.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.care.dao.CommuteDAO;
import com.edu.care.dto.CommuteDTO;

@Service
public class CommuteService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired CommuteDAO commuteDAO;

	public Map<String, Object> attList(int currPage, int pagePerCnt, String start_date, String end_date,
			String user_code) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		int start = (currPage - 1) * pagePerCnt;
		int totalPage = 0;
		
		List<CommuteDTO> list = commuteDAO.attList(start, pagePerCnt, user_code, start_date, end_date);
		totalPage = commuteDAO.attListPageCnt(pagePerCnt, user_code, start_date, end_date);
		
		result.put("list", list);
		result.put("totalPage", totalPage);
		
		return result;
	}
	
}
