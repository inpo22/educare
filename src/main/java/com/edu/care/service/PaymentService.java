package com.edu.care.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.care.dao.PaymentDAO;
import com.edu.care.dto.PaymentDTO;

@Service
public class PaymentService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PaymentDAO paymentDAO;

	public void savePay(Map<String, String> param) {
		logger.info("결제 정보 저장");
		logger.info("param :"+param);
		
		PaymentDTO payDto = new PaymentDTO();
		payDto.setCourse_no(param.get("course_no"));
		payDto.setCourse_name(param.get("course_name"));
		payDto.setCourse_price(param.get("course_price"));
		payDto.setName(param.get("name"));
		payDto.setUser_code(param.get("user_code"));
		
		// logger.info("payDto:"+payDto);
		
		paymentDAO.savePay(payDto);
		
	}

	public void saveAttd(Map<String, String> param) {
		logger.info("출석 테이블 인서트");
		logger.info("param : "+param);
		
		
		String course_no = param.get("course_no");
		String user_code = param.get("user_code");
		List<String> list = paymentDAO.attDateList(course_no);
		
		for (String date : list) {
			paymentDAO.saveAttd(course_no, user_code, date);			
		}
		
	}
	
}
