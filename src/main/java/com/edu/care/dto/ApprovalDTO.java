package com.edu.care.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias(value="approval")
public class ApprovalDTO {

	private String au_code;
	private String user_code;
	private int au_type;
	private String title;
	private String contents;
	private Timestamp reg_date;
	private Timestamp enf_date;
	private double va_days;
	private Timestamp start_date;
	private Timestamp end_date;
	private int va_type;
	
	private String team_code;
	private String team_name;
	private String upper_code;
	
	private String user_name;
	private String class_name;
	
	public String getTeam_code() {
		return team_code;
	}
	public String getTeam_name() {
		return team_name;
	}
	public String getUpper_code() {
		return upper_code;
	}
	public String getUser_code() {
		return user_code;
	}
	public String getUser_name() {
		return user_name;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setTeam_code(String team_code) {
		this.team_code = team_code;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public void setUpper_code(String upper_code) {
		this.upper_code = upper_code;
	}
	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public String getAu_code() {
		return au_code;
	}
	public int getAu_type() {
		return au_type;
	}
	public String getTitle() {
		return title;
	}
	public String getContents() {
		return contents;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public Timestamp getEnf_date() {
		return enf_date;
	}
	public double getVa_days() {
		return va_days;
	}
	public Timestamp getStart_date() {
		return start_date;
	}
	public Timestamp getEnd_date() {
		return end_date;
	}
	public int getVa_type() {
		return va_type;
	}
	public void setAu_code(String au_code) {
		this.au_code = au_code;
	}
	public void setAu_type(int au_type) {
		this.au_type = au_type;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public void setEnf_date(Timestamp enf_date) {
		this.enf_date = enf_date;
	}
	public void setVa_days(double va_days) {
		this.va_days = va_days;
	}
	public void setStart_date(Timestamp start_date) {
		this.start_date = start_date;
	}
	public void setEnd_date(Timestamp end_date) {
		this.end_date = end_date;
	}
	public void setVa_type(int va_type) {
		this.va_type = va_type;
	}
	
}
