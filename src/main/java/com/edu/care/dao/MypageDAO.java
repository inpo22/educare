package com.edu.care.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MypageDAO {

	int update(Map<String, String> param);

}
