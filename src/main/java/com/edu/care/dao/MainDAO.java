package com.edu.care.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.MainDTO;

@Mapper
public interface MainDAO {

	List<MainDTO> chartDataList(String first, String second, String third, String fourth, String fifth, String sixth);

	List<MainDTO> approvalList(String user_code);

	List<MainDTO> mailList(String user_code);

	List<MainDTO> scheduleList(String user_code, String team_code);

	List<MainDTO> boardList();

	MainDTO thisMonthHRD();

}
