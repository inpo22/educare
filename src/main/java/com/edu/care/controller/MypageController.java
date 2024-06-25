package com.edu.care.controller;

import java.util.Map;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.care.dto.MypageDTO;
import com.edu.care.dto.StuDTO;
import com.edu.care.service.MypageService;

@Controller
public class MypageController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MypageService mypageService;
	
	@GetMapping(value="/mypage.go")
	public String mypage(HttpSession session) {
		String path = "";
		
		String classify_code = (String) session.getAttribute("classify_code");
		
		if (classify_code.equals("U03")) {
			path = "redirect:/mypage/stdMypage.go";
		} else {
			path = "redirect:/mypage/empMypage.go";
		}
		
		return path;
	}
	
	@GetMapping(value="/mypage/empMypage.go")
	public ModelAndView empMypage(HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		
		return mypageService.empMypage(user_code);
	}
	
	@GetMapping(value="/mypage/stdMypage.go")
	public ModelAndView stdMypage() {
		return null;
	}
	
	@PostMapping(value="/mypage/empProfile/edit.do")
	public String empProfileEdit(@RequestParam(value="photo") MultipartFile photo
			, @RequestParam Map<String, String> param, HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		mypageService.empProfileEdit(photo, param, user_code);
		
		return "redirect:/mypage/empMypage.go";
	}
	
	@PostMapping(value="/mypage/empPw/edit.do")
	public String empPwEdit(@RequestParam Map<String, String> param, HttpSession session) {
		String page = "";
		String user_code = (String) session.getAttribute("user_code");
		
		int row = mypageService.empPwEdit(param, user_code);
		
		if (row > 0) {
			
		}
		
		return "redirect:/mypage/empMypage.go";
	}
	
	
	// 학생 마이페이지 이동
	@GetMapping(value="/mypageStd.go")
	public String mypageStd(Model model) {
		
		MypageDTO mypageDto = mypageService.mypageStd();
		model.addAttribute("mypageDto", mypageDto);
		
		return "mypage/mypageStd";
	}
	
	// 수강이력 뿌리기 (비동기)
	@ResponseBody
	@PostMapping(value="/mypage/std_detail_course.ajax")
	public Map<String, Object> courseListCall(String page, String Csearchbox){
		logger.info("수강이력 요청 - 학생 마이페이지");
		logger.info("page : "+page);
		logger.info("Csearchbox : "+Csearchbox);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		Map<String, Object> map = mypageService.StdcourseList(currPage, pagePerCnt,Csearchbox);
	
		return map;
	}
	
	// 취소버튼 클릭 시 결제상태 업데이트
	@GetMapping(value="/mypag/pay-cancel.do")
	public String cancel(RedirectAttributes rAttr, @RequestParam("course_name") String course_name) {
		logger.info("결제취소");
		String msg = "다시 확인해주세요.";
		
		int row = mypageService.cancel(course_name);
		logger.info("insert count :"+row);
		
		if(row == 1) {
			msg = "결제가 취소되었습니다.";
		}
		rAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/mypageStd.go";
	}
	
	// 결제내역 리스트 뿌리기(비동기)
	@ResponseBody
	@PostMapping(value="/mypage/std_detail_pay.ajax")
	public Map<String, Object> payListCall(String page, String Psearchbox){
		logger.info("결제내역요청-학생마이페이지");
		logger.info("page : " + page);
		logger.info("Psearchbox : " + Psearchbox);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		Map<String, Object> map = mypageService.StdpayList(currPage, pagePerCnt,Psearchbox);
		
		return map;
	}
	
	// 학생 개인정보 수정 페이지 이동
	@GetMapping(value="/mypageStd/update.go")
	public String stdEditP(@RequestParam("user_code") String user_code, Model model) {
		logger.info("edit user_code : "+user_code);
		
		MypageDTO mypageDto = mypageService.mypageStdU(user_code);
		model.addAttribute("mypageDto", mypageDto);
		
		return "mypage/mypageStd_update";
	}
	
	// 학생 개인정보 수정
	@PostMapping(value="/mypageStd/update.do")
	public String myStuUpdate(MultipartFile photo, Model model, @RequestParam Map<String, String> param, @RequestParam("user_code") String user_code) {
		String page = "mypageStd";
		String msg = "정보수정에 실패했습니다.";
		logger.info("param :"+param);
		
		int row = mypageService.update(photo, param, user_code);
		logger.info("insert count :"+row);
		
		if(row == 1) {
			page = "redirect:/mypageStd.go?user_code="+user_code;
			msg = "정보수정에 성공했습니다.";
		}
		model.addAttribute("msg", msg);
		
		return page;
	}
}
