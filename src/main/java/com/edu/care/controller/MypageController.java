package com.edu.care.controller;

import java.util.Map;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.web.servlet.ModelAndView;

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
			path = "redirect:/mypageStd.go";
		} else {
			path = "redirect:/mypageEmp.go";
		}
		
		return path;
	}
	
	@GetMapping(value="/mypageEmp.go")
	public ModelAndView empMypage(HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		
		return mypageService.empMypage(user_code);
	}
	
	@PostMapping(value="/mypageEmp/profile/update.do")
	public String empProfileEdit(@RequestParam(value="photo") MultipartFile photo
			, @RequestParam Map<String, String> param, HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		mypageService.empProfileEdit(photo, param, user_code);
		
		return "redirect:/mypageEmp.go";
	}
	
	@PostMapping(value="/mypageEmp/pw/update.do")
	public String empPwEdit(@RequestParam Map<String, String> param, HttpSession session) {
		String user_code = (String) session.getAttribute("user_code");
		
		mypageService.empPwEdit(param, user_code);
		
		return "redirect:/mypageEmp.go";
	}
	
	
	// 학생 마이페이지 이동
	@GetMapping(value="/mypageStd.go")
	public String mypageStd() {
		return "mypage/mypageStd";
	}
	
	// 학생 개인정보 수정 페이지 이동
	@GetMapping(value="/mypageStd/update.go")
	public String stdEditP() {
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
