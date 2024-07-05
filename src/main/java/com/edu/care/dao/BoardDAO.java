package com.edu.care.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.BoardDTO;

@Mapper
public interface BoardDAO {

	List<BoardDTO> allList(int start, int pagePerCnt, String searchCategory, String searchWord);

	int allListPageCnt(int pagePerCnt, String searchCategory, String searchWord);

	List<BoardDTO> topFixedList();

	BoardDTO detail(String post_no);

	List<BoardDTO> attachFileList(String post_no);

	String getOriFileName(String fileName);

	int del(String post_no);

	void upHit(String post_no);

	boolean isPerm(String user_code, String post_no);

	int allBoardWrite(BoardDTO dto);

	void fileSave(BoardDTO dto);

	List<BoardDTO> oldFileList(Object object);

	void delAttachFile(String file_no);

	void boardUpdate(Map<String, String> param);

	String lastFileName(String string);

	void newFileNameUpdate(BoardDTO dto);

	List<String> teamBoardList(String teamCode);

	List<BoardDTO> teamList(int start, int pagePerCnt, String searchCategory, String searchWord, String teamCode);

	int teamListPageCnt(int pagePerCnt, String searchCategory, String searchWord, String teamCode);

	List<BoardDTO> topFixedTeamList(String teamCode);

	int teamBoardWrite(BoardDTO dto);

	List<BoardDTO> stdList(int start, int pagePerCnt, String searchCategory, String searchWord);

	int stdListPageCnt(int pagePerCnt, String searchCategory, String searchWord);

	List<BoardDTO> topFixedStdList();

	void stdBoardWrite(BoardDTO dto);

	List<BoardDTO> teamSelectList();

	BoardDTO teamDetail(String post_no);

	List<BoardDTO> topFixedDataList();

	int dataListPageCnt(int pagePerCnt, String searchCategory, String searchWord);

	List<BoardDTO> dataList(int start, int pagePerCnt, String searchCategory, String searchWord);

	void dataBoardWrite(BoardDTO dto);

	BoardDTO dataDetail(String post_no);

	List<BoardDTO> courseSelectModal();

	List<String> getAllUserCodes();

	List<String> teamUserList(String team_code);

	void databoardUpdate(Map<String, String> param);

	void topFixedOn(int post_no);

	List<Integer> topFixedListCheck(int board_type, String team_code);

	void topFixedOff(Integer integer);

	BoardDTO checkPostType(int post_no);

//	boolean getFixedCount(String board_no);






}
