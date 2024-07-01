package com.edu.care.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias(value="commute")
public class CommuteDTO {
	
	private String user_code;
	private Timestamp work_date;
	private Timestamp start_time;
	private Timestamp end_time;
	private int work_hour;
	private int state;

	public String getUser_code() {
		return user_code;
	}

	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}

	public Timestamp getWork_date() {
		return work_date;
	}

	public void setWork_date(Timestamp work_date) {
		this.work_date = work_date;
	}

	public Timestamp getStart_time() {
		return start_time;
	}

	public void setStart_time(Timestamp start_time) {
		this.start_time = start_time;
	}

	public Timestamp getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Timestamp end_time) {
		this.end_time = end_time;
	}

	public int getWork_hour() {
		return work_hour;
	}

	public void setWork_hour(int work_hour) {
		this.work_hour = work_hour;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}
	
}
