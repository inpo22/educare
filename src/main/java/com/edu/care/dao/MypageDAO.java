package com.edu.care.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.MypageDTO;
import com.edu.care.dto.PaymentDTO;

@Mapper
public interface MypageDAO {

	int update(Map<String, String> param);

	MypageDTO empMypage(String user_code);

	void profileImgSave(String user_code, String new_filename);

	void empProfileEdit(MypageDTO dto);

	MypageDTO mypageStd();

	MypageDTO mypageStdU(String user_code);

	List<PaymentDTO> StdpayList(int start, int pagePerCnt, String Psearchbox);

	int StdpatListPageCnt(int pagePerCnt, String Psearchbox);

	List<PaymentDTO> StdcourseList(int start, int pagePerCnt, String Csearchbox);

	int StdcourseListPageCnt(int pagePerCnt, String Csearchbox);

	int cancel(String course_name);

	String pwCheck(String user_code);

	void pwUpdate(String new_enc_pw, String user_code);

}
