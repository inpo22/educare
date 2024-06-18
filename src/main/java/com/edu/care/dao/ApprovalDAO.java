package com.edu.care.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.ApprovalDTO;

@Mapper
public interface ApprovalDAO {

	List<ApprovalDTO> deptList();

	List<ApprovalDTO> empList();
	
	String createAu_code(String team_code, int au_type);

	void vacaApprovalWrite(ApprovalDTO dto);

	void orderInsert(String au_code, String order);

	void fileSave(String user_code, String ori_filename, String new_filename, String au_code, String file_type);

	void busiApprovalWrite(ApprovalDTO dto);

	void receiveTeamInsert(String au_code, String team);

}
