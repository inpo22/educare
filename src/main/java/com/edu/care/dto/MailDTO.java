package com.edu.care.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias(value="mail")
public class MailDTO {
	
	private int mail_no;
	private String send_user_code;
	private String subject;
	private String content;
	private Date send_date;
	private int is_del;
	private int is_read;
	
	private String send_user_name;

	public int getMail_no() {
		return mail_no;
	}

	public void setMail_no(int mail_no) {
		this.mail_no = mail_no;
	}

	public String getSend_user_code() {
		return send_user_code;
	}

	public void setSend_user_code(String send_user_code) {
		this.send_user_code = send_user_code;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getSend_date() {
		return send_date;
	}

	public void setSend_date(Date send_date) {
		this.send_date = send_date;
	}

	public int getIs_del() {
		return is_del;
	}

	public void setIs_del(int is_del) {
		this.is_del = is_del;
	}

	public int getIs_read() {
		return is_read;
	}

	public void setIs_read(int is_read) {
		this.is_read = is_read;
	}

	public String getSend_user_name() {
		return send_user_name;
	}

	public void setSend_user_name(String send_user_name) {
		this.send_user_name = send_user_name;
	}

}
