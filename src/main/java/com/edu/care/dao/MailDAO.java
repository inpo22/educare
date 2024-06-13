package com.edu.care.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.MailDTO;

@Mapper
public interface MailDAO {

	List<MailDTO> receivedMailListCall(int start, int pagePerCnt, String user_code);

	int receivedMailPageCnt(int pagePerCnt, String user_code);

	void mailListRead(String mail_no);

	int mailListDel(String mail_no);

}
