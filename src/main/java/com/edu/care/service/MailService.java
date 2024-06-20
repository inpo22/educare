package com.edu.care.service;

import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.dao.MailDAO;
import com.edu.care.dao.NotiDAO;
import com.edu.care.dto.MailDTO;

@Service
public class MailService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MailDAO mailDAO;
	@Autowired NotiDAO notiDAO;
	
	@Value("${spring.servlet.multipart.location}")
	private String root;
	
	public Map<String, Object> receivedMailListCall(int currPage, int pagePerCnt, String user_code, String condition, String content) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<MailDTO> list = mailDAO.receivedMailListCall(start, pagePerCnt, user_code, condition, content);
		
		// logger.info("list : {}", list);
		// logger.info("list size : " + list.size());
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
		
		// logger.info("list : {}", list);
		// logger.info("list size : " + list.size());
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

	public ResponseEntity<Resource> download(String file_no, String new_filename) {
		String ori_fileName = mailDAO.getOriFileName(file_no, new_filename);
		
		Resource resource  = new FileSystemResource(root + "/" + new_filename);
		
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

	public Map<String, Object> deptList() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<MailDTO> deptList = mailDAO.deptList();
		List<MailDTO> empList = mailDAO.empList();
		
		map.put("deptList", deptList);
		map.put("empList", empList);
		
		return map;
	}
	
	@Transactional
	public boolean mailWrite(MultipartFile[] attachFile, Map<String, String> param, String user_code) {
		boolean result = false;
		
		int mail_no = -1;
		
		MailDTO dto = new MailDTO();
		
		dto.setUser_code(user_code);
		dto.setSubject(param.get("subject"));
		dto.setContent(param.get("content"));
		
		mailDAO.mailWrite(dto);
		
		mail_no = dto.getMail_no();
		
		if (mail_no > 0) {
			String receiverList = param.get("receiverList");
			int noti_type = 2;
			String noti_content_no = "" + mail_no;
			
			String[] arr = receiverList.split(",");
			for (String receiver : arr) {
				mailDAO.mailReceiverWrite(mail_no, receiver);
				notiDAO.sendNoti(receiver, user_code, noti_content_no, noti_type);
			}
			
			String ccList = param.get("ccList");
			if (ccList != null) {
				arr = ccList.split(",");
				for (String cc : arr) {
					mailDAO.mailCcWrite(mail_no, cc);
				}
			}
			String loadFileList = param.get("loadFileList");
			if (loadFileList != null) {
				arr = loadFileList.split(",");
				
				for (int i = 0; i < arr.length; i++) {
					mailDAO.mailLoadFileWrite(user_code, mail_no, arr[i], i);
				}
			}
			fileSave(mail_no, attachFile, user_code);
			
			result = true;
		}
		
		return result;
	}

	private void fileSave(int mail_no, MultipartFile[] attachFile, String user_code) {
		for (MultipartFile file : attachFile) {
			String ori_filename = file.getOriginalFilename();
			
			if (!ori_filename.equals("")) {
				
				String ext = ori_filename.substring(ori_filename.lastIndexOf("."));
				
				String new_filename = System.currentTimeMillis() + ext;
				
				try {
					byte[] bytes = file.getBytes();
					Path path = Paths.get(root + new_filename);
					Files.write(path, bytes);
					
					String file_type = "mail";
					
					mailDAO.fileSave(user_code, ori_filename, new_filename, mail_no, file_type);
					
					Thread.sleep(1);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			
		}
		
	}

	public ModelAndView mailWriteForm(String mail_no, String user_code, String writeType) {
		ModelAndView mav = new ModelAndView("mail/mail_write");
		// logger.info("writeType : " + writeType);
		if (writeType != null) {
			MailDTO dto = mailDAO.mailContentsDetail(mail_no);
			List<MailDTO> receiverList = mailDAO.mailReceiverDetail(mail_no);
			List<MailDTO> ccList = mailDAO.mailCcDetail(mail_no);
			
			String original_message = "";
			original_message += "<p></p><p></p><p></p>";
			original_message += "<p>-------- Original Message --------</p>";
			original_message += "<p><b>From: </b>" + dto.getSend_user_name() + "</p>";
			original_message += "<p><b>To: </b>";
			for (int i = 0; i < receiverList.size(); i++) {
				original_message += receiverList.get(i).getReceiver_name() + " " + receiverList.get(i).getClass_name();
				if (i != (receiverList.size() - 1)) {
					original_message += ", ";
				}
			}
			original_message += "</p>";
			original_message += "<p><b>cc: </b>";
			for (int i = 0; i < ccList.size(); i++) {
				original_message += ccList.get(i).getCc_name() + " " + ccList.get(i).getClass_name();
				if (i != (ccList.size() - 1)) {
					original_message += ", ";
				}
			}
			original_message += "</p>";
			original_message += "<p><b>Send: </b>" + dto.getSend_date() + "</p>";
			original_message += "<p><b>Subject: </b>" + dto.getSubject() + "</p>";
			original_message += dto.getContent();
			
			if (writeType.equals("1")) {
				mav.addObject("receiverList", receiverList);
				mav.addObject("ccList", ccList);
			} else if (writeType.equals("2")) {
				List<MailDTO> attachFileList = mailDAO.mailAttachFileList(mail_no);
				
				mav.addObject("attachFileList", attachFileList);
			}
			mav.addObject("original_message", original_message);
			mav.addObject("writeType", writeType);
		}
		
		return mav;
	}

}
