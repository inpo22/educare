package com.edu.care.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.dao.MainDAO;
import com.edu.care.dto.MainDTO;

@Service
public class MainService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MainDAO mainDAO;
	

	public ModelAndView superAdminMain(String user_code, String team_code) {
		ModelAndView mav = new ModelAndView("main/superAdminMain");
		
		List<MainDTO> approvalList = mainDAO.approvalList(user_code);
		List<MainDTO> mailList = mainDAO.mailList(user_code);
		List<MainDTO> scheduleList = mainDAO.scheduleList(user_code, team_code);
		List<MainDTO> boardList = mainDAO.boardList();
		MainDTO hrd = mainDAO.thisMonthHRD();
		
		mav.addObject("approvalList", approvalList);
		mav.addObject("mailList", mailList);
		mav.addObject("scheduleList", scheduleList);
		mav.addObject("boardList", boardList);
		mav.addObject("hrd", hrd);
		
		return mav;
	}

	public Map<String, Object> chartList(String months) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String[] monthArr = months.split(",");
		
		String first = monthArr[0];
		String second = monthArr[1];
		String third = monthArr[2];
		String fourth = monthArr[3];
		String fifth = monthArr[4];
		String sixth = monthArr[5];
		
		List<MainDTO> dataList = mainDAO.chartDataList(first, second, third, fourth, fifth, sixth);
		
		result.put("dataList", dataList);
		
		return result;
	}
	
}
