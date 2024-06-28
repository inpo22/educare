package com.edu.care.controller;

import java.util.HashMap;
import java.util.Map;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.care.dto.StuDTO;
import com.edu.care.service.StuService;

@Controller
public class StuController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired StuService stuService;
	
	@GetMapping(value="/std/list.go")
	public String stuList() {
		return "std/std_list";
	}
	
	// 학생 리스트 불러오기(비동기)
	@ResponseBody
	@PostMapping(value="/std/list.ajax")
	public Map<String, Object> stdListCall(String page, String type, String searchbox, String startDate, String endDate){
		logger.info("page: "+page);
		logger.info("type: "+type);
		logger.info("searchbox: "+searchbox);
		logger.info("startDate: "+startDate);
		logger.info("endDate: "+endDate);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		Map<String, Object> map = stuService.stdList(currPage, pagePerCnt, type, searchbox, startDate, endDate);
		
		return map;
	}
	
	// 학생 등록 페이지 이동
	@GetMapping(value="/std/reg.go")
	public String regForm() {
		return "std/std_reg";
	}
	
	// 중복체크
	@ResponseBody
	@PostMapping(value="/std/overlay.ajax")
	public Map<String, Object> overlay(String id){
		logger.info("id : "+id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("use", stuService.overlay(id));
		
		return map;
	}
	
	// 학생 등록
	@PostMapping(value="/std/reg.do")
	public String reg(MultipartFile photo ,Model model, @RequestParam Map<String, String> param) {
		String page = "emp_reg";
		String msg = "사원 등록에 실패했습니다.";
		logger.info("param:"+param);
		
        int row = stuService.reg(photo, param);
		logger.info("insert count:"+row);
		
		if(row==1) {
			page="redirect:/std/list.go";
			msg="사원 등록에 성공했습니다.";
		}
		model.addAttribute("msg", msg);
		return page;
	}
	
	// 학생 상세보기 페이지 이동
	@GetMapping(value="/std/detail.go")
	public String stdDetail(@RequestParam("user_code") String user_code, Model model) {
		logger.info("detail user_code : "+user_code);
		
		StuDTO stdDto = stuService.stuDetail(user_code);
		model.addAttribute("stdDto", stdDto);
		
		return "std/std_detail_course";
	}
	
	// 강의 선택 모달 리스트 (비동기)
	@ResponseBody
	@PostMapping(value="/std/course_modal.ajax")
	public Map<String, Object> CouseModalList(){
		logger.info("강의 선택 모달 리스트");
		
		Map<String, Object> map = stuService.courseModalList();
		return map;
	}
	
	// 강의 등록(모달)	
	@PostMapping(value="/std/course_reg.do")
	public String courseReg(@RequestParam Map<String, String> param, RedirectAttributes reAttr, @RequestParam("user_code") String user_code) {
		String msg = "강의등록 실패";
		logger.info("param:"+param);
		
		int row = stuService.courseReg(param, user_code);
		logger.info("insert count : "+row);
		
		if(row == 1) {
			msg = "강의등록 성공";	
		}
		reAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/std/detail.go?user_code="+user_code;
	}
	
	// 수강이력 리스트(비동기)
	@ResponseBody
	@PostMapping(value="/std/detail_course.ajax")
	public Map<String, Object> courseListCall(@RequestParam("user_code") String user_code, String page, String Csearchbox){
		logger.info("수강이력 요청");
		logger.info("page : " + page);
		logger.info("Csearchbox : " + Csearchbox);
		logger.info("user_code : " + user_code);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		Map<String, Object> map = stuService.courseList(currPage, pagePerCnt,Csearchbox,user_code);
		
		return map;
	}
	
	// 출석현황 리스트(비동기)
	@ResponseBody
	@PostMapping(value="/std/detail/attd.ajax")
	public Map<String, Object> attdListCall(@RequestParam("user_code") String user_code, String page, String Asearchbox){
		logger.info("출석현황 요청");
		logger.info("page : " + page);
		logger.info("Asearchbox : " + Asearchbox);
		logger.info("user_code : " + user_code);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		Map<String, Object> map = stuService.attdList(currPage, pagePerCnt,Asearchbox,user_code);
		
		return map;
	}
	
	// 결제내역 리스트(비동기)
	@ResponseBody
	@PostMapping(value="/std/detail_pay.ajax")
	public Map<String, Object> payListCall(@RequestParam("user_code") String user_code, String page, String Psearchbox){
		logger.info("결제내역 요청");
		logger.info("page : " + page);
		logger.info("Psearchbox : " + Psearchbox);
		logger.info("user_code : " + user_code);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		
		Map<String, Object> map = stuService.payList(currPage, pagePerCnt,Psearchbox,user_code);
		
		return map;
	}
	
	
	// 학생 정보 수정 페이지 이동
	@GetMapping(value="/std/edit.go")
	public String stdEdit(@RequestParam("user_code") String user_code, Model model) {
		logger.info("edit user_code : "+user_code);
		
		StuDTO stdDto = stuService.stuDetail(user_code);
		model.addAttribute("stdDto", stdDto);
		
		return "std/std_edit";
	}
	
	// 학생 정보 수정
	@PostMapping(value="/std/edit.do")
	public String stdEditDo(Model model, @RequestParam Map<String, String> param, @RequestParam("user_code") String user_code) {
		String page = "std_edit";
		String msg = "정보수정에 실패했습니다.";
		logger.info("param : "+param);
		
		int row = stuService.edit(param, user_code);
		logger.info("insert count : "+row);
		
		if(row == 1) {
			page="redirect:/std/detail.go?user_code="+user_code;
			msg = "정보수정에 성공했습니다.";
		}
		model.addAttribute("msg", msg);
		return page;
	}
	
	// 출석 처리
	@GetMapping(value="/std/attd.do")
	public String attd(RedirectAttributes rAttr ,@RequestParam("course_name") String course_name, @RequestParam("user_code") String user_code, @RequestParam("att_date") String att_date) {
		logger.info("출석");
		logger.info("course_name: " + course_name);
	    logger.info("user_code: " + user_code);
	    logger.info("att_date: " + att_date);
	    
		String msg = "다시 시도해주세요.";
		
		int row = stuService.attd(course_name, user_code,att_date);
		logger.info("insert count:"+row);
		
		if(row == 1) {
			msg = "출석완료";
		}
		rAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/std/detail.go?user_code="+user_code;
	}
	
	// 결석 처리
	@GetMapping(value="/std/absent.do")
	public String absent(RedirectAttributes rAttr ,@RequestParam("course_name") String course_name, @RequestParam("user_code") String user_code, @RequestParam("att_date") String att_date) {
		logger.info("결석");
		logger.info("course_name: " + course_name);
	    logger.info("user_code: " + user_code);
	    logger.info("att_date: " + att_date);
	    
		String msg = "다시 시도해주세요.";
		
		int row = stuService.absent(course_name, user_code, att_date);
		logger.info("insert count:"+row);
		
		if(row == 1) {
			msg = "결석처리 완료";
		}
		rAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/std/detail.go?user_code="+user_code;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
