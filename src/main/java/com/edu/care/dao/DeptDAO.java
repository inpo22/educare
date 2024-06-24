package com.edu.care.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.DeptDTO;
import com.edu.care.dto.EmpDTO;

@Mapper
public interface DeptDAO {

	List<DeptDTO> getDept();

	List<EmpDTO> getUser(Map<String, Object> param);

	String getNewTC();

	int createDept(Map<String, Object> param);

	int removeDept(Map<String, Object> param);

	int updateDeptName(Map<String, Object> param);

	int updateUpper(Map<String, Object> param);

	int updateLeader(Map<String, Object> param);


}
