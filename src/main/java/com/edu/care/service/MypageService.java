package com.edu.care.service;

import java.io.IOException;
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
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.dao.MypageDAO;
import com.edu.care.dto.MypageDTO;
import com.edu.care.dto.PaymentDTO;

@Service
public class MypageService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MypageDAO mypageDAO;
	@Autowired PasswordEncoder encoder;
	
	@Value("${spring.servlet.multipart.location}")
	private String root;

	public int update(MultipartFile photo, Map<String, String> param, String user_code) {
		
		// 비밀번호 암호화
        String rawPassword = param.get("pw");
        String encodedPassword = encoder.encode(rawPassword);
        param.put("pw", encodedPassword);
		
		// 파일 처리 로직
        String newFileName = null;
        
        if (!photo.isEmpty()) {
            String fileName = photo.getOriginalFilename();
            String ext = "";
            
            // 파일 이름이 있는 경우에만 확장자 추출
            if (fileName != null && !fileName.isEmpty()) {
                int lastIndex = fileName.lastIndexOf(".");
                
                if (lastIndex != -1) {
                    ext = fileName.substring(lastIndex);
                }
            }
            
            newFileName = System.currentTimeMillis() + ext;
            
            try {
                byte[] bytes = photo.getBytes();
                Path path = Paths.get(root + "/" + newFileName);
                Files.write(path, bytes);
            } catch (IOException e) {
                e.printStackTrace();
                // 파일 저장 실패 시 처리 로직 추가
            }
        }
        
        // 파일 이름을 param에 추가
        param.put("photo", newFileName);
        // user_code param 에 추가
        param.put("user_code", user_code);
        
		return mypageDAO.update(param);
	}
	

	public ModelAndView empMypage(String user_code) {
		ModelAndView mav = new ModelAndView("mypage/empMypage");
		
		MypageDTO dto = mypageDAO.empMypage(user_code);
		
		mav.addObject("dto", dto);
		
		return mav;
	}

	@Transactional
	public void empProfileEdit(MultipartFile photo, Map<String, String> param, String user_code) {
		MypageDTO dto = new MypageDTO();
		
		dto.setUser_code(user_code);
		dto.setEmail(param.get("email"));
		dto.setPhoto(param.get("phone"));
		
		mypageDAO.empProfileEdit(dto);
		
		fileSave(photo, user_code);
		
	}
	
	private void fileSave(MultipartFile photo, String user_code) {
		String ori_filename = photo.getOriginalFilename();
		
		if (!ori_filename.equals("")) {
			
			String ext = ori_filename.substring(ori_filename.lastIndexOf("."));
			
			String new_filename = System.currentTimeMillis() + ext;
			
			try {
				byte[] bytes = photo.getBytes();
				Path path = Paths.get(root + new_filename);
				Files.write(path, bytes);
				
				mypageDAO.profileImgSave(user_code, new_filename);
				
				Thread.sleep(1);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public int empPwEdit(Map<String, String> param, String user_code) {
		
		return 0;
	}


	public MypageDTO mypageStd() {
		return mypageDAO.mypageStd();
	}


	public MypageDTO mypageStdU(String user_code) {
		return mypageDAO.mypageStdU(user_code);
	}


	public Map<String, Object> StdpayList(int currPage, int pagePerCnt, String Psearchbox) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<PaymentDTO> list = mypageDAO.StdpayList(start, pagePerCnt, Psearchbox);
		logger.info("list : {}", list);
		logger.info("list size : " + list.size());
		
		result.put("list", list);
		result.put("totalPage", mypageDAO.StdpatListPageCnt(pagePerCnt, Psearchbox));
		
		return result;
	}


	public Map<String, Object> StdcourseList(int currPage, int pagePerCnt, String Csearchbox) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<PaymentDTO> cList = mypageDAO.StdcourseList(start, pagePerCnt, Csearchbox);
		logger.info("cList : {}", cList);
		logger.info("cList size : " + cList.size());
		
		result.put("cList", cList);
		result.put("totalPage", mypageDAO.StdcourseListPageCnt(pagePerCnt, Csearchbox));
		return result;
	}


	public int cancel(String course_name) {
		return mypageDAO.cancel(course_name);
	}
	
}
