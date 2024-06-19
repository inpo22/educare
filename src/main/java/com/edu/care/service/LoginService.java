package com.edu.care.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.edu.care.dao.LoginDAO;
import com.edu.care.dto.LoginDTO;


@Service
public class LoginService {

	@Autowired LoginDAO loginDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public LoginDTO loginAccess(String id, String pw) {
		logger.info("id : {} / pw : {}", id, pw);
		return loginDAO.loginAccess(id,pw);
	}

	


}
