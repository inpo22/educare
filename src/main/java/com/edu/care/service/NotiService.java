package com.edu.care.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.care.dao.NotiDAO;
import com.edu.care.dto.NotiDTO;

@Service
public class NotiService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired NotiDAO notiDAO;

	public Map<String, Object> getNotis(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		String msg = "fail";

		List<NotiDTO> notiList = notiDAO.getNotis(param);
//		int notiCnt = notiDAO.getNotiCnt(param);
		int notiCnt = notiList.size();
		
		if(notiCnt > 0) {
			msg = "success";
			result.put("msg", msg);
			result.put("notiList", notiList);
			result.put("notiCnt", notiCnt);
			logger.info("알림 리스트 조회 결과: "+msg);
			logger.info("result: "+notiList.size()+"/cnt"+notiCnt);
		}
		return result;
	}

	public Map<String, Object> readNotis(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		String msg = "fail";
		int row = notiDAO.readNotis(param);
		
		if(row > 0) {
			msg = "success";
		}
		logger.info("알림 읽음 결과: "+msg);
		result.put("msg", msg);
		return null;
	}

}
