package com.edu.care.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.dao.CommuteDAO;
import com.edu.care.dto.CommuteDTO;

@Service
public class CommuteService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	CommuteDAO commuteDAO;
	
	public ModelAndView commuteState(String user_code) {
		ModelAndView mav = new ModelAndView("commute/commute_state");
		CommuteDTO todayAtt = commuteDAO.todayAtt(user_code);
		CommuteDTO monthAtt = commuteDAO.monthAtt(user_code);
		
		mav.addObject("todayAtt", todayAtt);
		mav.addObject("monthAtt", monthAtt);
		
		return mav;
	}

	public Map<String, Object> vacaUseList(int currPage, int pagePerCnt, String user_code) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<CommuteDTO> list = commuteDAO.vacaUseList(start, pagePerCnt, user_code);
		
		result.put("list", list);
		result.put("totalPage", commuteDAO.vacaListPageCnt(pagePerCnt, user_code));
		
		return result;
	}

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

	public void vacaHistory(String user_code, Model model) {
		CommuteDTO dto = commuteDAO.vacaHistory(user_code);
		dto.setUser_code(user_code);
		model.addAttribute("dto",dto);
	}

	public void attendance(String user_code) {
		commuteDAO.attendance(user_code);
	}
	
	@Transactional
	public void leaveWork(String user_code) {
		commuteDAO.leaveWork(user_code);
		int state = commuteDAO.stateCheck(user_code);
		if (state > 0) {
			commuteDAO.stateUpdate(user_code, state);
		}
		
	}
	
}



