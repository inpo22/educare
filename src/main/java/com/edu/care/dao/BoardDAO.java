package com.edu.care.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

import com.edu.care.dto.BoardDTO;
import com.edu.care.dto.EmpDTO;

@Mapper
public interface BoardDAO {

	List<BoardDTO> allList(int start, int pagePerCnt, String searchCategory, String searchWord);

	int allListPageCnt(int pagePerCnt, String searchCategory, String searchWord);

	List<BoardDTO> topFixedList();

	BoardDTO allDetail(String post_no);

	List<BoardDTO> attachFileList(String post_no);

	String getOriFileName(String fileName);

	int del(String post_no);

	void upHit(String post_no);

	boolean isPerm(String user_code, String post_no);

	void allBoardWrite(BoardDTO dto);

	void fileSave(BoardDTO dto);

	List<BoardDTO> oldFileList(Object object);

	void delAttachFile(String file_no);

	void allBoardUpdate(Map<String, String> param);

	String lastFileName(String string);

	void newFileNameUpdate(BoardDTO dto);

	List<String> teamBoardList();

	List<BoardDTO> teamList(int currPage, int pagePerCnt, String searchCategory, String searchWord);

	int teamListPageCnt(int pagePerCnt, String searchCategory, String searchWord);

	List<BoardDTO> topFixedTeamList();



}
