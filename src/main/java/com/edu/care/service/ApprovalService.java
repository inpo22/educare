package com.edu.care.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.care.dao.ApprovalDAO;

@Service
public class ApprovalService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ApprovalDAO approvalDAO;
	
}
