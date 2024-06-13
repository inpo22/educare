package com.edu.care.dto;

import org.apache.ibatis.type.Alias;

@Alias(value="dept")
public class DeptDTO {
	
	private String team_code;
	private String team_name;
	private String upper_code;
	private String reg_date;
	
	public String getTeam_code() {
		return team_code;
	}
	public void setTeam_code(String team_code) {
		this.team_code = team_code;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getUpper_code() {
		return upper_code;
	}
	public void setUpper_code(String upper_code) {
		this.upper_code = upper_code;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
		
	

}
