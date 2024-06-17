package com.edu.care.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.care.service.BoardService;

@Controller
public class BoardController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardService boardService;
	
	@GetMapping(value="/allBoard/list.go")
	public String allBoardList() {
		logger.info("전사공지사항 리스트 페이지 접속");
		return "board/allBoard_list";
	}
	
	@PostMapping(value="/allBoard/list.ajax")
	@ResponseBody
	public Map<String, Object> allList(String page, String searchCategory, String searchWord){
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		return boardService.allList(currPage, pagePerCnt, searchCategory, searchWord);
	}
	
	
	@GetMapping(value="/affairsBoard/list.go")
	public String affairsBoardList() {
		return "board/affairsBoard_list";
	}
	
	@GetMapping(value="/trainingBoard/list.go")
	public String trainingBoardList() {
		return "board/trainingBoard_list";
	}
	
	@GetMapping(value="/mgmtBoard/list.go")
	public String mgmtBoardList() {
		return "board/mgmtBoard_list";
	}
	
	@GetMapping(value="/acctBoard/list.go")
	public String acctBoardList() {
		return "board/acctBoard_list";
	}
	
	@GetMapping(value="/stuBoard/list.go")
	public String stuBoardList() {
		return "board/stuBoard_list";
	}
	
	@GetMapping(value="/dataBoard/list.go")
	public String dataBoardList() {
		return "board/dataBoard_list";
	}
	
}
