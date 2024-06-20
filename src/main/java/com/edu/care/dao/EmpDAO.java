package com.edu.care.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.EmpDTO;

@Mapper
public interface EmpDAO {

	List<EmpDTO> empList(int start, int pagePerCnt, String type, String searchbox, String startDate, String endDate);

	int empListPageCnt(int pagePerCnt, String type, String searchbox, String startDate, String endDate);

	int quitEmp(String user_code);

	int overlay(String id);

	int reg(Map<String, String> param);

	List<EmpDTO> deptList();

	EmpDTO empDetail(String user_code);

	int edit(Map<String, String> param);

	String createUserCode(String classify_code);

	void regVaca(String user_code);



}
