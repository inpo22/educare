package com.edu.care.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.ScheduleDTO;

@Mapper
public interface ScheduleDAO {

	int scheduleWrite(ScheduleDTO schedultDTO);

	List<ScheduleDTO> scheduleList(ScheduleDTO scheduleDTO);

	int scheduleDelete(String sked_no);

	Boolean scheduleUpdate(ScheduleDTO scheduleDTO);

	List<String> teamUserList(String team_code);

	List<String> getAllUserCodes();

	ScheduleDTO scheduleForNoti(String sked_no);

}
