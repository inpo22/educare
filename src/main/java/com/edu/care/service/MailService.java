package com.edu.care.service;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.dao.MailDAO;
import com.edu.care.dto.MailDTO;

@Service
public class MailService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MailDAO mailDAO;
	
	@Value("${spring.servlet.multipart.location}")
	private String root;
	
	public Map<String, Object> receivedMailListCall(int currPage, int pagePerCnt, String user_code, String condition, String content) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<MailDTO> list = mailDAO.receivedMailListCall(start, pagePerCnt, user_code, condition, content);
		
		logger.info("list : {}", list);
		logger.info("list size : " + list.size());
		result.put("list", list);
		result.put("totalPage", mailDAO.receivedMailPageCnt(pagePerCnt, user_code, condition, content));
		
		return result;
	}

	public void receivedMailListRead(List<String> readList, String user_code) {
		for (String mail_no : readList) {
			mailDAO.receivedMailListRead(mail_no, user_code);
		}
	}

	public int receivedMailListDel(List<String> delList, String user_code) {
		int cnt = 0;
		
		for (String mail_no : delList) {
			cnt += mailDAO.receivedMailListDel(mail_no, user_code);
		}
		return cnt;
	}

	public Map<String, Object> writtenMailListCall(int currPage, int pagePerCnt, String user_code, String condition,
			String content) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<MailDTO> list = mailDAO.writtenMailListCall(start, pagePerCnt, user_code, condition, content);
		
		logger.info("list : {}", list);
		logger.info("list size : " + list.size());
		result.put("list", list);
		result.put("totalPage", mailDAO.writtenMailPageCnt(pagePerCnt, user_code, condition, content));
		
		return result;
	}

	public int writtenMailListDel(List<String> delList) {
		int cnt = 0;
		
		for (String mail_no : delList) {
			cnt += mailDAO.writtenMailListDel(mail_no);
		}
		return cnt;
	}
	
	@Transactional
	public ModelAndView mailDetail(String mail_no, String is_read_receiver, String user_code) {
		ModelAndView mav = new ModelAndView("mail/mail_detail");
		
		if (is_read_receiver != null) {
			int is_read = Integer.parseInt(is_read_receiver);
			if (is_read == 0) {
				mailDAO.receivedMailListRead(mail_no, user_code);
			}
			
		}
		
		MailDTO dto = mailDAO.mailContentsDetail(mail_no);
		List<MailDTO> receiverList = mailDAO.mailReceiverDetail(mail_no);
		List<MailDTO> ccList = mailDAO.mailCcDetail(mail_no);
		List<MailDTO> attachFileList = mailDAO.mailAttachFileList(mail_no);
		
		mav.addObject("dto", dto);
		mav.addObject("receiverList", receiverList);
		mav.addObject("ccList", ccList);
		mav.addObject("attachFileList", attachFileList);
		
		return mav;
	}

	public ResponseEntity<Resource> download(String fileName) {
		String ori_fileName = mailDAO.getOriFileName(fileName);
		
		Resource resource  = new FileSystemResource(root + "/" + fileName);
		
		HttpHeaders header = new HttpHeaders();
		
		try {
			header.add("content-type", "application/ortet-stream");
			String oriFile = URLEncoder.encode(ori_fileName, "UTF-8");
			header.add("content-Disposition", "attachment;filename=\"" + oriFile + "\"");
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}

}
