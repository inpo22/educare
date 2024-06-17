package com.edu.care.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.DeptDTO;

@Mapper
public interface DeptDAO {

	List<DeptDTO> getDept();

	int createDept(Map<String, Object> param);

	int removeDept(Map<String, Object> param);

}
