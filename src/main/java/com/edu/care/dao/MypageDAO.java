package com.edu.care.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.MypageDTO;

@Mapper
public interface MypageDAO {

	int update(Map<String, String> param);

	MypageDTO empMypage(String user_code);

	void profileImgSave(String user_code, String new_filename);

	void empProfileEdit(MypageDTO dto);

}
