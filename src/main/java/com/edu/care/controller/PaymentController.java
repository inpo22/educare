package com.edu.care.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.care.service.PaymentService;

@Controller
public class PaymentController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PaymentService paymentService;
	
	@ResponseBody
	@PostMapping(value="/pay/payment.ajax")
	public Map<String, Object> pay(@RequestParam Map<String, String> param){
		logger.info("결제요청");
		logger.info("param = "+param);
		// 응답데이터 저장할 map 객체
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 결제 정보 저장
		paymentService.savePay(param);
		
		// 출석 정보 저장
		paymentService.saveAttd(param);
		
		//응답 데이터
		map.put("result", "success");
		map.put("msg", "결제에 성공했습니다.");
		
		return map;
	}
	
}
