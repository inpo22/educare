package com.edu.care.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias(value="schedule")
public class ScheduleDTO {
	
	private int sked_no;
	private String user_code;
	private String team_code;
	private String title;
	private String contents;
	private Date start_date;
	private Date end_date;
	private Date reg_date;
	private String edit_user_code;
	private Date edit_date;
	private int is_del;
	private String id;
	
	public int getSked_no() {
		return sked_no;
	}
	public void setSked_no(int sked_no) {
		this.sked_no = sked_no;
	}
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
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getEdit_user_code() {
		return edit_user_code;
	}
	public void setEdit_user_code(String edit_user_code) {
		this.edit_user_code = edit_user_code;
	}
	public Date getEdit_date() {
		return edit_date;
	}
	public void setEdit_date(Date edit_date) {
		this.edit_date = edit_date;
	}
	public int getIs_del() {
		return is_del;
	}
	public void setIs_del(int is_del) {
		this.is_del = is_del;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	
	
}
