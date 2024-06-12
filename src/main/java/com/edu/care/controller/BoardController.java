package com.edu.care.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.edu.care.service.BoardService;

@Controller
public class BoardController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardService boardService;
	
	@GetMapping(value="/allBoard/list.go")
	public String allBoardList() {
		return "board/allBoard_list";
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
