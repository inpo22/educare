package com.edu.care.controller;

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

import com.edu.care.service.DeptService;

@Controller
public class DeptController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	DeptService deptService;

	@GetMapping(value = "/dept.go")
	public String dept() {
		logger.info(":: 부서 페이지 ::");
		return "dept/dept";
	}

	@GetMapping(value = "/deptModal")
	public String deptModal() {
		logger.info(":: 부서 페이지 ::");
		return "dept/deptModal";
	}

	@GetMapping(value = "/dept/list.ajax")
	@ResponseBody
	public Map<String, Object> getDept() {
		logger.info(":: 부서 리스트 ::");
		return deptService.getDept();
	}

	@GetMapping(value = "/dept/member/list.ajax")
	@ResponseBody
	public Map<String, Object> getMember(@RequestParam Map<String, Object> param) {
		logger.info(":: 부서원 리스트 ::");
		logger.info("param: " + param);
		return deptService.getMember(param);
	}

	@PostMapping(value = "/dept/register.ajax")
	@ResponseBody
	public Map<String, Object> createDept(@RequestParam Map<String, Object> param) {
		logger.info(":: 부서 추가 ::");
		return deptService.createDept(param);
	}

	@GetMapping(value = "/dept/delete.ajax")
	@ResponseBody
	public Map<String, Object> removeDept(@RequestParam Map<String, Object> param) {
		logger.info(":: 부서 삭제 ::");
		logger.info("param: " + param);
		return deptService.removeDept(param);
	}

	@PostMapping(value = "/dept/update.ajax")
	@ResponseBody
	public Map<String, Object> updateDept(@RequestParam Map<String, Object> param) {
		logger.info(":: 부서 수정 ::");
		logger.info("param: " + param);
		return deptService.updateDept(param);
	}

	@PostMapping(value = "/dept/leader/update.ajax")
	@ResponseBody
	public Map<String, Object> changeLeader(@RequestParam Map<String, Object> param) {
		logger.info(":: 부서장 변경 ::");
		logger.info("param: " + param);
		return deptService.changeLeader(param);
	}

	@PostMapping(value = "/dept/member/update.ajax")
	@ResponseBody
	public Map<String, Object> moveMember(@RequestParam(value = "team_code") String team_code,
			@RequestParam(value = "users[]") List<String> users) {
		logger.info(":: 부서원 부서 이동 ::");
		logger.info("team_code:" + team_code);
		return deptService.moveMember(team_code, users);
	}

}
