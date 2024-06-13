package com.edu.care.dto;

import org.apache.ibatis.type.Alias;

@Alias(value="board")
public class BoardDTO {
	private int post_no;
	private int iboard_no;
	private String user_code;
	private String title;
	private String contents;
	private int bHit;
	private String reg_date;
	private int fixed_yn;
	private String edit_user_code;
	private String edit_date;
	private int is_del;
	
	
	public int getPost_no() {
		return post_no;
	}
	public void setPost_no(int post_no) {
		this.post_no = post_no;
	}
	public int getIboard_no() {
		return iboard_no;
	}
	public void setIboard_no(int iboard_no) {
		this.iboard_no = iboard_no;
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
}
