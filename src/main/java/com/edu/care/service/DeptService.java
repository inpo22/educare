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
	
}
