package com.edu.care.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.ScheduleDTO;

@Mapper
public interface ScheduleDAO {

	int scheduleWrite(ScheduleDTO schedultDTO);

	List<ScheduleDTO> scheduleList();

}
