package com.edu.care.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.dao.BoardDAO;
import com.edu.care.dto.BoardDTO;

@Service
public class BoardService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	BoardDAO boardDAO;

	@Value("${spring.servlet.multipart.location}")
	private String root;

	public Map<String, Object> allList(Map<String, String> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		int pagePerCnt = 10;
		int start = (Integer.parseInt(map.get("page")) - 1) * pagePerCnt;
		String searchCategory = map.get("searchCategory");
		String searchWord = map.get("searchWord");
		
		List<BoardDTO> topFixedList = new ArrayList<BoardDTO>();
		int fixCnt = 0;
		
		if (searchWord == "") {
			topFixedList = boardDAO.topFixedList();
			if(topFixedList != null) {
				fixCnt = topFixedList.size();
			}	
		}
		int totalPage = boardDAO.allListPageCnt(pagePerCnt, searchCategory, searchWord);
		
		if (start == 0) {
			pagePerCnt -= fixCnt;
		} else {
			start -= fixCnt;
		}
		
		List<BoardDTO> list = boardDAO.allList(start, pagePerCnt, searchCategory, searchWord);
		
		result.put("list", list);
		result.put("totalPage", totalPage);
		result.put("topFixedList", topFixedList);
		return result;
	}

	@Transactional
	public ModelAndView allDetail(String post_no, String user_code) {
		ModelAndView mav = new ModelAndView("board/allBoard_detail");
		BoardDTO dto = boardDAO.detail(post_no);
		boardDAO.upHit(post_no);
		List<BoardDTO> attachFileList = boardDAO.attachFileList(post_no);
		dto.setPost_no(Integer.parseInt(post_no));
		mav.addObject("dto", dto);
		mav.addObject("attachFileList", attachFileList);
		mav.addObject("isPerm", boardDAO.isPerm(user_code, post_no));
		return mav;
	}

	public ResponseEntity<Resource> download(String fileName) {
		String ori_fileName = boardDAO.getOriFileName(fileName);

		Resource resource = new FileSystemResource(root + "/" + fileName);
		HttpHeaders header = new HttpHeaders();

		try {
			header.add("content-type", "application/ortet-stream");
			String oriFile = URLEncoder.encode(ori_fileName, "UTF-8");
			header.add("content-Disposition", "attachment;filename=\"" + oriFile + "\"");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}

	public int del(String post_no) {
		return boardDAO.del(post_no);
	}

	@Transactional
	public void allBoardWrite(MultipartFile[] attachFile, BoardDTO dto) {
		boardDAO.allBoardWrite(dto);
		if (attachFile[0].getSize() != 0) {
			fileSave(attachFile, dto);
		}
		logger.info("데이터 추가 후 현재 글번호 = " + dto.getPost_no());
	}

	public void detail(String post_no, Model model) {
		BoardDTO dto = boardDAO.detail(post_no);
		List<BoardDTO> attachFileList = boardDAO.attachFileList(post_no);
		dto.setPost_no(Integer.parseInt(post_no));
		model.addAttribute("dto", dto);
		model.addAttribute("attachFileList",attachFileList);
	}

	@Transactional
	public void fileDelete(String[] fileNumbers, Object object) {
		List<BoardDTO> oldFileList = boardDAO.oldFileList(object);
		boolean isFileNameSame = false;
		for (BoardDTO boardDTO : oldFileList) {
			logger.info("\nfileName = " + boardDTO.getNew_filename() + "\nfileNo = " + boardDTO.getFile_no());
			for (String fileNumber : fileNumbers) {
				if (boardDTO.getFile_no().equals(fileNumber) == true) {
					isFileNameSame = true;
					break;
				}
			}
			if (isFileNameSame == false) {
				boardDAO.delAttachFile(boardDTO.getFile_no());
				File file = new File(root + boardDTO.getNew_filename());
				if (file.exists()) {
					file.delete();
				}
			}
			isFileNameSame = false;
		}

	}

	public void boardUpdate(MultipartFile[] attachFile, Map<String, String> param) {
		logger.info("param : {} ", param);
		boardDAO.boardUpdate(param);
		
		BoardDTO dto = new BoardDTO();
		dto.setUser_code(param.get("user_code"));
		dto.setPost_no(Integer.parseInt(param.get("post_no")));
		
		if (attachFile[0].getSize() != 0) {
			fileSave(attachFile, dto);
		}
	}

	// 파일 저장
	private void fileSave(MultipartFile[] attachFile, BoardDTO dto) {
		for (MultipartFile file : attachFile) {
			logger.info(file.getOriginalFilename());
			dto.setOri_filename(file.getOriginalFilename());
			boardDAO.fileSave(dto);

			String new_filename = "allboardFile_" + dto.getPost_no() + '_' + dto.getFile_no()
					+ dto.getOri_filename().substring(dto.getOri_filename().lastIndexOf("."));
			dto.setNew_filename(new_filename);
			boardDAO.newFileNameUpdate(dto);
			try {
				byte[] bytes = file.getBytes();
				Path path = Paths.get(root + new_filename);
				Files.write(path, bytes);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public List<String> teamBoardList(String teamCode) {
		List<String> list = boardDAO.teamBoardList(teamCode);
		return list;
	}
	/*
	public Map<String, Object> teamList(int currPage, int pagePerCnt, String searchCategory, String searchWord,
			String teamCode) {
		Map<String, Object> map = new HashMap<>();
		int start = (currPage - 1) * pagePerCnt;
		logger.info("\n::::::::::::::::::::::::::::::::::::::::::::::::currPag="+ currPage
				+"\n::::::::::::::::::::::::::::::::::::::::::::::::pagePerCnt="+ pagePerCnt
				+"\n::::::::::::::::::::::::::::::::::::::::::::::::searchCategory="+ searchCategory
				+"\n::::::::::::::::::::::::::::::::::::::::::::::::searchWord="+ searchWord
				+"\n::::::::::::::::::::::::::::::::::::::::::::::::teamCode="+ teamCode
				);
		
		List<BoardDTO> list;
		int totalPage;
		List<BoardDTO> topFixedTeamList;
		
		list = boardDAO.teamList(start, pagePerCnt, searchCategory, searchWord, teamCode);
		totalPage = boardDAO.teamListPageCnt(pagePerCnt, searchCategory, searchWord, teamCode);
		topFixedTeamList = boardDAO.topFixedTeamList(teamCode);
		
		
		if (teamCode != null && (teamCode.equals("T001") || teamCode.equals("T006"))) {
			// 권한 있는 부서의 경우 모든 게시글 조회
			list = boardDAO.teamList(start, pagePerCnt, searchCategory, searchWord, null);
			totalPage = boardDAO.teamListPageCnt(pagePerCnt, searchCategory, searchWord, null);
			topFixedTeamList = boardDAO.topFixedTeamList(null);
		} else {
			// 권한 없는 부서의 경우 해당 부서의 게시글만 조회
			list = boardDAO.teamList(start, pagePerCnt, searchCategory, searchWord, teamCode);
			totalPage = boardDAO.teamListPageCnt(pagePerCnt, searchCategory, searchWord, teamCode);
			topFixedTeamList = boardDAO.topFixedTeamList(teamCode);
			logger.info(teamCode);
		}
		 
		map.put("list", list);
		map.put("totalPage", totalPage);
		map.put("topFixedTeamList", topFixedTeamList);

		return map;
	}
	*/
	
	public Map<String, Object> teamList(Map<String, String> map, String my_team_code) {
		Map<String, Object> result = new HashMap<String, Object>();
		int pagePerCnt = 10;
		int start = (Integer.parseInt(map.get("page")) - 1) * pagePerCnt;
		String searchCategory = map.get("searchCategory");
		String searchWord = map.get("searchWord");
		String teamCode = "";
		
		if (my_team_code.equals("T001") || my_team_code.equals("T006")) {
			teamCode = map.get("selectedTeamCode");
		} else {
			teamCode = my_team_code;
		}
		
		
		List<BoardDTO> topFixedTeamList = new ArrayList<BoardDTO>();
		int fixCnt = 0;
		
		if (searchWord == "") {
			topFixedTeamList = boardDAO.topFixedTeamList(teamCode);
			if(topFixedTeamList != null) {
				fixCnt = topFixedTeamList.size();
			}	
		}
		int totalPage = boardDAO.teamListPageCnt(pagePerCnt, searchCategory, searchWord, teamCode);
		
		if (start == 0) {
			pagePerCnt -= fixCnt;
		} else {
			start -= fixCnt;
		}
		
		List<BoardDTO> list = boardDAO.teamList(start, pagePerCnt, searchCategory, searchWord, teamCode);
		
		result.put("list", list);
		result.put("totalPage", totalPage);
		result.put("topFixedTeamList", topFixedTeamList);
		
		return result;
	}

//		public List<BoardDTO> getNoticesByTeamCode(String teamCode) {
//
//			return boardDAO.getNoticesByTeamCode(teamCode);
//		}

	@Transactional
	public ModelAndView teamDetail(String post_no, String user_code) {
		ModelAndView mav = new ModelAndView("board/teamBoard_detail");
		BoardDTO dto = boardDAO.detail(post_no);
		boardDAO.upHit(post_no);
		List<BoardDTO> attachFileList = boardDAO.attachFileList(post_no);
		dto.setPost_no(Integer.parseInt(post_no));
		mav.addObject("dto", dto);
		mav.addObject("attachFileList", attachFileList);
		mav.addObject("isPerm", boardDAO.isPerm(user_code, post_no));

		return mav;
	}

	@Transactional
	public void teamBoardWrite(MultipartFile[] attachFile, BoardDTO dto) {
		boardDAO.teamBoardWrite(dto);
		if (attachFile[0].getSize() != 0) {
			fileSave(attachFile, dto);
		}
		logger.info("데이터 추가 후 현재 글번호 = " + dto.getPost_no());
	}

	public Map<String, Object> stdList(int currPage, int pagePerCnt, String searchCategory, String searchWord) {
		Map<String, Object> map = new HashMap<String, Object>();
		int start = (currPage - 1) * pagePerCnt;

		List<BoardDTO> list = boardDAO.stdList(start, pagePerCnt, searchCategory, searchWord);
		map.put("list", list);
		map.put("totalPage", boardDAO.stdListPageCnt(pagePerCnt, searchCategory, searchWord));
		map.put("topFixedList", boardDAO.topFixedStdList());
		return map;
	}

	public ModelAndView stdDetail(String post_no, String user_code) {
		ModelAndView mav = new ModelAndView("board/stdBoard_detail");
		BoardDTO dto = boardDAO.detail(post_no);
		boardDAO.upHit(post_no);
		List<BoardDTO> attachFileList = boardDAO.attachFileList(post_no);
		dto.setPost_no(Integer.parseInt(post_no));
		mav.addObject("dto", dto);
		mav.addObject("attachFileList", attachFileList);
		mav.addObject("isPerm", boardDAO.isPerm(user_code, post_no));
		return mav;
	}

	@Transactional
	public void stdBoardWrite(MultipartFile[] attachFile, BoardDTO dto) {
		boardDAO.stdBoardWrite(dto);
		if (attachFile[0].getSize() != 0) {
			fileSave(attachFile, dto);
		}
		logger.info("데이터 추가 후 현재 글번호 = " + dto.getPost_no());
	}

	public List<BoardDTO> teamSelectList() {

		return boardDAO.teamSelectList();
	}



}
