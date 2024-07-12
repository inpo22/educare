package com.edu.care.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.edu.care.util.LoginChecker;


// 이 어노테이션이 있어야 설정 클래스로 인식된다.
@Configuration
public class InterCeptorConfig implements WebMvcConfigurer {
	
	// 인터셉터에 등록할 클래스를 가져온다.
	@Autowired LoginChecker checker;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		// 1. 인터셉터에 등록할 로직 추가
		// 2. 인터셉터가 가로챌 url 패턴 등록
		// 3. 인터셉터가 예외로 둘 url 패턴 등록
		
		List<String> excludeList = new ArrayList<String>();
		excludeList.add("/");
		excludeList.add("/resources/**"); // resources 하위 요청
		excludeList.add("/login.go");
		excludeList.add("/login.do");
		excludeList.add("/logout.do");
		excludeList.add("/login/**");
		excludeList.add("/error");
		
		
		registry.addInterceptor(checker)
					.addPathPatterns("/**")
					.excludePathPatterns(excludeList);
		
	}
	
}
