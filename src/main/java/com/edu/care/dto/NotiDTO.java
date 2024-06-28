package com.edu.care.dto;

import org.apache.ibatis.type.Alias;

@Alias(value="noti")
public class NotiDTO {

	private String noti_no;
	private String to_user_code;
	private String from_user_code;
	private String from_user_name;
	private String from_user_class;
	private String noti_content_no;
	private String noti_content_title;
	private String noti_date;
	private int noti_type;
	private int is_read;
	
	public String getNoti_no() {
		return noti_no;
	}
	public void setNoti_no(String noti_no) {
		this.noti_no = noti_no;
	}
	public String getTo_user_code() {
		return to_user_code;
	}
	public void setTo_user_code(String to_user_code) {
		this.to_user_code = to_user_code;
	}
	public String getFrom_user_code() {
		return from_user_code;
	}
	public void setFrom_user_code(String from_user_code) {
		this.from_user_code = from_user_code;
	}	
	public String getFrom_user_name() {
		return from_user_name;
	}
	public void setFrom_user_name(String from_user_name) {
		this.from_user_name = from_user_name;
	}
	public String getFrom_user_class() {
		return from_user_class;
	}
	public void setFrom_user_class(String from_user_class) {
		this.from_user_class = from_user_class;
	}
	public String getNoti_content_no() {
		return noti_content_no;
	}
	public void setNoti_content_no(String noti_content_no) {
		this.noti_content_no = noti_content_no;
	}
	
	public String getNoti_content_title() {
		return noti_content_title;
	}
	public void setNoti_content_title(String noti_content_title) {
		this.noti_content_title = noti_content_title;
	}
	public String getNoti_date() {
		return noti_date;
	}
	public void setNoti_date(String noti_date) {
		this.noti_date = noti_date;
	}
	public int getNoti_type() {
		return noti_type;
	}
	public void setNoti_type(int noti_type) {
		this.noti_type = noti_type;
	}
	public int getIs_read() {
		return is_read;
	}
	public void setIs_read(int is_read) {
		this.is_read = is_read;
	}
	
	
}
