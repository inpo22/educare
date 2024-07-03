package com.edu.care.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.CommuteDTO;

@Mapper
public interface CommuteDAO {

	List<String> empList();

	CommuteDTO todayCommute(String user_code);

	void autoCommute(String user_code);

	void autoLeaveWork(String user_code);

	int stateCheck(String user_code);

	void autoStateUpdate(String user_code, int type);

	int vacaListPageCnt(int pagePerCnt, String user_code);

	List<CommuteDTO> vacaUseList(int start, int pagePerCnt, String user_code);

}
