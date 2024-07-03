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

	@Autowired
	CommuteDAO commuteDAO;

	public Map<String, Object> vacaUseList(int currPage, int pagePerCnt, String user_code) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<CommuteDTO> list = commuteDAO.vacaUseList(start, pagePerCnt, user_code);
		
		result.put("list", list);
		result.put("totalPage", commuteDAO.vacaListPageCnt(pagePerCnt, user_code));
		
		return result;
	}

}
