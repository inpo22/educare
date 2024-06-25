package com.edu.care.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.dto.BoardDTO;
import com.edu.care.service.BoardService;

@Controller
public class BoardController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	BoardService boardService;

//////////////////////////////////////////////////////// 전사 //////////////////////////////////////////////////////////////////////////
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
		return boardService.detail(post_no, user_code);
	}

	// 전사 공지사항 작성페이지 이동
	@GetMapping(value = "/allBoard/write.go")
	public String allBoardWriteGo() {
		logger.info("전사 공지사항 글작성 페이지 접속");
		return "board/allBoard_write";
	}

	// 전사 공지사항 작성
	@PostMapping(value = "/allBoard/write.do")
	public String allBoardWrite(@RequestParam("attachFile") MultipartFile[] attachFile, BoardDTO dto,
			HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		logger.info("\n DTO Title :{}", dto.getTitle());
		logger.info("\n DTO contents :{}", dto.getContents());
		logger.info("\n DTO fixed_yn :{}", dto.getFixed_yn());
		logger.info("attachFile =" + attachFile[0].getContentType());
		logger.info("attachFile =" + attachFile[0].getOriginalFilename());
		logger.info("attachFile =" + attachFile[0].getSize());

		dto.setUser_code(user_code);
		boardService.allBoardWrite(attachFile, dto);

		return "redirect:/allBoard/detail.go?post_no=" + dto.getPost_no();
	}

	// 전사 공지사항 수정페이지 이동
	@GetMapping(value = "/allBoard/update.go")
	public ModelAndView allBoardUpdateGo(String post_no) {
		logger.info("공지사항 글수정 페이지 접속");

		return boardService.detail(post_no);
	}

	// 전사 공지사항 수정
	@PostMapping(value = "/allBoard/update.do")
	public String allBoardUpdate(@RequestParam("attachFile") MultipartFile[] attachFile,
			@RequestParam Map<String, String> param, HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		logger.info("\n param  :{}", param);
		logger.info("fileNameList=" + param.get("fileNumbers"));
		logger.info("attachFile =" + attachFile.length);
		String[] fileNumbers = param.get("fileNumbers").split(",");
		param.put("user_code", user_code);
		boardService.fileDelete(fileNumbers, param.get("post_no"));
		boardService.boardUpdate(attachFile, param);
		return "redirect:/allBoard/detail.go?post_no=" + param.get("post_no");
	}

//////////////////////////////////////////////////////// 공통 //////////////////////////////////////////////////////////////////////////
	// 파일 다운로드
	@RequestMapping(value = "/board/download/{fileName}")
	public ResponseEntity<Resource> download(@PathVariable String fileName) {
		logger.info("download fileName : " + fileName);
		return boardService.download(fileName);
	}

	// 공지사항 삭제
	@PostMapping(value = "/board/del.ajax")
	@ResponseBody
	public Map<String, Object> del(String post_no, HttpSession session) {
		logger.info("삭제요청");
		logger.info(post_no);
		Map<String, Object> map = new HashMap<String, Object>();
		int row = boardService.del(post_no);
		if (row > 0) {
			map.put("row", row);
		}
		return map;
	}

//////////////////////////////////////////////////////// 부서 //////////////////////////////////////////////////////////////////////////
	// 부서 공지사항 리스트 페이지 이동
	@GetMapping(value = "/teamBoard/list.go")
	public String teamBoardList(Model model, HttpSession session) {
		String teamCode = (String) session.getAttribute("team_code");
		boolean isPerm = false;

		// 권한 체크: 대표이사(T001) 또는 인사총무팀(T06)만 모든 게시글 조회 권한 부여
		if (teamCode.equals("T001") || teamCode.equals("T06")) {
			isPerm = true;
		}

		// 게시글 조회
		Map<String, Object> result = boardService.teamList(1, 10, null, null, teamCode);
		model.addAttribute("list", result.get("list"));
		model.addAttribute("totalPage", result.get("totalPage"));
		model.addAttribute("topFixedTeamList", result.get("topFixedTeamList"));
		model.addAttribute("isPerm", isPerm);

		return "board/teamBoard_list";
	}

	// 부서 공지사항 리스트 AJAX 호출
	@PostMapping(value = "/teamBoard/list.ajax")
	@ResponseBody
	public Map<String, Object> teamList(HttpSession session, @RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "searchCategory", required = false) String searchCategory,
			@RequestParam(value = "searchWord", required = false) String searchWord,
			@RequestParam(value = "selectedTeamCode", required = false) String selectedTeamCode) {
		String teamCode = (String) session.getAttribute("team_code");

		// 선택된 팀 코드가 있을 경우 해당 팀 코드로 변경
		if (selectedTeamCode != null && !selectedTeamCode.isEmpty()) {
			teamCode = selectedTeamCode;
		}

		// 게시글 조회
		Map<String, Object> result = boardService.teamList(page, 10, searchCategory, searchWord, teamCode);
		result.put("isPerm", teamCode.equals("T001") || teamCode.equals("T06")); // 권한 여부 추가

		return result;
	}

	// 부서 공지사항 상세페이지 접속
	@GetMapping(value = "/teamBoard/detail.go")
	public ModelAndView teamBoardDetail(String post_no, HttpSession session) {
		logger.info(post_no);
		String user_code = (String) session.getAttribute("user_code");
		return boardService.teamDetail(post_no, user_code);
	}

	// 부서 공지사항 글작성페이지 이동
	@GetMapping(value = "/teamBoard/write.go")
	public String teamWriteGo() {
		logger.info("부서 글작성 페이지 접속");
		return "board/teamBoard_write";
	}

	// 부서 공지사항 글작성
	@PostMapping(value = "/teamBoard/write.do")
	public String teamBoardWrite(@RequestParam("attachFile") MultipartFile[] attachFile, BoardDTO dto,
			HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		logger.info("\n DTO Title :{}", dto.getTitle());
		logger.info("\n DTO contents :{}", dto.getContents());
		logger.info("\n DTO fixed_yn :{}", dto.getFixed_yn());
		logger.info("attachFile =" + attachFile[0].getContentType());
		logger.info("attachFile =" + attachFile[0].getOriginalFilename());
		logger.info("attachFile =" + attachFile[0].getSize());

		dto.setUser_code(user_code);
		boardService.teamBoardWrite(attachFile, dto);

		return "redirect:/teamBoard/detail.go?post_no=" + dto.getPost_no();
	}

	// 부서 글수정 페이지 이동
	@GetMapping(value = "/teamBoard/update.go")
	public ModelAndView teamBoardUpdateGo(String post_no) {
		logger.info("부서 글수정 페이지 접속");

		return boardService.detail(post_no);
	}

	// 부서 공지사항 수정
	@PostMapping(value = "/teamBoard/update.do")
	public String teamBoardUpdate(@RequestParam("attachFile") MultipartFile[] attachFile,
			@RequestParam Map<String, String> param, HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		logger.info("\n param  :{}", param);
		logger.info("fileNameList=" + param.get("fileNumbers"));
		logger.info("attachFile =" + attachFile.length);
		String[] fileNumbers = param.get("fileNumbers").split(",");
		param.put("user_code", user_code);
		boardService.fileDelete(fileNumbers, param.get("post_no"));
		boardService.boardUpdate(attachFile, param);
		return "redirect:/teamBoard/detail.go?post_no=" + param.get("post_no");
	}

//////////////////////////////////////////////////////// 학생 //////////////////////////////////////////////////////////////////////////
	// 학생 공지사항 리스트 페이지 이동
	@GetMapping(value = "/stdBoard/list.go")
	public String stuBoardList() {
		logger.info("학생공지사항 리스트 페이지 이동");
		return "board/stdBoard_list";
	}

	// 학생 공지사항 리스트 불러오기
	@PostMapping(value = "/stdBoard/list.ajax")
	@ResponseBody
	public Map<String, Object> stdList(String page, String searchCategory, String searchWord) {

		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;

		return boardService.stdList(currPage, pagePerCnt, searchCategory, searchWord);
	}

	// 학생 공지사항 상세페이지 접속
	@GetMapping(value = "/stdBoard/detail.go")
	public ModelAndView stdBoardDetail(String post_no, HttpSession session) {
		logger.info(post_no);
		String user_code = (String) session.getAttribute("user_code");
		return boardService.stdDetail(post_no, user_code);
	}

	// 학생 공지사항 작성페이지 이동
	@GetMapping(value = "/stdBoard/write.go")
	public String stdBoardWriteGo() {
		logger.info("전사 공지사항 글작성 페이지 접속");
		return "board/stdBoard_write";
	}

	// 학생 공지사항 작성
	@PostMapping(value = "/stdBoard/write.do")
	public String stdBoardWrite(@RequestParam("attachFile") MultipartFile[] attachFile, BoardDTO dto,
			HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		logger.info("\n DTO Title :{}", dto.getTitle());
		logger.info("\n DTO contents :{}", dto.getContents());
		logger.info("\n DTO fixed_yn :{}", dto.getFixed_yn());
		logger.info("attachFile =" + attachFile[0].getContentType());
		logger.info("attachFile =" + attachFile[0].getOriginalFilename());
		logger.info("attachFile =" + attachFile[0].getSize());

		dto.setUser_code(user_code);
		boardService.stdBoardWrite(attachFile, dto);

		return "redirect:/stdBoard/detail.go?post_no=" + dto.getPost_no();
	}

	// 핛생 공지사항 수정페이지 이동
	@GetMapping(value = "/stdBoard/update.go")
	public ModelAndView stdBoardUpdateGo(String post_no) {
		logger.info("학생 글수정 페이지 접속");

		return boardService.detail(post_no);
	}

	// 학생 공지사항 수정
	@PostMapping(value = "/stdBoard/update.do")
	public String stdBoardUpdate(@RequestParam("attachFile") MultipartFile[] attachFile,
			@RequestParam Map<String, String> param, HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		logger.info("\n param  :{}", param);
		logger.info("fileNameList=" + param.get("fileNumbers"));
		logger.info("attachFile =" + attachFile.length);
		String[] fileNumbers = param.get("fileNumbers").split(",");
		param.put("user_code", user_code);
		boardService.fileDelete(fileNumbers, param.get("post_no"));
		boardService.boardUpdate(attachFile, param);
		return "redirect:/stdBoard/detail.go?post_no=" + param.get("post_no");
	}

//////////////////////////////////////////////////////// 자료실 //////////////////////////////////////////////////////////////////////////
	// 자료실 리스트 페이지 이동
	@GetMapping(value = "/dataBoard/list.go")
	public String dataBoardList() {
		return "board/dataBoard_list";
	}

}
