package com.edu.care.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.care.dao.DeptDAO;
import com.edu.care.dto.DeptDTO;

@Service
public class DeptService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired DeptDAO deptDAO;

	// 부서 리스트 조회
	public Map<String, Object> getDept() {
		Map<String, Object> result = new HashMap<String, Object>();
		List<DeptDTO> deptList = deptDAO.getDept();
		if(deptList.size() > 0) {
			logger.info("deptList is not empty ");
			result.put("deptList", deptList);
		}
		return result;
	}

	public Map<String, Object> createDept(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		String msg = "fail";
		int row = deptDAO.createDept(param);
		if(row > 0) {
			msg = "success";
		}
		logger.info("부서 추가 결과: "+msg);
		result.put("msg", msg);
		return result;
	}

	public Map<String, Object> removeDept(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		String msg = "fail";
		int row = deptDAO.removeDept(param);
		if(row > 0) {
			msg = "success";
		}
		logger.info("부서 삭제 결과: "+msg);
		result.put("msg", msg);
		return result;
	}

	public Map<String, Object> updateDept(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		String msg = "fail";
		String type = param.get("edit_type").toString();
		logger.info("수정 유형: "+type);
		// 수정중~
		int row = 0;
		if(row > 0) {
			msg = "success";
		}
		logger.info("부서 수정 결과: "+msg);
		result.put("msg", msg);
		return result;
	}
	
}
