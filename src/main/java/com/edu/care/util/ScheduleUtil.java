package com.edu.care.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.edu.care.dao.CommuteDAO;
import com.edu.care.dto.CommuteDTO;

@EnableScheduling
@Component
public class ScheduleUtil {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired CommuteDAO commuteDAO;
	
	// crontab
	// 초 분 시 일 월 요일 년도(일반적으로 생략)
	// 1 0 0 * * MON-FRI
	@Scheduled(cron = "0 19 17 * * MON-FRI")
	public void cron() throws IOException {
		LocalDate now = LocalDate.now(ZoneId.of("Asia/Seoul"));
		
		String year = "" + now.getYear();
		String month = "" + now.getMonthValue();
		int day = now.getDayOfMonth();
		
		// logger.info("year : " + year);
		// logger.info("month : " + month);
		
		// UmhF950FSvXPa7p0fpc8kZ3e5Tv8DxDU1Gb7xvlC4VJZyRvOxCJVU%2BVoYTAoNdNe%2FqlyOsdt%2B8NBz%2BY8xlT4eg%3D%3D
		
		String key = "UmhF950FSvXPa7p0fpc8kZ3e5Tv8DxDU1Gb7xvlC4VJZyRvOxCJVU%2BVoYTAoNdNe%2FqlyOsdt%2B8NBz%2BY8xlT4eg%3D%3D";
		
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo"); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + key); /*Service Key*/
		urlBuilder.append("&" + URLEncoder.encode("solYear", "UTF-8") + "=" + URLEncoder.encode(year, "UTF-8")); /*연*/
		urlBuilder.append("&" + URLEncoder.encode("solMonth", "UTF-8") + "=" + URLEncoder.encode(month, "UTF-8")); /*월*/
		
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		logger.info("rest : " + sb.toString());
		
		String result = sb.toString();
		List<Integer> restDayList = new ArrayList<Integer>();
		
		if (result.contains("<locdate>")) {
			String[] dateArr = result.split("<locdate>");
			for (int i = 1; i < dateArr.length; i++) {
				String date = dateArr[i].substring(0, 8);
				// logger.info("date : " + date);
				int restDay = Integer.parseInt(date.substring(6, 8));
				// logger.info("restDay : " +restDay);
				restDayList.add(restDay);
			}
		}
		
		if (!restDayList.contains(day)) {
			List<String> empList = commuteDAO.empList();
			
			for (String user_code : empList) {
				CommuteDTO todayCommute = commuteDAO.todayCommute(user_code);
				if (todayCommute == null) {
					commuteDAO.autoCommute(user_code);
					int type = commuteDAO.stateCheck(user_code);
					commuteDAO.stateUpdate(user_code, type);
				} else if (todayCommute != null && todayCommute.getEnd_time() == null) {
					commuteDAO.autoLeaveWork(user_code);
					int type = commuteDAO.stateCheck(user_code);
					commuteDAO.stateUpdate(user_code, type);
				}
			}
		}
	}
	
}
