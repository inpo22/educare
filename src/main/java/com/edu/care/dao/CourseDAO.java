package com.edu.care.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.CourseDTO;

@Mapper
public interface CourseDAO {

	List<CourseDTO> courseList(int start, int pagePerCnt, String searchFilter, String searchContent, String showCourse);

	List<CourseDTO> reservationTime(Date rez_date, String rez_room);

	int courseWrite(CourseDTO courseDTO);

	void reservationCourseWrite(int course_no, String course_space, Date start_time, Date end_time);

	List<CourseDTO>courseDetail(int course_no);

	int courseListPageCnt(int pagePerCnt, String searchFilter, String searchContent, String showCourse);

	int courseReservationDelete(int course_no);

	void courseHide(int course_no);

	List<CourseDTO> courseCheck();

	int checkUserCode(String user_code);

	int courseUpdateAjax(CourseDTO courseDTO);

	List<CourseDTO> courseStuCheck(String userCode);

	List<CourseDTO> courseStuCheckList(String userCode);

	List<CourseDTO> getCourseSpaceList();

	CourseDTO checkUserCodeInfo(String user_code);

}
