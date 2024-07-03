package com.edu.care.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
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

import com.edu.care.dao.StuDAO;
import com.edu.care.dto.CourseDTO;
import com.edu.care.dto.MypageDTO;
import com.edu.care.dto.PaymentDTO;
import com.edu.care.dto.StuDTO;

@Service
public class StuService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired StuDAO stuDAO;
	@Autowired PasswordEncoder encoder;
	
	@Value("${spring.servlet.multipart.location}")
	private String root;

	public Map<String, Object> stdList(int currPage, int pagePerCnt, String type, String searchbox, String startDate,
			String endDate) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<StuDTO> list = stuDAO.stdList(start, pagePerCnt, type, searchbox, startDate, endDate);
		logger.info("list :"+list);
		logger.info("list.size : "+list.size());
		
		result.put("list", list);
		result.put("totalPage", stuDAO.stdListPageCnt(pagePerCnt, type, searchbox, startDate, endDate));
		
		return result;
	}

	public Object overlay(String id) {
		return stuDAO.overlay(id);
	}

	public int reg(MultipartFile photo, Map<String, String> param) {
		
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
        // 회원 번호 생성
        String user_code = stuDAO.createUserCode(param);
        
        // 파일 이름을 param에 추가
        param.put("photo", newFileName);
        param.put("user_code", user_code);
        
        int row = stuDAO.reg(param);
		return row;
	}

	public int edit(Map<String, String> param, String user_code) {
		// 비밀번호 암호화
        String rawPassword = param.get("pw");
        
        if("00000000".equals(rawPassword)) {
        	String encodedPassword = encoder.encode(rawPassword);
            param.put("pw", encodedPassword);
        }
        		
		param.put("user_code", user_code);
		return stuDAO.edit(param);
	}

	public StuDTO stuDetail(String user_code) {
		return stuDAO.stuDetail(user_code);
	}

	public Map<String, Object> payList(int currPage, int pagePerCnt, String Psearchbox, String user_code) {
		int start = (currPage-1) * pagePerCnt;
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<PaymentDTO> list = stuDAO.payList(start, pagePerCnt, Psearchbox,user_code);
		
		logger.info("list : {}", list);
		logger.info("list size : " + list.size());
		result.put("list", list);
		result.put("totalPage", stuDAO.payListPageCnt(pagePerCnt, Psearchbox,user_code));
		
		return result;
	}

	public Map<String, Object> courseList(int currPage, int pagePerCnt, String Csearchbox, String user_code) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<PaymentDTO> cList = stuDAO.courseList(start, pagePerCnt, Csearchbox,user_code);
		logger.info("cList : {}", cList);
		logger.info("cList size : " + cList.size());
		
		// 현재 날짜 가져오기
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // 각 강의의 시작일을 확인하여 결제 상태를 업데이트
        for (PaymentDTO course : cList) {
            try {
                LocalDate startDate = LocalDate.parse(course.getCourse_start(), formatter); // 예외 발생 가능

                // 강의 시작일이 오늘보다 이전이면 결제 상태를 '결제취소'로 변경
                if (startDate.isBefore(today)) {
                    if (course.getPay_state() == 0) { // 이미 취소된 상태가 아니라면
                        course.setPay_state(2); // 결제취소 상태로 변경
                        stuDAO.updatePayState(course.getCourse_no()); // 데이터베이스 업데이트
                    }
                }
            } catch (DateTimeParseException e) {
                // course.getCourse_start()의 형식이 예상과 다를 경우 처리할 예외 로직
                // 예: 날짜 포맷이 일치하지 않는 경우 등
                e.printStackTrace();
            }
        }
		
		result.put("cList", cList);
		result.put("totalPage", stuDAO.courseListPageCnt(pagePerCnt, Csearchbox,user_code));
		
		return result;
	}


	public Map<String, Object> courseModalList() {
		Map<String, Object> result = new HashMap<String, Object>();
		List<CourseDTO> mList = stuDAO.courseModalList();
		result.put("mList", mList);
		return result;
	}

	public int courseReg(Map<String, String> param, String user_code) {
		param.put("user_code", user_code);
		
		// 강의 존재 확인
		int count = stuDAO.checkCourse(param);
		if(count > 0) {
			// 이미 존재하는 강의 일 경우 2 반환
			return 2;
		}
		return stuDAO.courseReg(param);
	}

	public Map<String, Object> attdList(int currPage, int pagePerCnt, String Asearchbox, String user_code) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<MypageDTO> aList = stuDAO.attdList(start, pagePerCnt, Asearchbox,user_code);
		logger.info("aList : {}", aList);
		logger.info("aList size : " + aList.size());
		
		result.put("aList", aList);
		result.put("totalPage", stuDAO.attdListPageCnt(pagePerCnt, Asearchbox,user_code));
		return result;
	}

	public int attd(String course_name, String user_code, String att_date) {
		return stuDAO.attd(course_name, user_code,att_date);
	}

	public int absent(String course_name, String user_code, String att_date) {
		return stuDAO.absent(course_name, user_code, att_date);
	}

	public String attRate(String user_code) {
		return stuDAO.attRate(user_code);
	}

	public int stdCnt() {
		return stuDAO.stdCnt();
	}
	
}
