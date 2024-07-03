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

	private String au_code;
	private int au_type;
	private String reg_date;
	private String start_date;
	private String end_date;
	private int va_type;
	private double va_days;
	
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

	public String getAu_code() {
		return au_code;
	}

	public void setAu_code(String au_code) {
		this.au_code = au_code;
	}

	public int getAu_type() {
		return au_type;
	}

	public void setAu_type(int au_type) {
		this.au_type = au_type;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public int getVa_type() {
		return va_type;
	}

	public void setVa_type(int va_type) {
		this.va_type = va_type;
	}

	public double getVa_days() {
		return va_days;
	}

	public void setVa_days(double va_days) {
		this.va_days = va_days;
	}
	
}
