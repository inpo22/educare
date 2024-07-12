package com.edu.care.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.service.MainService;

@Controller
public class MainController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MainService mainService;
	
	@GetMapping(value="/")
	public String main(HttpSession session) {
		String page = "";
		
		if (session.getAttribute("user_code") == null) {
			page = "redirect:/login.go";
		} else {
			String team_code = (String) session.getAttribute("team_code");
			String classify_code = (String) session.getAttribute("classify_code");
			
			
			if (team_code != null) {
				if (team_code.equals("T001") || team_code.equals("T006")) {
					page = "redirect:/main/superAdminMain.go";
				} else {
					page = "redirect:/main/adminMain.go";
				}
			}
			if (classify_code.equals("U03") ) {
				page = "redirect:/main/stdMain.go";
			}
		}
		
		return page;
	}
	
	@GetMapping(value="/main/superAdminMain.go")
	public ModelAndView superAdminMain(HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		String team_code = (String) session.getAttribute("team_code");
		
		return mainService.superAdminMain(user_code, team_code);
	}
	
	@GetMapping(value="/main/adminMain.go")
	public ModelAndView adminMain(HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		String team_code = (String) session.getAttribute("team_code");
		
		return mainService.adminMain(user_code, team_code);
	}
	
	@GetMapping(value="/main/stdMain.go")
	public ModelAndView stdMain(HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		
		return mainService.stdMain(user_code);
	}
	
	@GetMapping(value="/mainChart/list.ajax")
	@ResponseBody
	public Map<String, Object> chartList(String months) {
		// logger.info(months);
		Map<String, Object> map = mainService.chartList(months);
		return map;
	}
	
	
	@GetMapping(value="/main/attendance.do")
	public String attendance(HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		mainService.attendance(user_code);
		
		return "redirect:/main/adminMain.go";
	}
	
	@GetMapping(value="/main/leaveWork.do")
	public String leaveWork(HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		mainService.leaveWork(user_code);
		
		return "redirect:/main/adminMain.go";
	}
	
}
