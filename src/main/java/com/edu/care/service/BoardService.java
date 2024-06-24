package com.edu.care.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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

	public Map<String, Object> allList(int currPage, int pagePerCnt, String searchCategory, String searchWord) {
		Map<String, Object> map = new HashMap<String, Object>();
		int start = (currPage - 1) * pagePerCnt;

		List<BoardDTO> list = boardDAO.allList(start, pagePerCnt, searchCategory, searchWord);
		map.put("list", list);
		map.put("totalPage", boardDAO.allListPageCnt(pagePerCnt, searchCategory, searchWord));
		map.put("topFixedList", boardDAO.topFixedList());
		return map;
	}

	@Transactional
	public ModelAndView allDetail(String post_no, String user_code) {
		ModelAndView mav = new ModelAndView("board/allBoard_detail");
		BoardDTO dto = boardDAO.allDetail(post_no);
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


	public ModelAndView allDetail(String post_no) {
		ModelAndView mav = new ModelAndView("board/allBoard_update");
		BoardDTO dto = boardDAO.allDetail(post_no);
		List<BoardDTO> attachFileList = boardDAO.attachFileList(post_no);
		dto.setPost_no(Integer.parseInt(post_no));
		mav.addObject("dto", dto);
		mav.addObject("attachFileList", attachFileList);
		return mav;
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

	public void allBoardUpdate(MultipartFile[] attachFile, Map<String, String> param) {
		logger.info("param : {} ", param);
		boardDAO.allBoardUpdate(param);
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

		public List<String> teamBoardList() {
			List<String> list = boardDAO.teamBoardList();
			return list;
		}

		public Map<String, Object> teamList(int currPage, int pagePerCnt, String searchCategory, String searchWord) {
			Map<String, Object> map = new HashMap<String, Object>();
			int start = (currPage - 1) * pagePerCnt;
			
			List<BoardDTO> list = boardDAO.teamList(start, pagePerCnt, searchCategory, searchWord);
			map.put("list", list);
			map.put("totalPage", boardDAO.teamListPageCnt(pagePerCnt, searchCategory, searchWord));
			map.put("topFixedTeamList", boardDAO.topFixedTeamList());
			
			return map;
		}

		public boolean isUpperCodeT02(String teamCode) {
			String upperCode = boardDAO.isUpperCodeT02(teamCode);
			return "T02".equals(upperCode);
		}
}















