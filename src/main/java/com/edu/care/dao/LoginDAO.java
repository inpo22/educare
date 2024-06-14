package com.edu.care.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDAO {

	int loginAccess(String id, String pw);
}
