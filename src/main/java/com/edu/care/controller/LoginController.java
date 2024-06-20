package com.edu.care.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.care.dto.LoginDTO;
import com.edu.care.service.LoginService;

@Controller
public class LoginController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	LoginService loginService;

	@GetMapping(value = "/login.go")
	public String login() {
		logger.info("::최초 로그인 페이지::");
		return "login/login";
	}
	
	// 로그인
	@PostMapping(value="/login.do")
	public ModelAndView loginAccess(String id, String pw, HttpSession session) {
		logger.info("::최초 로그인 실행::");
		logger.info("id : {}/ pw : {}", id, pw);
		return loginService.loginAccess(id, pw,session);
	}
	
	/*
	 * @PostMapping(value = "/login.do") public String loginAccess(HttpSession
	 * session, Model model, String id, String pw) { String page = "login/login";
	 * logger.info("::최초 로그인 실행::"); logger.info("id : {} / pw : {}", id, pw);
	 * 
	 * LoginDTO loginInfo = loginService.loginAccess(id, pw); logger.info("login :"
	 * + loginInfo);
	 * 
	 * if (loginInfo != null) { page = "main/main";
	 * 
	 * session.setAttribute("user_code", loginInfo.getUser_code());
	 * session.setAttribute("name", loginInfo.getName());
	 * session.setAttribute("class_code", loginInfo.getClass_code());
	 * session.setAttribute("team_code", loginInfo.getTeam_code());
	 * session.setAttribute("classify_code", loginInfo.getClassify_code());
	 * session.setAttribute("team_name", loginInfo.getTeam_name()); String Filename
	 * = loginInfo.getPhoto(); session.setAttribute("photo", Filename);
	 * 
	 * //session.setAttribute("photo", loginInfo.getPhoto());
	 * logger.info("status:{}", loginInfo.getUser_code()); logger.info("status:{}",
	 * loginInfo.getName()); logger.info("status:{}", loginInfo.getClass_code());
	 * logger.info("status:{}", loginInfo.getTeam_code()); logger.info("status:{}",
	 * loginInfo.getClassify_code()); logger.info("status:{}",
	 * loginInfo.getTeam_name()); logger.info("photo:{}", Filename);
	 * 
	 * } else { model.addAttribute("msgdo", "아이디 또는 비밀번호를 확인해주세요"); } return page; }
	 */

	// 로그아웃
	@GetMapping(value = "/logout.do")
	public String logoutAccess(HttpSession session, Model model) {
		logger.info("::로그아웃 실행::");
		session.removeAttribute("user_code");
		session.removeAttribute("user_name");
		session.removeAttribute("class_name");
		session.removeAttribute("team_name");
		session.removeAttribute("team_code");
		session.removeAttribute("classify_code");
		model.addAttribute("msg", "로그아웃 되었습니다.");
		session.invalidate();
		return "login/login";
	}

	/*
	 * //아이디 저장하기
	 * 
	 * @GetMapping(value = "/login.go") public String loginAccess(HttpServletRequest
	 * request) {
	 * 
	 * String username = "";
	 * 
	 * Cookie[] cookies = request.getCookies(); for (Cookie cookie : cookies) { if
	 * (cookie.getName().equals("remember")) { username = cookie.getValue(); } }
	 * request.setAttribute("remember", username); return "login/login";
	 */
}
