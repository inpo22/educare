package com.edu.care.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.care.dao.MailDAO;
import com.edu.care.dto.MailDTO;

@Service
public class MailService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MailDAO mailDAO;

	public Map<String, Object> receivedMailListCall(int currPage, int pagePerCnt, String user_code) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<MailDTO> list = mailDAO.receivedMailListCall(start, pagePerCnt, user_code);
		
		logger.info("list : {}", list);
		logger.info("list size : " + list.size());
		result.put("list", list);		
		result.put("currPage", currPage);
		result.put("topPage", mailDAO.receivedMailPageCnt(pagePerCnt, user_code));
		
		return result;
	}

	public void mailListRead(List<String> readList) {
		for (String mail_no : readList) {
			mailDAO.mailListRead(mail_no);
		}
	}

	public int mailListDel(List<String> delList) {
		int cnt = 0;
		
		for (String mail_no : delList) {
			cnt += mailDAO.mailListDel(mail_no);
		}
		return cnt;
	}
	
}
