package com.edu.care.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

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



}
