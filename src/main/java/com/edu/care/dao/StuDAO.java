package com.edu.care.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.CourseDTO;
import com.edu.care.dto.MypageDTO;
import com.edu.care.dto.PaymentDTO;
import com.edu.care.dto.StuDTO;

@Mapper
public interface StuDAO {

	List<StuDTO> stdList(int start, int pagePerCnt, String type, String searchbox, String startDate, String endDate);

	int stdListPageCnt(int pagePerCnt, String type, String searchbox, String startDate, String endDate);

	int overlay(String id);

	String createUserCode(Map<String, String> param);

	int reg(Map<String, String> param);

	int edit(Map<String, String> param);

	StuDTO stuDetail(String user_code);

	List<PaymentDTO> payList(int start, int pagePerCnt, String Psearchbox, String user_code);

	int payListPageCnt(int pagePerCnt, String Psearchbox, String user_code);

	List<CourseDTO> courseList(int start, int pagePerCnt, String Csearchbox, String user_code);

	int courseListPageCnt(int pagePerCnt, String Csearchbox, String user_code);

	List<CourseDTO> courseModalList();

	int courseReg(Map<String, String> param);

	List<MypageDTO> attdList(int start, int pagePerCnt, String Asearchbox, String user_code);

	int attdListPageCnt(int pagePerCnt, String Asearchbox, String user_code);

	int attd(String course_name, String user_code, String att_date);

	int absent(String course_name, String user_code, String att_date);

	String attRate(String user_code);
}
