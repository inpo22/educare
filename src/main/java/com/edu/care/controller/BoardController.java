package com.edu.care.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.service.BoardService;

@Controller
public class BoardController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	BoardService boardService;

	// 전사 공지사항 리스트 페이지
	@GetMapping(value = "/allBoard/list.go")
	public String allBoardList() {
		logger.info("전사공지사항 리스트 페이지 접속");
		return "board/allBoard_list";
	}

	// 전사 공지사항 리스트 불러오기
	@PostMapping(value = "/allBoard/list.ajax")
	@ResponseBody
	public Map<String, Object> allList(String page, String searchCategory, String searchWord) {

		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;

		return boardService.allList(currPage, pagePerCnt, searchCategory, searchWord);
	}

	// 전사 공지사항 상세페이지 접속
	@GetMapping(value = "/allBoard/detail.go")
	public ModelAndView allBoardDetail(String post_no, HttpSession session) {
		logger.info(post_no);
		String user_code = (String) session.getAttribute("user_code");
		return boardService.allDetail(post_no, user_code);
	}

	
	// 부서 공지사항 리스트 페이지 이동
	@GetMapping(value = "/teamBoard/list.go")
	public String affairsBoardList() {
		return "board/teamBoard_list";
	}

	// 학생 공지사항 리스트 페이지 이동
	@GetMapping(value = "/stuBoard/list.go")
	public String stuBoardList() {
		return "board/stuBoard_list";
	}

	// 자료실 리스트 페이지 이동
	@GetMapping(value = "/dataBoard/list.go")
	public String dataBoardList() {
		return "board/dataBoard_list";
	}

	// 파일 다운로드 
	@RequestMapping(value="/board/download/{fileName}")
	public ResponseEntity<Resource> download(@PathVariable String fileName){
		logger.info("download fileName : "+fileName);
		return boardService.download(fileName);
	}
	
	// 공지사항 삭제
	@PostMapping(value="/board/del.ajax")
	public String del(HttpSession session, String post_no) {
		logger.info("삭제요청");
		return	null;
	}
}







