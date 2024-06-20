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
	
	private int apv_no;
	private int state;
	private Timestamp apv_date;
	
	private String team_code;
	private String team_name;
	private String upper_code;
	
	private String user_name;
	private String class_name;
	
	private int is_my_turn;
	private int is_comp;
	private int total_order_state;
	
	private int row_num;
	private String approvers_name;
	private String approvers_team;
	private String all_approvers;
	
	private int file_no;
	private String ori_filename;
	private String new_filename;
	
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
	public int getApv_no() {
		return apv_no;
	}
	public int getState() {
		return state;
	}
	public Timestamp getApv_date() {
		return apv_date;
	}
	public int getIs_my_turn() {
		return is_my_turn;
	}
	public int getTotal_order_state() {
		return total_order_state;
	}
	public void setApv_no(int apv_no) {
		this.apv_no = apv_no;
	}
	public void setState(int state) {
		this.state = state;
	}
	public void setApv_date(Timestamp apv_date) {
		this.apv_date = apv_date;
	}
	public void setIs_my_turn(int is_my_turn) {
		this.is_my_turn = is_my_turn;
	}
	public void setTotal_order_state(int total_order_state) {
		this.total_order_state = total_order_state;
	}
	public int getRow_num() {
		return row_num;
	}
	public String getApprovers_name() {
		return approvers_name;
	}
	public String getApprovers_team() {
		return approvers_team;
	}
	public String getAll_approvers() {
		return all_approvers;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public void setApprovers_name(String approvers_name) {
		this.approvers_name = approvers_name;
	}
	public void setApprovers_team(String approvers_team) {
		this.approvers_team = approvers_team;
	}
	public void setAll_approvers(String all_approvers) {
		this.all_approvers = all_approvers;
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
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public void setOri_filename(String ori_filename) {
		this.ori_filename = ori_filename;
	}
	public void setNew_filename(String new_filename) {
		this.new_filename = new_filename;
	}
	public int getIs_comp() {
		return is_comp;
	}
	public void setIs_comp(int is_comp) {
		this.is_comp = is_comp;
	}
	
}
