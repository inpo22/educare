package com.edu.care.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.MailDTO;

@Mapper
public interface MailDAO {

	List<MailDTO> receivedMailListCall(int start, int pagePerCnt, String user_code, String condition, String content);

	int receivedMailPageCnt(int pagePerCnt, String user_code, String condition, String content);

	void receivedMailListRead(String mail_no, String user_code);

	int receivedMailListDel(String mail_no, String user_code);

	List<MailDTO> writtenMailListCall(int start, int pagePerCnt, String user_code, String condition, String content);

	int writtenMailPageCnt(int pagePerCnt, String user_code, String condition, String content);

	int writtenMailListDel(String mail_no);

	MailDTO mailContentsDetail(String mail_no);

	List<MailDTO> mailReceiverDetail(String mail_no);

	List<MailDTO> mailCcDetail(String mail_no);

	List<MailDTO> mailAttachFileList(String mail_no);

	String getOriFileName(String fileName);

	List<MailDTO> deptList();

}
