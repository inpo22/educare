package com.edu.care.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias(value="main")
public class MainDTO {
	
	private double first;
	private double second;
	private double third;
	private double fourth;
	private double fifth;
	private double sixth;
	
	private String au_code;
	private String user_name;
	private String class_name;
	private String title;
	private Timestamp reg_date;
	
	private int mail_no;
	private String subject;
	private Timestamp send_date;
	
	private Timestamp start_date;
	private Timestamp end_date;
	private String sked_type;
	private int check_period;
	
	private int new_emp;
	private int quit_emp;
	private int late_emp;
	private int absent_emp;
	private int new_stu;
	
	private int post_no;
	
	private Timestamp start_time;
	private Timestamp end_time;
	
	private String course_name;
	private String course_space;
	
	public double getFirst() {
		return first;
	}
	public double getSecond() {
		return second;
	}
	public double getThird() {
		return third;
	}
	public double getFourth() {
		return fourth;
	}
	public double getFifth() {
		return fifth;
	}
	public double getSixth() {
		return sixth;
	}
	public void setFirst(double first) {
		this.first = first;
	}
	public void setSecond(double second) {
		this.second = second;
	}
	public void setThird(double third) {
		this.third = third;
	}
	public void setFourth(double fourth) {
		this.fourth = fourth;
	}
	public void setFifth(double fifth) {
		this.fifth = fifth;
	}
	public void setSixth(double sixth) {
		this.sixth = sixth;
	}
	public String getAu_code() {
		return au_code;
	}
	public String getUser_name() {
		return user_name;
	}
	public String getClass_name() {
		return class_name;
	}
	public String getTitle() {
		return title;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public int getMail_no() {
		return mail_no;
	}
	public String getSubject() {
		return subject;
	}
	public Timestamp getSend_date() {
		return send_date;
	}
	public Timestamp getStart_date() {
		return start_date;
	}
	public Timestamp getEnd_date() {
		return end_date;
	}
	public String getSked_type() {
		return sked_type;
	}
	public int getCheck_period() {
		return check_period;
	}
	public int getPost_no() {
		return post_no;
	}
	public void setAu_code(String au_code) {
		this.au_code = au_code;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public void setMail_no(int mail_no) {
		this.mail_no = mail_no;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public void setSend_date(Timestamp send_date) {
		this.send_date = send_date;
	}
	public void setStart_date(Timestamp start_date) {
		this.start_date = start_date;
	}
	public void setEnd_date(Timestamp end_date) {
		this.end_date = end_date;
	}
	public void setSked_type(String sked_type) {
		this.sked_type = sked_type;
	}
	public void setCheck_period(int check_period) {
		this.check_period = check_period;
	}
	public void setPost_no(int post_no) {
		this.post_no = post_no;
	}
	public int getNew_emp() {
		return new_emp;
	}
	public int getQuit_emp() {
		return quit_emp;
	}
	public int getLate_emp() {
		return late_emp;
	}
	public int getAbsent_emp() {
		return absent_emp;
	}
	public int getNew_stu() {
		return new_stu;
	}
	public void setNew_emp(int new_emp) {
		this.new_emp = new_emp;
	}
	public void setQuit_emp(int quit_emp) {
		this.quit_emp = quit_emp;
	}
	public void setLate_emp(int late_emp) {
		this.late_emp = late_emp;
	}
	public void setAbsent_emp(int absent_emp) {
		this.absent_emp = absent_emp;
	}
	public void setNew_stu(int new_stu) {
		this.new_stu = new_stu;
	}
	public Timestamp getStart_time() {
		return start_time;
	}
	public Timestamp getEnd_time() {
		return end_time;
	}
	public void setStart_time(Timestamp start_time) {
		this.start_time = start_time;
	}
	public void setEnd_time(Timestamp end_time) {
		this.end_time = end_time;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public String getCourse_space() {
		return course_space;
	}
	public void setCourse_space(String course_space) {
		this.course_space = course_space;
	}
	
}
