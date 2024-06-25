package com.edu.care.dao;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.MypageDTO;

@Mapper
public interface MypageDAO {

	MypageDTO empMypage(String user_code);

	void profileImgSave(String user_code, String new_filename);

	void empProfileEdit(MypageDTO dto);

}
