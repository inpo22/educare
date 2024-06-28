package com.edu.care.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias(value="payment")
public class PaymentDTO {
	
	private String user_code;
	private String course_no;
	private String course_name;
	private String name;
	private Date pay_date;
	private String course_price;
	
	public String getUser_code() {
		return user_code;
	}
	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}
	
	public String getCourse_no() {
		return course_no;
	}
	public void setCourse_no(String course_no) {
		this.course_no = course_no;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getPay_date() {
		return pay_date;
	}
	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}
	public String getCourse_price() {
		return course_price;
	}
	public void setCourse_price(String course_price) {
		this.course_price = course_price;
	}
	

}
