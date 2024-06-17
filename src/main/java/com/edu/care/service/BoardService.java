package com.edu.care.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.dao.BoardDAO;
import com.edu.care.dto.BoardDTO;

@Service
public class BoardService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardDAO boardDAO;
	
	@Value("${spring.servlet.multipart.location}")
	private String root;

	public Map<String, Object> allList(int currPage, int pagePerCnt, String searchCategory, String searchWord) {
		Map<String, Object> map = new HashMap<String, Object>();
		int start = (currPage-1) * pagePerCnt;
		
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
		List<BoardDTO> attachFileList = boardDAO.attachFileList(post_no);
		
		mav.addObject("dto", dto);
		mav.addObject("attachFileList",attachFileList);
		
		return mav;
	}

	public ResponseEntity<Resource> download(String fileName) {
		String ori_fileName = boardDAO.getOriFileName(fileName);
		
		Resource resource = new FileSystemResource(root +"/"+fileName);
		HttpHeaders header = new HttpHeaders();
		
		try {
			header.add("content-type", "application/ortet-stream");
			String oriFile = URLEncoder.encode(ori_fileName,"UTF-8");
			header.add("content-Disposition", "attachment;filename=\""+oriFile+"\"");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}

	
	
	
	



	
}
