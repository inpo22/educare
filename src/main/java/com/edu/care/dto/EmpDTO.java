package com.edu.care.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias(value="emp")
public class EmpDTO {
	private String user_code;
	private String team_code;
	private String class_code;
	private String position_code;
	private String classify_code;
	private String name;
	private String id;
	private String pw;
	private String email;
	private String phone;
	private Date birth;
	private String gender;
	private String photo;
	private Date reg_date;
	private Date quit_date;
	private int status;
	private String user_name;
	private String team_name;
	private String class_name;
	
	public String getUser_code() {
		return user_code;
	}
	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}
	public String getTeam_code() {
		return team_code;
	}
	public void setTeam_code(String team_code) {
		this.team_code = team_code;
	}
	public String getClass_code() {
		return class_code;
	}
	public void setClass_code(String class_code) {
		this.class_code = class_code;
	}
	public String getPosition_code() {
		return position_code;
	}
	public void setPosition_code(String position_code) {
		this.position_code = position_code;
	}
	public String getClassify_code() {
		return classify_code;
	}
	public void setClassify_code(String classify_code) {
		this.classify_code = classify_code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
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
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getQuit_date() {
		return quit_date;
	}
	public void setQuit_date(Date quit_date) {
		this.quit_date = quit_date;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	
	

}
