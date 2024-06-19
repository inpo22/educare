package com.edu.care.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NotiDAO {

	void sendNoti(String receiver, String user_code, String noti_content_no, int noti_type);
	
	void deleteNoti(String noti_content_no, int noti_type);

}
