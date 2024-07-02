package com.edu.care.dao;

import java.sql.Timestamp;
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

	List<ApprovalDTO> getApprovalListCall(int start, int pagePerCnt, String user_code, String condition,
			String content);

	int getApprovalPageCnt(int pagePerCnt, String user_code, String condition, String content);

	List<ApprovalDTO> compApprovalListCall(int start, int pagePerCnt, String user_code, String condition,
			String content);

	int compApprovalPageCnt(int pagePerCnt, String user_code, String condition, String content);

	List<ApprovalDTO> viewApprovalListCall(int start, int pagePerCnt, String team_code, String condition,
			String content);

	int viewApprovalPageCnt(int pagePerCnt, String team_code, String condition, String content);

	List<ApprovalDTO> reqeustApprovalListCall(int start, int pagePerCnt, String user_code, String condition,
			String content);

	int requestApprovalPageCnt(int pagePerCnt, String user_code, String condition, String content);

	List<ApprovalDTO> finishApprovalListCall(int start, int pagePerCnt, String user_code, String condition,
			String content);

	int finishApprovalPageCnt(int pagePerCnt, String user_code, String condition, String content);

	List<ApprovalDTO> rejectedApprovalListCall(int start, int pagePerCnt, String user_code, String condition,
			String content);

	int rejectedApprovalPageCnt(int pagePerCnt, String user_code, String condition, String content);

	ApprovalDTO approvalDetail(String au_code);

	List<ApprovalDTO> orderList(String au_code, String user_code);

	List<ApprovalDTO> attachFileList(String au_code);

	List<ApprovalDTO> receiveTeamList(String au_code);

	double remainVaca(String detail_user_code, String reg_date);

	void minusRemainVaca(String user_code, String au_code);

	String getOriFileName(String file_no, String new_filename);

	void approve(String au_code, String user_code);

	void reject(String au_code, String user_code);

	int orderCompCheck(String au_code, String user_code);

	void scheduleWrite(ApprovalDTO dto);

	String notiReceiveUser(String au_code, String user_code);

}
