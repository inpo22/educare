package com.edu.care.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.care.dto.LoginDTO;

@Mapper
public interface LoginDAO {

	int loginAccess(String id, String pw) ;
}
