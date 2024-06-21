package com.edu.care.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.CourseDTO;

@Mapper
public interface CourseDAO {

	List<CourseDTO> courseList();

	List<CourseDTO> reservationTime(Date rez_date, String rez_room);

}
