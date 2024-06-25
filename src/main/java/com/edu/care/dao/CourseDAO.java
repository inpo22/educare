package com.edu.care.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.CourseDTO;

@Mapper
public interface CourseDAO {

	List<CourseDTO> courseList(int start, int pagePerCnt, String searchFilter, String searchContent);

	List<CourseDTO> reservationTime(Date rez_date, String rez_room);

	void courseWrite(CourseDTO courseDTO);

	void reservationCourseWrite(String user_code, String course_space, Date start_time, Date end_time);

}
