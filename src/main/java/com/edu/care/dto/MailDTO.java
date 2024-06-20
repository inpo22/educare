package com.edu.care.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias(value="mail")
public class MailDTO {
	
	private int mail_no;
	private String send_user_code;
	private String subject;
	private String content;
	private Timestamp send_date;
	private int is_del_recevier;
	private int is_read_receiver;
	
	private String send_user_name;
	private String class_name;
	private String receivers_name;
	private String all_receivers;
	
	private String user_code;
	private String receiver_name;
	private String cc_name;
	
	private int file_no;
	private String ori_filename;
	private String new_filename;
	private String board_no;
	private String board_type;
	
	private String team_code;
	private String team_name;
	private String upper_code;
	private String user_name;
	private String receive_user_code;

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

	public String getSend_user_name() {
		return send_user_name;
	}

	public void setSend_user_name(String send_user_name) {
		this.send_user_name = send_user_name;
	}

	public int getIs_del_recevier() {
		return is_del_recevier;
	}

	public void setIs_del_recevier(int is_del_recevier) {
		this.is_del_recevier = is_del_recevier;
	}

	public int getIs_read_receiver() {
		return is_read_receiver;
	}

	public void setIs_read_receiver(int is_read_receiver) {
		this.is_read_receiver = is_read_receiver;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getReceivers_name() {
		return receivers_name;
	}

	public void setReceivers_name(String receivers_name) {
		this.receivers_name = receivers_name;
	}

	public String getAll_receivers() {
		return all_receivers;
	}

	public void setAll_receivers(String all_receivers) {
		this.all_receivers = all_receivers;
	}

	public Timestamp getSend_date() {
		return send_date;
	}

	public void setSend_date(Timestamp send_date) {
		this.send_date = send_date;
	}

	public String getUser_code() {
		return user_code;
	}

	public String getReceiver_name() {
		return receiver_name;
	}

	public String getCc_name() {
		return cc_name;
	}

	public int getFile_no() {
		return file_no;
	}

	public String getOri_filename() {
		return ori_filename;
	}

	public String getNew_filename() {
		return new_filename;
	}

	public String getBoard_no() {
		return board_no;
	}

	public String getBoard_type() {
		return board_type;
	}

	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}

	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}

	public void setCc_name(String cc_name) {
		this.cc_name = cc_name;
	}

	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}

	public void setOri_filename(String ori_filename) {
		this.ori_filename = ori_filename;
	}

	public void setNew_filename(String new_filename) {
		this.new_filename = new_filename;
	}

	public void setBoard_no(String board_no) {
		this.board_no = board_no;
	}

	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}

	public String getTeam_code() {
		return team_code;
	}

	public String getTeam_name() {
		return team_name;
	}

	public String getUpper_code() {
		return upper_code;
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

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getReceive_user_code() {
		return receive_user_code;
	}

	public void setReceive_user_code(String receive_user_code) {
		this.receive_user_code = receive_user_code;
	}

}
