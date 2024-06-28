package com.edu.care.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.NotiDTO;

@Mapper
public interface NotiDAO {

	void sendNoti(String to_user_code, String from_user_code, String noti_content_no, int noti_type);
	
	void deleteNoti(String noti_content_no, int noti_type);

	List<NotiDTO> getNotis(Map<String, Object> param);

	int getNotiCnt(Map<String, Object> param);

	int readNotis(Map<String, Object> param);

}
