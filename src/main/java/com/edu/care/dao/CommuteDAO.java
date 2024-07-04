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

	int vacaListPageCnt(int pagePerCnt, String user_code);

	List<CommuteDTO> vacaUseList(int start, int pagePerCnt, String user_code);
	
	List<CommuteDTO> attList(int start, int pagePerCnt, String user_code, String start_date, String end_date);

	int attListPageCnt(int pagePerCnt, String user_code, String start_date, String end_date);

	void attendance(String user_code);

	void leaveWork(String user_code);

	void stateUpdate(String user_code, int state);

	CommuteDTO todayAtt(String user_code);

	CommuteDTO monthAtt(String user_code);

}
