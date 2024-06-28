package com.edu.care.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.PaymentDTO;

@Mapper
public interface PaymentDAO {

	void savePay(PaymentDTO payDto);

	List<String> attDateList(String course_no);

	void saveAttd(String course_no, String user_code, String date);

}
