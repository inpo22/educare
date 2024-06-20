package com.edu.care.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.CourseDTO;

@Mapper
public interface CourseDAO {

	List<CourseDTO> courseList();

}
