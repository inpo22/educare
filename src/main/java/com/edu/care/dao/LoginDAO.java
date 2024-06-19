package com.edu.care.dao;

import org.apache.ibatis.annotations.Mapper;


import com.edu.care.dto.LoginDTO;

@Mapper
public interface LoginDAO {
	
	LoginDTO loginAccess(String id, String pw);

	
}
