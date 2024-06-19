package com.edu.care.dto;



import org.apache.ibatis.type.Alias;

@Alias(value="login")
public class LoginDTO {
	
	private String user_code;
	private String name;
	private String class_code;
	private String team_code;
	private String classify_code;
	private String team_name;
	private String photo;
	

	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getUser_code() {
		return user_code;
	}
	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getClass_code() {
		return class_code;
	}
	public void setClass_code(String class_code) {
		this.class_code = class_code;
	}
	public String getTeam_code() {
		return team_code;
	}
	public void setTeam_code(String team_code) {
		this.team_code = team_code;
	}
	public String getClassify_code() {
		return classify_code;
	}
	public void setClassify_code(String classify_code) {
		this.classify_code = classify_code;
	}
	
	
}
