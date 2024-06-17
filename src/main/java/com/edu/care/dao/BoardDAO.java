package com.edu.care.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.BoardDTO;

@Mapper
public interface BoardDAO {

	List<BoardDTO> allList(int start, int pagePerCnt, String searchCategory, String searchWord);

	int allListPageCnt(int pagePerCnt, String searchCategory, String searchWord);

	List<BoardDTO> topFixedList();

}
