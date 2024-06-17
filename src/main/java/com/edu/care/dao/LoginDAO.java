package com.edu.care.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Mapper
public interface LoginDAO {

		int loginAccess(String id, String pw, String name, String classify_code, RedirectAttributes redirectAttributes) ;
}
