package com.edu.care.controller;



import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
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
	@PostMapping(value = "/login.do")
	public ModelAndView loginAccess(HttpSession session, String id, String pw, boolean rememberMe,
			HttpServletResponse response) {
		logger.info("::최초 로그인 실행::");
		logger.info("id : {}/ pw : {}", id, pw);
		ModelAndView mav = loginService.loginAccess(session, id, pw);

		if (mav.getViewName().startsWith("redirect:")) {
			if (rememberMe) {
				Cookie cookie = new Cookie("saveId", id);
				cookie.setMaxAge(7 * 24 * 60 * 60); // 7일간 유효
				response.addCookie(cookie);
			} else {
				Cookie cookie = new Cookie("saveId", null);
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}

		}
		return mav;

	}

	// 로그아웃
	@GetMapping(value = "/logout.do")
	public String logoutAccess(HttpSession session, Model model, HttpServletResponse response) {
		logger.info("::로그아웃 실행::");
		session.removeAttribute("user_code");
		session.removeAttribute("user_name");
		session.removeAttribute("class_name");
		session.removeAttribute("team_name");
		session.removeAttribute("team_code");
		session.removeAttribute("classify_code");
		session.removeAttribute("classify_name");
		session.removeAttribute("photo");
		// model.addAttribute("msg", "로그아웃 되었습니다.");
		session.invalidate();

		return "login/login";
	}

	// ID찾기 페이지 이동
	@GetMapping(value = "login/idFind.go")
	public String idFind() {
		logger.info("::아이디 찾기 페이지::");
		return "login/idFind";
	}

	
	//ID찾기 확인 페이지 
	@PostMapping(value = "login/idFindResult.go")
	public ModelAndView idFindResult(String name, String email) {
		logger.info("::아이디 찾기 실행::");
		logger.info("user_name :{}", name);
		logger.info("user_email :{}", email);
		
		ModelAndView mav = new ModelAndView();
		String userId = loginService.idFindResult(name, email);
		logger.info("user_Idddd : {} ",userId);
		
		if (userId != null) {
			mav.addObject("userId", userId);
			mav.setViewName("login/idFindResult");
		
		}else {
			mav.addObject("msg", "등록된 회원정보를 찾을 수 없습니다.");
			mav.setViewName("login/idFind");
		}
		return mav;
		
	}
	
	@GetMapping(value="/login/pwFind.go")
	public String pwFindForm() {
		return "login/pwFind";
	}
	
	@PostMapping(value="/login/tempPw.do")
	public ModelAndView sendVerifyMail(String id, String email) {
		return loginService.sendVerifyMail(id, email);
	}
	
}