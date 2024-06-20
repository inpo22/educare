package com.edu.care.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.care.dao.StuDAO;
import com.edu.care.dto.StuDTO;

@Service
public class StuService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired StuDAO stuDAO;

	public Map<String, Object> stdList(int currPage, int pagePerCnt, String type, String searchbox, String startDate,
			String endDate) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<StuDTO> list = stuDAO.stdList(start, pagePerCnt, type, searchbox, startDate, endDate);
		logger.info("list :"+list);
		logger.info("list.size : "+list.size());
		
		result.put("list", list);
		result.put("totalPage", stuDAO.stdListPageCnt(pagePerCnt, type, searchbox, startDate, endDate));
		
		return result;
	}
	
}
