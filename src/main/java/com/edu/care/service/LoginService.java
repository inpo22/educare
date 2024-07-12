package com.edu.care.service;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.edu.care.dao.LoginDAO;
import com.edu.care.dto.LoginDTO;

@Service
public class LoginService {

	@Autowired
	LoginDAO loginDAO;
	@Autowired
	PasswordEncoder encoder;
	
	@Value("${spring.mail.username}")
	private String mailId;
	@Value("${spring.mail.password}")
	private String password;
	@Value("${spring.mail.host}")
	private String host;
	@Value("${spring.mail.port}")
	private String port;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	public ModelAndView loginAccess(HttpSession session, String id, String pw) {

		LoginDTO loginInfo = loginDAO.loginAccess(id);
		//logger.info("loginInfo = {}", loginInfo);
		
		boolean success = false;
		String page = "login/login";
		String msg = "아이디 또는 비밀번호를 확인하세요";
		
		if (loginInfo !=null && loginInfo.getStatus() ==1) {
			msg = "로그인 할 수 없습니다.";
			ModelAndView mav = new ModelAndView();
			mav.addObject("msg", msg);
			mav.setViewName(page);
			return mav;
		}
		
		
		
		
		//String enc_pw = (loginInfo != null) ? loginInfo.getPw() : null
		String enc_pw;
		if (loginInfo != null) {
			 enc_pw = loginInfo.getPw();
		}else {
			 enc_pw = null;
		}
		//logger.info("enc_pw = {}", enc_pw);
		
		
		if (enc_pw != null) {
			success = encoder.matches(pw, enc_pw);
			
		}
		
		ModelAndView mav = new ModelAndView();
		if (success) {
			session.setAttribute("user_code", loginInfo.getUser_code());
			session.setAttribute("user_name", loginInfo.getName());
			session.setAttribute("class_name", loginInfo.getClass_name());
			session.setAttribute("classify_name", loginInfo.getClassify_name());
			session.setAttribute("classify_code", loginInfo.getClassify_code());
			session.setAttribute("team_name", loginInfo.getTeam_name());
			session.setAttribute("team_code", loginInfo.getTeam_code());
			session.setAttribute("photo", loginInfo.getPhoto());
			//logger.info("user_code :{} ", loginInfo.getUser_code());
			//logger.info("user_name :{} ", loginInfo.getName());
			//logger.info("class_name :{} ", loginInfo.getClass_name());
			//logger.info("classify_name :{} ", loginInfo.getClassify_name());
			//logger.info("classify_code :{} ", loginInfo.getClassify_code());
			//logger.info("team_name :{} ", loginInfo.getTeam_name());
			//logger.info("team_code:{}", loginInfo.getTeam_code());
			//logger.info("photo :{} ", loginInfo.getPhoto());
			
			String team_code = (String) session.getAttribute("team_code");
			String classify_code = (String) session.getAttribute("classify_code");
			
			if (team_code != null) {
				if (team_code.equals("T001") || team_code.equals("T006")) {
					page = "redirect:/main/superAdminMain.go";
				} else {
					page = "redirect:/main/adminMain.go";
				}
			}
			if (classify_code.equals("U03") ) {
				page = "redirect:/main/stdMain.go";
			}
			
		}else {
			mav.addObject("msg", msg);
		}
		mav.setViewName(page);
		return mav;	
	}
	
	public String idFindResult(String name, String email) {
		return (String) loginDAO.idFindResult(name,email);
	}
	
	@Transactional
	public ModelAndView sendVerifyMail(String id, String email) {
		ModelAndView mav = new ModelAndView();
		
		int cnt = loginDAO.pwFindCheck(id, email);
		
		if (cnt == 1) {
			mav.setViewName("login/login");
			
			String subject = "[EDUcare] 임시비밀번호 안내";
			String content = "";
			String tempPassword = getTempPassword();
			String enc_tempPassword = encoder.encode(tempPassword);
			
			loginDAO.updateTempPassword(id, enc_tempPassword);
			
			StringBuilder builder = new StringBuilder();
			builder.append("<h3>EDUcare 임시비밀번호</h3>");
			builder.append("<p></p>");
			builder.append("<p></p>");
			builder.append("<p>임시비밀번호는 아래와 같습니다.</p>");
			builder.append("<p></p>");
			builder.append("<div style=\"display: table-cell; text-align: center; vertical-align: middle; width: 300px; height: 100px; "
					+ "background-color: lightgray; font-weight: bold;\">");
			builder.append(tempPassword);
			builder.append("</div>");
			
			content = builder.toString();
			
			// 메일 서버 정보 입력
			Properties props = new Properties();
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", port);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.ssl.protocols", "TLSv1.2");
			props.put("mail.debug", "true");
			
			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(mailId, password);
				}
			});
			
			try {
				MimeMessage message = new MimeMessage(session);
				message.setFrom(new InternetAddress(mailId, "에듀케어", "UTF-8"));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
				
				message.setSubject(subject);
				
				// 메일 본문 설정
				MimeBodyPart textPart = new MimeBodyPart();
				textPart.setText(content, "UTF-8", "html");
				
				// 멀티파트 설정
				MimeMultipart multipart = new MimeMultipart();
				multipart.addBodyPart(textPart);
				
				message.setContent(multipart);
				
				Transport.send(message);
				logger.info("메일 전송 완료");
				
			} catch (AddressException e) {
				e.printStackTrace();
			} catch (MessagingException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
		} else {
			mav.setViewName("login/pwFind");
			mav.addObject("msg", "입력한 정보가 없거나 정보 입력이 잘못되었습니다.");
		}
		
		return mav;
	}
	private String getTempPassword() {
		char[] charSet = new char[] {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 
				'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
		
		String tempPassword = "";
		
		int idx = 0;
		for (int i = 0; i < 10; i++) {
			idx = (int) (charSet.length * Math.random());
			tempPassword += charSet[idx];
		}
		
		return tempPassword;
	}

}
