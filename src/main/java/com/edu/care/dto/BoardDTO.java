package com.edu.care.dto;

import org.apache.ibatis.type.Alias;

@Alias(value = "board")
public class BoardDTO {
	private int post_no;
	private int board_no;
	private String user_code;
	private String title;
	private String contents;
	private int bHit;
	private String reg_date;
	private int fixed_yn;
	private String edit_user_code;
	private String edit_date;
	private int is_del;
	private String user_name;
	private String team_code;
	private String date;
	
	private String class_name;
	private String team_name;
	
	private String file_no;
	private String ori_filename;
	private String new_filename;
	private String board_type;
	private String fileName;
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFile_no() {
		return file_no;
	}

	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}

	public String getOri_filename() {
		return ori_filename;
	}

	public void setOri_filename(String ori_filename) {
		this.ori_filename = ori_filename;
	}

	public String getNew_filename() {
		return new_filename;
	}

	public void setNew_filename(String new_filename) {
		this.new_filename = new_filename;
	}

	public String getBoard_type() {
		return board_type;
	}

	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}

	public int getPost_no() {
		return post_no;
	}

	public void setPost_no(int post_no) {
		this.post_no = post_no;
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public String getUser_code() {
		return user_code;
	}

	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getbHit() {
		return bHit;
	}

	public void setbHit(int bHit) {
		this.bHit = bHit;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public int getFixed_yn() {
		return fixed_yn;
	}

	public void setFixed_yn(int fixed_yn) {
		this.fixed_yn = fixed_yn;
	}

	public String getEdit_user_code() {
		return edit_user_code;
	}

	public void setEdit_user_code(String edit_user_code) {
		this.edit_user_code = edit_user_code;
	}

	public String getEdit_date() {
		return edit_date;
	}

	public void setEdit_date(String edit_date) {
		this.edit_date = edit_date;
	}

	public int getIs_del() {
		return is_del;
	}

	public void setIs_del(int is_del) {
		this.is_del = is_del;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getTeam_code() {
		return team_code;
	}

	public void setTeam_code(String team_code) {
		this.team_code = team_code;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
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

}
