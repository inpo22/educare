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

	MypageDTO mypageStd(String user_code);

	MypageDTO mypageStdU(String user_code);

	List<PaymentDTO> StdpayList(int start, int pagePerCnt, String Psearchbox, String user_code);

	int StdpatListPageCnt(int pagePerCnt, String Psearchbox, String user_code);

	List<PaymentDTO> StdcourseList(int start, int pagePerCnt, String Csearchbox, String user_code);

	int StdcourseListPageCnt(int pagePerCnt, String Csearchbox, String user_code);

	int cancel(String course_name, String user_code);

	List<MypageDTO> stdattdList(int start, int pagePerCnt, String Asearchbox, String user_code);

	int stdattdListPageCnt(int pagePerCnt, String Asearchbox, String user_code);

	String pwCheck(String user_code);

	void pwUpdate(String new_enc_pw, String user_code);

	String attRate(String user_code);


}
