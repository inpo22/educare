package com.edu.care.service;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.care.dao.EmpDAO;
import com.edu.care.dto.EmpDTO;

@Service
public class EmpService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired EmpDAO empDAO;
	/*
	public List<EmpDTO> empList() {
		
		List<EmpDTO> result = empDAO.empList();
		return result;
	}
	*/
	
	public Map<String, Object> empList(int currPage, int pagePerCnt, String type, String searchbox, String startDate, String endDate) {
		int start = (currPage-1) * pagePerCnt;
	
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<EmpDTO> list = empDAO.empList(start, pagePerCnt,type,searchbox,startDate,endDate);
		
		logger.info("list : {}", list);
		logger.info("list size : " + list.size());
		result.put("list", list);		
		result.put("totalPage", empDAO.empListPageCnt(pagePerCnt,type,searchbox,startDate,endDate));
		
		return result;
	}

	public int quitEmp(List<String> quitList) {
		int cnt = 0;
		
		for(String user_code : quitList) {
			cnt += empDAO.quitEmp(user_code);
		}
		return cnt;
	}
	
}
