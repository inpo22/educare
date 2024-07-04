package com.edu.care.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.service.CommuteService;

@Controller
public class CommuteController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired CommuteService commuteService;
	
	@GetMapping(value="/commuteState.go")
	public ModelAndView commuteState(HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		
		return commuteService.commuteState(user_code);
	}
	
	@GetMapping(value="/vacaHistory.go")
	public String vacaHistory(HttpSession session, Model model) {
		String user_code = (String) session.getAttribute("user_code");
		commuteService.vacaHistory(user_code, model);
		return "commute/vaca_history";
	}
	
	// 연차 리스트 불러오기
	@PostMapping(value="/vacaHistory/list.ajax")
	@ResponseBody
	public Map<String, Object> vacaUseList(String page, HttpSession session){
		String user_code = (String) session.getAttribute("user_code");
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 5;
		
		Map<String, Object> map = commuteService.vacaUseList(currPage, pagePerCnt, user_code);
		return map;
	}
	
	@GetMapping(value="/commuteState/att/List.ajax")
	@ResponseBody
	public Map<String, Object> attList(String page, String start_date, String end_date, HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 5;
		
		return commuteService.attList(currPage, pagePerCnt, start_date, end_date, user_code);
	}
	
	@GetMapping(value="/commuteState/attendance.do")
	public String attendance(HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		commuteService.attendance(user_code);
		
		return "redirect:/commuteState.go";
	}
	
	@GetMapping(value="/commuteState/leaveWork.do")
	public String leaveWork(HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		commuteService.leaveWork(user_code);
		
		return "redirect:/commuteState.go";
	}
	
}
