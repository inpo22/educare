package com.edu.care.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.care.service.EmpService;

@Controller
public class EmpController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired EmpService empService;
	
	@GetMapping(value="/emp/list.go")
	public String empList() {
		return "emp/emp_list";
	}
	
	// 사원리스트 불러오기(비동기)
	@ResponseBody
	@PostMapping(value="/emp/list.ajax")
	public Map<String, Object> empListCall(String page, String type, String searchbox, String startDate, String endDate){
		logger.info("사원 리스트 요청");
		logger.info("page : " + page);
		logger.info("type : " + type);
		logger.info("searchbox : " + searchbox);
		logger.info("startDate : "+ startDate);
		logger.info("endDate : "+ endDate);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		Map<String, Object> map = empService.empList(currPage, pagePerCnt,type,searchbox,startDate,endDate);
		
		return map;
	}
	
	// 사원등록페이지 이동
	@GetMapping(value="/emp/regform.go")
	public String empReg() {
		return "emp/emp_reg";
	}
	
	// 퇴사자목록 페이지 이동
	@GetMapping(value="/emp/quitList.go")
	public String quitList() {
		return "emp/quit_list";
	}
	
	// 사원 상세정보 페이지 이동
	@GetMapping(value="/emp/detail.go")
	public String empDetail() {
		return "emp/emp_detail";
	}
	
	// 사원 퇴사처리
	@ResponseBody
	@PostMapping(value="/emp/quit.ajax")
	public Map<String, Object> quitEmp(@RequestParam(value="quitList[]") List<String> quitList){
		logger.info("quitList : {}", quitList);
		
		int cnt = empService.quitEmp(quitList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cnt", cnt);
		return map;
	};
	
	
}
