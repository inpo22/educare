package com.edu.care.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.care.dao.BoardDAO;
import com.edu.care.dto.BoardDTO;

@Service
public class BoardService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardDAO boardDAO;

	public Map<String, Object> allList(int currPage, int pagePerCnt, String searchCategory, String searchWord) {
		Map<String, Object> map = new HashMap<String, Object>();
		int start = (currPage-1) * pagePerCnt;
		
		List<BoardDTO> list = boardDAO.allList(start, pagePerCnt, searchCategory, searchWord);
		map.put("list", list);
		map.put("totalPage", boardDAO.allListPageCnt(pagePerCnt, searchCategory, searchWord));
		map.put("topFixedList", boardDAO.topFixedList());
		return map;
	}
	
}
