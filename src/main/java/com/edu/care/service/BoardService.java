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
import com.edu.care.dao.NotiDAO;
import com.edu.care.dto.BoardDTO;

@Service
public class BoardService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	BoardDAO boardDAO;
	@Autowired NotiDAO notiDAO;
	
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
		int row = boardDAO.del(post_no);
		if(row > 0) {
			logger.info("delete noti post_no = "+post_no);
			notiDAO.deleteNoti(post_no, 1);
		}
		
		return row;
	}

	@Transactional
	public int allBoardWrite(MultipartFile[] attachFile, BoardDTO dto) {
		int row = boardDAO.allBoardWrite(dto);
		if(row > 0) {
			String userCode = dto.getUser_code();
			String postNo = ""+dto.getPost_no();
			
			List<String> allUserCodes = boardDAO.getAllUserCodes(); 
			for (String toUserCode : allUserCodes) {
				notiDAO.sendNoti(toUserCode, userCode, postNo, 1);				
			}
		}
		
		if (attachFile[0].getSize() != 0) {
			fileSave(attachFile, dto);
		}
		
		logger.info("데이터 추가 후 현재 글번호 = " + dto.getPost_no());
		return row;
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

	@Transactional
	public ModelAndView teamDetail(String post_no, String user_code) {
		ModelAndView mav = new ModelAndView("board/teamBoard_detail");
		BoardDTO dto = boardDAO.teamDetail(post_no);
		boardDAO.upHit(post_no);
		List<BoardDTO> attachFileList = boardDAO.attachFileList(post_no);
		dto.setPost_no(Integer.parseInt(post_no));
		mav.addObject("dto", dto);
		mav.addObject("attachFileList", attachFileList);
		mav.addObject("isPerm", boardDAO.isPerm(user_code, post_no));

		return mav;
	}

	@Transactional
	public int teamBoardWrite(MultipartFile[] attachFile, BoardDTO dto) {
		int row = boardDAO.teamBoardWrite(dto);
		
		if(row > 0) {
			List<String> teamUserList = boardDAO.teamUserList(dto.getTeamCode());
			
			for (String toTeamUser : teamUserList) {
				notiDAO.sendNoti(toTeamUser, dto.getUser_code(),  ""+dto.getPost_no(), 4);
			}
		}
		
		if (attachFile[0].getSize() != 0) {
			fileSave(attachFile, dto);
		}
		logger.info("데이터 추가 후 현재 글번호 = " + dto.getPost_no());
		
		return row;
	}
	
	public Map<String, Object> stdList(Map<String, String> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		int pagePerCnt = 10;
		int start = (Integer.parseInt(map.get("page")) - 1) * pagePerCnt;
		String searchCategory = map.get("searchCategory");
		String searchWord = map.get("searchWord");
		logger.info(searchWord);
		logger.info(searchWord.isBlank()+"");
		List<BoardDTO> topFixedList = new ArrayList<BoardDTO>();
		int fixCnt = 0;

		if (searchWord == "") {
			topFixedList = boardDAO.topFixedStdList();
			if (topFixedList != null) {
				fixCnt = topFixedList.size();
			}
		}
		int totalPage = boardDAO.stdListPageCnt(pagePerCnt, searchCategory, searchWord);

		if (start == 0) {
			pagePerCnt -= fixCnt;
		} else {
			start -= fixCnt;
		}

		List<BoardDTO> list = boardDAO.stdList(start, pagePerCnt, searchCategory, searchWord);

		result.put("list", list);
		result.put("totalPage", totalPage);
		result.put("topFixedList", topFixedList);
		return result;
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
	public int stdBoardWrite(MultipartFile[] attachFile, BoardDTO dto) {
	
		if (attachFile[0].getSize() != 0) {
			fileSave(attachFile, dto);
		}
		logger.info("데이터 추가 후 현재 글번호 = " + dto.getPost_no());
		return boardDAO.stdBoardWrite(dto);
	}

	public List<BoardDTO> teamSelectList() {

		return boardDAO.teamSelectList();
	}

	public Map<String, Object> dataList(Map<String, String> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		int pagePerCnt = 10;
		int start = (Integer.parseInt(map.get("page")) - 1) * pagePerCnt;
		String searchCategory = map.get("searchCategory");
		String searchWord = map.get("searchWord");

		int totalPage = boardDAO.dataListPageCnt(pagePerCnt, searchCategory, searchWord);

		List<BoardDTO> list = boardDAO.dataList(start, pagePerCnt, searchCategory, searchWord);

		result.put("list", list);
		result.put("totalPage", totalPage);

		return result;
	}

	public ModelAndView dataDetail(String post_no, String user_code) {
		ModelAndView mav = new ModelAndView("board/dataBoard_detail");
		BoardDTO dto = boardDAO.dataDetail(post_no);
		boardDAO.upHit(post_no);
		List<BoardDTO> attachFileList = boardDAO.attachFileList(post_no);
		dto.setPost_no(Integer.parseInt(post_no));
		mav.addObject("dto", dto);
		mav.addObject("attachFileList", attachFileList);
		mav.addObject("isPerm", boardDAO.isPerm(user_code, post_no));
		
		
		return mav;
	}
	
	@Transactional
	public int dataBoardWrite(MultipartFile[] attachFile, BoardDTO dto) {
		
		if (attachFile[0].getSize() != 0) {
			fileSave(attachFile, dto);
		}
		
		logger.info("데이터 추가 후 현재 글번호 = " + dto.getPost_no());
		return boardDAO.dataBoardWrite(dto);
	}

	public void databoardUpdate(MultipartFile[] attachFile, Map<String, String> param) {
		logger.info("param : {} ", param);
		boardDAO.databoardUpdate(param);
		
		BoardDTO dto = new BoardDTO();
		dto.setUser_code(param.get("user_code"));
		dto.setPost_no(Integer.parseInt(param.get("post_no")));
		
		if (attachFile[0].getSize() != 0) {
			fileSave(attachFile, dto);
		}
	}





}
