package com.edu.care.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.care.dao.NotiDAO;
import com.edu.care.dao.ScheduleDAO;
import com.edu.care.dto.ScheduleDTO;

@Service
public class ScheduleService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ScheduleDAO scheduleDAO;
	@Autowired NotiDAO notiDAO;

	public int scheduleWrite(ScheduleDTO scheduleDTO) {
		int row = scheduleDAO.scheduleWrite(scheduleDTO);
		if(row > 0) {
			String userCode = scheduleDTO.getUser_code();
			String skedNo = ""+scheduleDTO.getSked_no();
			String skedType = scheduleDTO.getSked_type();
			logger.info("scheduleWrite get Sked_type >>>>>"+skedType);
			
			if(skedType.equals("SKED_TP02")) {
				List<String> teamUserList = scheduleDAO.teamUserList(scheduleDTO.getTeam_code());
				logger.info("alarm noti userList:{}  >>>>>",teamUserList);
				logger.info("::::alarm noti 부서일정 IN ::::");
				for(String toTeamUser : teamUserList) {
					if(userCode.equals(toTeamUser)) {
						continue;
					}
					notiDAO.sendNoti(toTeamUser, userCode, skedNo, 5);
				}
			}else if(skedType.equals("SKED_TP01")) {
				List<String> allUserList = scheduleDAO.getAllUserCodes();
				logger.info("::::alarm noti 전사일정 IN ::::");
				for(String toAllUser : allUserList) {
					if(userCode.equals(toAllUser)) {
						continue;
					}
					notiDAO.sendNoti(toAllUser, userCode, skedNo, 3);
				}
			}
		}
		return row;
	}

	public Map<String, Object> scheduleList(ScheduleDTO scheduleDTO) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<ScheduleDTO> list = scheduleDAO.scheduleList(scheduleDTO);

		result.put("list", list);
		return result;
	}

	public int scheduleDelete(String sked_no, String sked_type) {
		int row = scheduleDAO.scheduleDelete(sked_no);
		if(row > 0 ) {
			if(sked_type.equals("SKED_TP02")) {
				notiDAO.deleteNoti(sked_no, 5);
				
			}else if(sked_type.equals("SKED_TP01")) {
				notiDAO.deleteNoti(sked_no, 3);
			}
		}
		return row;
	}

	public Boolean scheduleUpdate(ScheduleDTO scheduleDTO) {
		return scheduleDAO.scheduleUpdate(scheduleDTO);
	}

	public ScheduleDTO scheduleForNoti(String sked_no) {
		return scheduleDAO.scheduleForNoti(sked_no);
	}
	
	
}
