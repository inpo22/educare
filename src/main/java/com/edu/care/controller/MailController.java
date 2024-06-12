package com.edu.care.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.edu.care.service.MailService;

@Controller
public class MailController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MailService mailService;
	
	@GetMapping(value="/receivedMail/list.go")
	public String receivedMail() {
		return "mail/recevicedMail_list";
	}
	
}
