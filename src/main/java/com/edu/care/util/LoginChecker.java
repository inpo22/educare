package com.edu.care.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class LoginChecker implements HandlerInterceptor {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler)
			throws Exception {
		boolean pass = true;
		 logger.info("=== PRE HANDLER ===");
		
		HttpSession session = req.getSession();
		
		if (session.getAttribute("user_code") == null) {
			pass = false;
			resp.sendRedirect("/");
		}
		
		
		
		return pass;
	}
}
