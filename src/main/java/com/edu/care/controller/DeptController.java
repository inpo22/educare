package com.edu.care.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.care.service.DeptService;

@Controller
public class DeptController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired DeptService deptService;
	
	@GetMapping(value="/dept.go")
	public String dept() {
		logger.info(":: 부서 페이지 ::");
		return "dept/dept";
	}
	
	@GetMapping(value = "/dept/list.ajax")
	@ResponseBody
	public Map<String, Object> getDept(){
		logger.info(":: 부서 리스트 ::");
		return deptService.getDept();
	}

	@GetMapping(value = "/dept/user/list.ajax")
	@ResponseBody
	public Map<String, Object> getUser(@RequestParam Map<String, Object> param){
		logger.info(":: 부서원 리스트 ::");
		logger.info("param: "+param);
		return deptService.getUser(param);
	}
	
	@PostMapping(value = "/dept/register.ajax")
	@ResponseBody
	public Map<String, Object> createDept(@RequestParam Map<String, Object> param){
		logger.info(":: 부서 추가 ::");
		logger.info("param: "+param);
		return deptService.createDept(param);
	}

	@GetMapping(value = "/dept/delete.ajax")
	@ResponseBody
	public Map<String, Object> removeDept(@RequestParam Map<String, Object> param){
		logger.info(":: 부서 삭제 ::");
		logger.info("param: "+param);
		return deptService.removeDept(param);
	}

	@PostMapping(value = "/dept/update.ajax")
	@ResponseBody
	public Map<String, Object> updateDept(@RequestParam Map<String, Object> param){
		logger.info(":: 부서 수정 ::");
		logger.info("param: "+param);
		return deptService.updateDept(param);
	}

}
