package com.edu.care.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Base64;
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
        
        if(rawPassword != null && !rawPassword.isEmpty()) {
        	String encodedPassword = encoder.encode(rawPassword);
            param.put("pw", encodedPassword);
        }else {
        	//비밀번호 입력되지않으면 기존 비밀번호 유지
        	param.remove("pw");
        }
        
		
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
	public void empProfileEdit(MultipartFile photo, MultipartFile sign_photo, Map<String, String> param, String user_code) {
		MypageDTO dto = new MypageDTO();
		
		dto.setUser_code(user_code);
		dto.setEmail(param.get("email"));
		dto.setPhone(param.get("phone"));;
		
		mypageDAO.empProfileEdit(dto);
		
		int type = 0;
		fileSave(photo, user_code, type);
		
		type = 1;
		String sign_data = param.get("sign_canvas_photo");
		// logger.info("sign : " + sign_data);
		if (sign_data.equals("")) {
			
			fileSave(sign_photo, user_code, type);
		} else {
			signSave(sign_data, user_code, type);
		}
		
		
	}
	
	private void signSave(String sign_data, String user_code, int type) {
		String base64Image = sign_data.split(",")[1];
		byte[] bytes = Base64.getDecoder().decode(base64Image);

		try {
			String new_filename = System.currentTimeMillis() + ".png";
			
			Path path = Paths.get(root + new_filename);
			Files.write(path, bytes);
			
			mypageDAO.profileImgSave(user_code, new_filename, type);
			
			Thread.sleep(1);
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}


	private void fileSave(MultipartFile photo, String user_code, int type) {
		String ori_filename = photo.getOriginalFilename();
		
		if (!ori_filename.equals("")) {
			
			String ext = ori_filename.substring(ori_filename.lastIndexOf("."));
			
			String new_filename = System.currentTimeMillis() + ext;
			
			try {
				byte[] bytes = photo.getBytes();
				Path path = Paths.get(root + new_filename);
				Files.write(path, bytes);
				
				mypageDAO.profileImgSave(user_code, new_filename, type);
				
				Thread.sleep(1);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			mypageDAO.profileImgSave(user_code, null, type);
		}
	}
	
	public boolean empPwEdit(Map<String, String> param, String user_code) {
		String currentPassword = param.get("currentPassword");
		String newPassword = param.get("newPassword");
		String enc_pw = mypageDAO.pwCheck(user_code);
		boolean success = false;
		
		if (enc_pw != null) {
			success = encoder.matches(currentPassword, enc_pw);
		}
		
		if (success) {
			String new_enc_pw = encoder.encode(newPassword);
			mypageDAO.pwUpdate(new_enc_pw, user_code);
		}
		return success;
	}


	public MypageDTO mypageStd(String user_code) {
		return mypageDAO.mypageStd(user_code);
	}


	public MypageDTO mypageStdU(String user_code) {
		return mypageDAO.mypageStdU(user_code);
	}


	public Map<String, Object> StdpayList(int currPage, int pagePerCnt, String Psearchbox, String user_code) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<PaymentDTO> list = mypageDAO.StdpayList(start, pagePerCnt, Psearchbox, user_code);
		//logger.info("list : {}", list);
		//logger.info("list size : " + list.size());
		
		result.put("list", list);
		result.put("totalPage", mypageDAO.StdpatListPageCnt(pagePerCnt, Psearchbox, user_code));
		
		return result;
	}


	public Map<String, Object> StdcourseList(int currPage, int pagePerCnt, String Csearchbox, String user_code) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<PaymentDTO> cList = mypageDAO.StdcourseList(start, pagePerCnt, Csearchbox, user_code);
	
		//logger.info("cList : {}", cList);
		//logger.info("cList size : " + cList.size());
		
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
                        mypageDAO.updatePayState(course.getCourse_no()); // 데이터베이스 업데이트
                    }
                }
            } catch (DateTimeParseException e) {
                // course.getCourse_start()의 형식이 예상과 다를 경우 처리할 예외 로직
                // 예: 날짜 포맷이 일치하지 않는 경우 등
                e.printStackTrace();
            }
        }
		
		result.put("cList", cList);
		result.put("totalPage", mypageDAO.StdcourseListPageCnt(pagePerCnt, Csearchbox, user_code));
		return result;
	}


	public int cancel(String course_name, String user_code) {
		return mypageDAO.cancel(course_name, user_code);
	}


	public Map<String, Object> StdattdList(int currPage, int pagePerCnt, String Asearchbox, String user_code) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<MypageDTO> aList = mypageDAO.stdattdList(start, pagePerCnt, Asearchbox, user_code);
		//logger.info("aList : {}", aList);
		//logger.info("aList size : " + aList.size());
		
		result.put("aList", aList);
		result.put("totalPage", mypageDAO.stdattdListPageCnt(pagePerCnt, Asearchbox, user_code));
		return result;
	}


	public String attRate(String user_code) {
		return mypageDAO.attRate(user_code);
	}


	public String getPw(String user_code) {
		return mypageDAO.getPw(user_code);
	}

	
}
