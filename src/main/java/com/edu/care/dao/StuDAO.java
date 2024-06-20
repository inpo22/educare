package com.edu.care.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.StuDTO;

@Mapper
public interface StuDAO {

	List<StuDTO> stdList(int start, int pagePerCnt, String type, String searchbox, String startDate, String endDate);

	int stdListPageCnt(int pagePerCnt, String type, String searchbox, String startDate, String endDate);

}
