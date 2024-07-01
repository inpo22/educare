package com.edu.care.service;

import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import com.edu.care.dao.ApprovalDAO;
import com.edu.care.dao.NotiDAO;
import com.edu.care.dto.ApprovalDTO;

@Service
public class ApprovalService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ApprovalDAO approvalDAO;
	@Autowired NotiDAO notiDAO;
	@Autowired MailService mailService;
	
	@Value("${spring.servlet.multipart.location}")
	private String root;

	public Map<String, Object> deptList() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ApprovalDTO> deptList = approvalDAO.deptList();
		List<ApprovalDTO> empList = approvalDAO.empList();
		
		map.put("deptList", deptList);
		map.put("empList", empList);
		
		return map;
	}
	
	@Transactional
	public boolean vacaApprovalWrite(MultipartFile[] attachFile, Map<String, String> param, String user_code, String team_code) {
		boolean result = false;
		
		int au_type = 1;
		String au_code = approvalDAO.createAu_code(team_code, au_type);
		
		ApprovalDTO dto = new ApprovalDTO();
		
		dto.setAu_code(au_code);
		dto.setUser_code(user_code);
		dto.setAu_type(au_type);
		dto.setTitle(param.get("subject"));
		dto.setContents(param.get("content"));
		dto.setVa_type(Integer.parseInt(param.get("va_type")));
		
		try {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			
			Timestamp formatedStart_date = new Timestamp(formatter.parse(param.get("start_date")).getTime());
			
			dto.setStart_date(formatedStart_date);
			
			if (!param.get("va_type").equals("1") && !param.get("va_type").equals("2")) {
				Timestamp formatedEnd_date = new Timestamp(formatter.parse(param.get("end_date")).getTime());
				dto.setEnd_date(formatedEnd_date);
			}else {
				dto.setVa_days(0.5);
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		approvalDAO.vacaApprovalWrite(dto);
		
		String orderList = param.get("orderList");
		String[] arr = orderList.split(",");
		
		for (int i = 0; i < arr.length; i++) {
			approvalDAO.orderInsert(au_code, arr[i]);
			
			if (i == 0) {
				int noti_type = 0;
				
				notiDAO.sendNoti(arr[i], user_code, au_code, noti_type);
			}
		}
		
		approvalDAO.minusRemainVaca(user_code, au_code);
		
		fileSave(au_code, attachFile, user_code);
		
		result = true;
		
		return result;
	}

	private void fileSave(String au_code, MultipartFile[] attachFile, String user_code) {
		for (MultipartFile file : attachFile) {
			String ori_filename = file.getOriginalFilename();
			
			if (!ori_filename.equals("")) {
				
				String ext = ori_filename.substring(ori_filename.lastIndexOf("."));
				
				String new_filename = System.currentTimeMillis() + ext;
				
				try {
					byte[] bytes = file.getBytes();
					Path path = Paths.get(root + new_filename);
					Files.write(path, bytes);
					
					String file_type = "approval";
					
					approvalDAO.fileSave(user_code, ori_filename, new_filename, au_code, file_type);
					
					Thread.sleep(1);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			
		}
		
	}

	@Transactional
	public boolean busiApprovalWrite(MultipartFile[] attachFile, Map<String, String> param, String user_code, String team_code) {
		boolean result = false;
		
		int au_type = 0;
		String au_code = approvalDAO.createAu_code(team_code, au_type);
		
		ApprovalDTO dto = new ApprovalDTO();
		
		dto.setAu_code(au_code);
		dto.setUser_code(user_code);
		dto.setAu_type(au_type);
		dto.setTitle(param.get("subject"));
		dto.setContents(param.get("content"));
		logger.info("enf_date : " + param.get("enf_date"));
		try {
			if (!param.get("enf_date").equals("")) {
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				
				Timestamp formatedEnf_date = new Timestamp(formatter.parse(param.get("enf_date")).getTime());
				
				dto.setEnf_date(formatedEnf_date);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		approvalDAO.busiApprovalWrite(dto);
		
		String orderList = param.get("orderList");
		String[] arr = orderList.split(",");
		
		for (int i = 0; i < arr.length; i++) {
			approvalDAO.orderInsert(au_code, arr[i]);
			
			if (i == 0) {
				int noti_type = 0;
				
				notiDAO.sendNoti(arr[i], user_code, au_code, noti_type);
			}
		}
		
		String receiveList = param.get("receiveList");
		if (!receiveList.equals("")) {
			arr = receiveList.split(",");
			
			for (String team : arr) {
				approvalDAO.receiveTeamInsert(au_code, team);
			}
		}
		
		fileSave(au_code, attachFile, user_code);
		
		result = true;
		
		return result;
	}

	public Map<String, Object> approvalListCall(int currPage, int pagePerCnt, String user_code, String team_code, String condition,
			String content, String listType) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<ApprovalDTO> list = new ArrayList<ApprovalDTO>();
		int totalPage = 0;
		
		if (listType.equals("get")) {
			list = approvalDAO.getApprovalListCall(start, pagePerCnt, user_code, condition, content);
			totalPage = approvalDAO.getApprovalPageCnt(pagePerCnt, user_code, condition, content);
		} else if (listType.equals("comp")) {
			list = approvalDAO.compApprovalListCall(start, pagePerCnt, user_code, condition, content);
			totalPage = approvalDAO.compApprovalPageCnt(pagePerCnt, user_code, condition, content);
		} else if (listType.equals("view")) {
			list = approvalDAO.viewApprovalListCall(start, pagePerCnt, team_code, condition, content);
			totalPage = approvalDAO.viewApprovalPageCnt(pagePerCnt, team_code, condition, content);
		} else if (listType.equals("request")) {
			list = approvalDAO.reqeustApprovalListCall(start, pagePerCnt, user_code, condition, content);
			totalPage = approvalDAO.requestApprovalPageCnt(pagePerCnt, user_code, condition, content);
		} else if (listType.equals("request")) {
			list = approvalDAO.finishApprovalListCall(start, pagePerCnt, user_code, condition, content);
			totalPage = approvalDAO.finishApprovalPageCnt(pagePerCnt, user_code, condition, content);
		} else if (listType.equals("rejected")) {
			list = approvalDAO.rejectedApprovalListCall(start, pagePerCnt, user_code, condition, content);
			totalPage = approvalDAO.rejectedApprovalPageCnt(pagePerCnt, user_code, condition, content);
		}
		
		result.put("list", list);
		result.put("totalPage", totalPage);
		
		return result;
	}
	
	@Transactional
	public ModelAndView approvalDetail(String au_code, String user_code) {
		ModelAndView mav = new ModelAndView();
		
		ApprovalDTO dto = approvalDAO.approvalDetail(au_code);
		List<ApprovalDTO> orderList = approvalDAO.orderList(au_code, user_code);
		List<ApprovalDTO> attachFileList = approvalDAO.attachFileList(au_code);
		
		int au_type = dto.getAu_type();
		
		if (au_type == 0) {
			mav.setViewName("/approval/busiApproval_detail");
			
			List<ApprovalDTO> receiveTeamList = approvalDAO.receiveTeamList(au_code);
			mav.addObject("receiveTeamList", receiveTeamList);
		} else if (au_type == 1) {
			mav.setViewName("/approval/vacaApproval_detail");
			String detail_user_code = dto.getUser_code();
			String reg_date = dto.getReg_date().toString();
			
			double remainVaca = approvalDAO.remainVaca(detail_user_code, reg_date);
			mav.addObject("remainVaca", remainVaca);
		}
		
		mav.addObject("dto", dto);
		mav.addObject("orderList", orderList);
		mav.addObject("attachFileList", attachFileList);
		
		return mav;
	}

	public ResponseEntity<Resource> download(String file_no, String new_filename) {
		String ori_fileName = approvalDAO.getOriFileName(file_no, new_filename);
		
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
	
	@Transactional
	public void approve(String user_code, String au_code) {
		approvalDAO.approve(au_code, user_code);
		
		int is_comp = approvalDAO.orderCompCheck(au_code, user_code);
		ApprovalDTO dto = approvalDAO.approvalDetail(au_code);
		
		if (is_comp == 0) {
			String to_user_code = approvalDAO.notiReceiveUser(au_code, user_code);
			String from_user_code = dto.getUser_code();
			String noti_content_no = au_code;
			int noti_type = 0;
			
			notiDAO.sendNoti(to_user_code, from_user_code, noti_content_no, noti_type);
		} else if (is_comp == 1) {
			String receive_user_code = dto.getUser_code();
			String code = au_code;
			int type = 1;
			
			mailService.autoMailSend(receive_user_code, code, type);
			
			if (dto.getAu_type() == 1) {
				approvalDAO.scheduleWrite(dto);
			}
		}
	}

	public void reject(String au_code, String user_code) {
		approvalDAO.reject(au_code, user_code);
		
		ApprovalDTO dto = approvalDAO.approvalDetail(au_code);
		
		String receive_user_code = dto.getUser_code();
		String code = au_code;
		int type = 2;
		
		mailService.autoMailSend(receive_user_code, code, type);
		
		if (dto.getAu_type() == 1) {
			double va_days = dto.getVa_days();
			String au_user_code = dto.getUser_code();
			Timestamp reg_date = dto.getReg_date();
			
			approvalDAO.plusRemainVaca(va_days, au_user_code, reg_date);
		}
	}
}
