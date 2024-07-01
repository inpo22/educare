package com.edu.care.dto;

import java.sql.Date;
import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias(value="mypage")
public class MypageDTO {
	
	private String user_code;
	private String user_name;
	private String phone;
	private String email;
	private Date reg_date;
	private String photo;
	private String sign_photo;
	private String class_name;
	private String position_name;
	private String team_name;
	private String id;
	private String pw;
	private Date birth;
	private String gender;
	private String name;
	private Date att_date;
	private String att_state;
	private String course_name;
	private int course_no;
	private int course_price;
	
	public String getUser_code() {
		return user_code;
	}
	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getAtt_date() {
		return att_date;
	}
	public void setAtt_date(Date att_date) {
		this.att_date = att_date;
	}
	public String getAtt_state() {
		return att_state;
	}
	public void setAtt_state(String att_state) {
		this.att_state = att_state;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public int getCourse_no() {
		return course_no;
	}
	public void setCourse_no(int course_no) {
		this.course_no = course_no;
	}
	public int getCourse_price() {
		return course_price;
	}
	public void setCourse_price(int course_price) {
		this.course_price = course_price;
	}
	public String getPosition_name() {
		return position_name;
	}
	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}
	public String getSign_photo() {
		return sign_photo;
	}
	public void setSign_photo(String sign_photo) {
		this.sign_photo = sign_photo;
	}
}
