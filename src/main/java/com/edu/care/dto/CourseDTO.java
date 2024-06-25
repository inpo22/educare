package com.edu.care.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias(value="course")
public class CourseDTO {
	private int course_no;
	private String user_code;
	private String course_name;
	private Date course_start;
	private Date course_end;
	private String course_con;
	private int course_price;
	private int is_confirm;
	private int is_del;
	private String name;
	private int rez_no;
	private String course_space;
	private Date start_time;
	private Date end_time;
	private int time;
	private int pay_state;
	
	public int getCourse_no() {
		return course_no;
	}
	public void setCourse_no(int course_no) {
		this.course_no = course_no;
	}
	public String getUser_code() {
		return user_code;
	}
	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public Date getCourse_start() {
		return course_start;
	}
	public void setCourse_start(Date course_start) {
		this.course_start = course_start;
	}
	public Date getCourse_end() {
		return course_end;
	}
	public void setCourse_end(Date course_end) {
		this.course_end = course_end;
	}
	public String getCourse_con() {
		return course_con;
	}
	public void setCourse_con(String course_con) {
		this.course_con = course_con;
	}
	public int getCourse_price() {
		return course_price;
	}
	public void setCourse_price(int course_price) {
		this.course_price = course_price;
	}
	public int getIs_confirm() {
		return is_confirm;
	}
	public void setIs_confirm(int is_confirm) {
		this.is_confirm = is_confirm;
	}
	public int getIs_del() {
		return is_del;
	}
	public void setIs_del(int is_del) {
		this.is_del = is_del;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getRez_no() {
		return rez_no;
	}
	public void setRez_no(int rez_no) {
		this.rez_no = rez_no;
	}
	public String getCourse_space() {
		return course_space;
	}
	public void setCourse_space(String course_space) {
		this.course_space = course_space;
	}
	public Date getStart_time() {
		return start_time;
	}
	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	public int getTime() {
		return time;
	}
	public void setTime(int time) {
		this.time = time;
	}
	public int getPay_state() {
		return pay_state;
	}
	public void setPay_state(int pay_state) {
		this.pay_state = pay_state;
	}
}
