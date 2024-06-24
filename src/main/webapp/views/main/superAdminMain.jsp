<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Dashboard - NiceAdmin Bootstrap Template</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- js -->

<style>
	.display-flex {
		display: flex;
	}
	#left-section {
		width: 59%;
		height: 100%;
	}
	#right-section {
		width: 40%;
		height: 100%;
		padding-left: 50px;
	}
	.section-title {
		font-size: 20px;
		font-weight: 600;
		color: #012970;
		padding-left: 10px;
	}
	.white-section {
		background-color: white;
		height: auto;
		border-radius: 5px;
		box-shadow: 4px 4px 2px -2px rgba(0, 0, 0, 0.2);
	}
	.small-white-section {
		background-color: white;
		height: auto;
		width: 23%;
		display: inline-block;
		border-radius: 5px;
		box-shadow: 4px 4px 2px -2px rgba(0, 0, 0, 0.2);
		padding: 20px;
		text-align: center;
	}
	.small-white-section span {
		font-size: 1.25rem;
	}
	.margin-right {
		margin-right: 20px;
	}
	#chart {
		padding-top: 10px;
	}
	.first-col {
		width: 54%
	}
	.second-col {
		width: 25%
	}
	.third-col {
		width: 20%
	}
	.table th, .table td {
		text-align: center;
	}
	a {
		color: black;
	}
	.blue-color {
		color: rgb(88, 88, 255);
	}
	.schedule-ul {
		padding-top: 1px;
	}
	.schedule-ul li {
		list-style-type: none;
		margin: 20px 0;
	}
	.more-div {
		padding-left: 30px;
		padding-bottom: 10px;
	}
	.black-color {
		color: black;
	}
	.red-color {
		color: red;
	}
	.purple-color {
		color: #e06efc
	}
	.green-color {
		color: #6efcb3
	}
	.font-weight {
		font-weight: 900
	}
	.weather-div {
		padding: 30px;
	}
	#weather-content {
		font-size: 40px;
		font-weight: 600;
		color: #012970;
	}
	.top-weather-icon {
		color: #012970;
		font-size: 120px;
	}
	.bottom-weather-icon {
		color: #012970;
		font-size: 80px;
	} 
	.top-weather th {
		width: 30%;
	}
	.bottom-weather th {
		width: 15%;
	}
	.top-weather td {
		font-weight: 600;
		text-align: left;
		vertical-align: middle;
	}
	.bottom-weather td {
		font-weight: 600;
		text-align: left;
		width: 34%;
		vertical-align: middle;
	}
	.top-temp {
		font-weight: 600;
		font-size: 50px;
	}
	.bottom-temp {
		font-size: 25px;
	}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div class="display-flex">
			<div id="left-section">
				<div class="section-title">당월 인사 통계</div>
				<div>
					<div class="small-white-section margin-right">
						<h5 class="font-weight">입사자</h5>
						<br/>
						<span><i class="bi bi-person-plus-fill"></i>&nbsp;&nbsp;${hrd.new_emp} 명</span>
					</div>
					<div class="small-white-section margin-right">
						<h5 class="font-weight">퇴사자</h5>
						<br/>
						<span><i class="bi bi-person-dash-fill"></i>&nbsp;&nbsp;${hrd.quit_emp} 명</span>
					</div>
					<div class="small-white-section margin-right">
						<h5 class="font-weight">지각 / 결근</h5>
						<br/>
						<span>${hrd.late_emp} 명 / ${hrd.absent_emp} 명</span>
					</div>
					<div class="small-white-section">
						<h5 class="font-weight">신규 학생</h5>
						<br/>
						<span><i class="bi bi-person-plus"></i>&nbsp;&nbsp;${hrd.new_stu} 명</span>
					</div>
				</div>
				<br/><br/>
				<div class="section-title">매출 통계</div>
				<div>
					<div class="white-section" id="chart"></div>
				</div>
				<br/><br/>
				<div class="section-title">결재 대기 문서</div>
				<div>
					<div class="white-section">
						<table class="table">
							<thead>
								<tr>
									<th class="first-col table-active">제목</th>
									<th class="second-col table-active">기안자</th>
									<th class="third-col table-active">기안일자</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${approvalList.size() < 1}">
									<tr>
										<td colspan="3">결재 대기 문서가 없습니다.</td>
									</tr>
								</c:if>
								<c:forEach items="${approvalList}" var="approval">
									<tr>
										<td><a href="/approval/detail.go?au_code=${approval.au_code}">${approval.title}</a></td>
										<td>${approval.user_name}&nbsp;${approval.class_name}</td>
										<td><fmt:formatDate value="${approval.reg_date}" pattern="yyyy.MM.dd"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<c:if test="${approvalList.size() > 0}">
							<div class="more-div">
								<a class="blue-color" href="/getApproval/list.go">더보기</a>
							</div>
						</c:if>
					</div>
				</div>
				<br/><br/>
				<div class="section-title">최근 메일</div>
				<div>
					<div class="white-section">
						<table class="table">
							<thead>
								<tr>
									<th class="first-col table-active">제목</th>
									<th class="second-col table-active">작성자</th>
									<th class="third-col table-active">작성일자</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${mailList.size() < 1}">
									<tr>
										<td colspan="3">받은 메일이 없습니다.</td>
									</tr>
								</c:if>
								<c:forEach items="${mailList}" var="mail">
									<tr>
										<td><a href="/mail/detail.go?mail_no=${mail.mail_no}">${mail.subject}</a></td>
										<td>${mail.user_name}&nbsp;${mail.class_name}</td>
										<td><fmt:formatDate value="${mail.send_date}" pattern="yyyy.MM.dd"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<c:if test="${mailList.size() > 0}">
							<div class="more-div">
								<a class="blue-color" href="/receivedMail/list.go">더보기</a>
							</div>
						</c:if>
						
					</div>
				</div>
			</div>
			<div id="right-section">
				<div class="section-title">날씨</div>
				<div>
					<div class="white-section weather-div">
					</div>
				</div>
				<br/><br/>
				<div class="section-title">다가오는 일정</div>
				<div>
					<div class="white-section">
						<ul class="schedule-ul">
							<c:if test="${scheduleList.size() < 1}">
								<li>등록된 일정이 없습니다.</li>
							</c:if>
							<c:forEach items="${scheduleList}" var="schedule">
								<li>
									<c:if test="${schedule.sked_type.equals('SKED_TP01')}">
										<span class="purple-color font-weight">&bull;</span>
									</c:if>
									<c:if test="${schedule.sked_type.equals('SKED_TP02')}">
										<span class="green-color font-weight">&bull;</span>
									</c:if>
									<c:if test="${schedule.sked_type.equals('SKED_TP03')}">
										<span class="blue-color font-weight">&bull;</span>
									</c:if>
									<c:if test="${schedule.check_period eq 0}">
										<span>
											<fmt:formatDate value="${schedule.start_date}" pattern="MM.dd"/>
											&nbsp;
											${schedule.title}
										</span>
									</c:if>
									<c:if test="${schedule.check_period eq 1}">
										<span>
											<fmt:formatDate value="${schedule.start_date}" pattern="MM.dd"/>
											-
											<fmt:formatDate value="${schedule.end_date}" pattern="MM.dd"/>
											&nbsp;
											${schedule.title}
										</span>
									</c:if>
								</li>
							</c:forEach>
						</ul>
						<c:if test="${scheduleList.size() > 0}">
							<div class="more-div">
								<a class="blue-color" href="/schedule.go">더보기</a>
							</div>
						</c:if>
					</div>
				</div>
				<br/><br/>
				<div class="section-title">전사 공지사항</div>
				<div>
					<div class="white-section">
						<table class="table">
							<thead>
								<tr>
									<th class="first-col table-active">제목</th>
									<th class="second-col table-active">작성자</th>
									<th class="third-col table-active">작성일자</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${boardList.size() < 1}">
									<tr>
										<td colspan="3">게시글이 없습니다.</td>
									</tr>
								</c:if>
								<c:forEach items="${boardList}" var="post">
									<tr>
										<td><a href="/allBoard/detail.go?post_no=${post.post_no}">${post.title}</a></td>
										<td>${post.user_name}&nbsp;${post.class_name}</td>
										<td><fmt:formatDate value="${post.reg_date}" pattern="yyyy.MM.dd"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<c:if test="${boardList.size() > 0}">
							<div class="more-div">
								<a class="blue-color" href="/allBoard/list.go">더보기</a>
							</div>
						</c:if>
						
					</div>
				</div>
			</div>
		</div>

	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
	var lastYearData = [];
	var thisYearData = [];
	
	var now = new Date();
	var month = now.getMonth() + 1;
	var months = [month];
	
	for (var i = 0; i < 5; i++) {
		month -= 1;
		if (month == 0) {
			month = 12;
		}
		months.unshift(month);
	}
	
	// console.log(months);
	
	$.ajax({
		type:'get',
		url:'/mainChart/list.ajax',
		data:{
			'months':months.toString()
		},
		dataType:'json',
		success:function(data) {
			lastYearData.push(data.dataList[1].first);
			lastYearData.push(data.dataList[1].second);
			lastYearData.push(data.dataList[1].third);
			lastYearData.push(data.dataList[1].fourth);
			lastYearData.push(data.dataList[1].fifth);
			lastYearData.push(data.dataList[1].sixth);
			
			thisYearData.push(data.dataList[0].first);
			thisYearData.push(data.dataList[0].second);
			thisYearData.push(data.dataList[0].third);
			thisYearData.push(data.dataList[0].fourth);
			thisYearData.push(data.dataList[0].fifth);
			thisYearData.push(data.dataList[0].sixth);
			
			var options = {
				series: [{
					name: '작년',
					data: lastYearData
				}, {
					name: '올해',
					data: thisYearData
				}],
				chart: {
					type: 'bar',
					height: 500,
				},
				plotOptions: {
					bar: {
						horizontal: false,
						columnWidth: '55%',
						endingShape: 'rounded'
					},
				},
				dataLabels: {
					enabled: false
				},
				stroke: {
					show: true,
					width: 2,
					colors: ['transparent']
				},
				xaxis: {
					categories: [months[0] + '월', months[1] + '월', months[2] + '월', months[3] + '월', months[4] + '월', months[5] + '월']
				},
				yaxis: {
					title: {
						text: '(백만원)'
					}
				},
				fill: {
					opacity: 1
				},
				tooltip: {
					y: {
						formatter: function (val) {
							return val + " 백만원"
						}
					}
				}
			};

			var chart = new ApexCharts(document.querySelector("#chart"), options);
			chart.render();
		},
		error: function(request, status, error) {
			console.log("code: " + request.status)
			console.log("message: " + request.responseText)
			console.log("error: " + error);
		}
	});
	
	var formattedDate  = now.toISOString().slice(0, 10).replaceAll('-', '');
	var xhr = new XMLHttpRequest();
	var url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst'; /*URL*/
	var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'UmhF950FSvXPa7p0fpc8kZ3e5Tv8DxDU1Gb7xvlC4VJZyRvOxCJVU%2BVoYTAoNdNe%2FqlyOsdt%2B8NBz%2BY8xlT4eg%3D%3D'; /*Service Key*/
	queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('*'); /**/
	queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('1000'); /**/
	queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('JSON'); /**/
	queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent(formattedDate); /**/
	queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent('0500'); /**/
	queryParams += '&' + encodeURIComponent('nx') + '=' + encodeURIComponent('58'); /**/
	queryParams += '&' + encodeURIComponent('ny') + '=' + encodeURIComponent('125'); /**/
	
	$.ajax({
		url: url + queryParams,
		dataType: "json",
		type: "GET",
		success: function(data) {
			var items = data.response.body.items.item;
	        var filteredItems = items.filter(function(item) {
	            return (item.fcstTime == "0600" || item.fcstTime == "1500") && (item.category == 'TMN' || item.category == 'TMX' || item.category == 'SKY' || item.category == 'PTY');
	        });
	        // console.log(filteredItems);
	        
	        var weatherContent = '';
	        weatherContent += '<table class="table table-borderless top-weather">';
	        weatherContent += '<tr>';
	        weatherContent += '<th>';
	        
	        if (filteredItems[3].fcstValue == 1 || filteredItems[3].fcstValue == 4) {
	        	weatherContent += '<span class="top-weather-icon"><i class="bi bi-cloud-rain"></i></span>';
			} else if (filteredItems[3].fcstValue == 2) {
				weatherContent += '<span class="top-weather-icon"><i class="bi bi-cloud-sleet"></i></span>';
			} else if (filteredItems[3].fcstValue == 3 ) {
				weatherContent += '<span class="top-weather-icon"><i class="bi bi-snow3"></i></span>';
			} else {
				if (filteredItems[2].fcstValue == 1) {
					weatherContent += '<span class="top-weather-icon"><i class="bi bi-sun"></i></span>';
				} else {
					weatherContent += '<span class="top-weather-icon"><i class="bi bi-clouds"></i></span>';
				}
			}
	        
	        weatherContent += '</th>';
	        weatherContent += '<td>';
	        weatherContent += filteredItems[2].fcstDate.substring(0, 4) + '-' + filteredItems[2].fcstDate.substring(4, 6) + '-' + filteredItems[2].fcstDate.substring(6);
	        weatherContent += '<br/>';
	        weatherContent += '<span class="top-temp blue-color">' + items[0].fcstValue + '℃</span>&nbsp;&nbsp;&nbsp;&nbsp;';
	        weatherContent += '<span class="top-temp black-color">/</span>&nbsp;&nbsp;&nbsp;&nbsp;';
	        weatherContent += '<span class="top-temp red-color">' + Math.round(filteredItems[4].fcstValue) + '℃</span>';
	        weatherContent += '</td>';
	        weatherContent += '</tr>';
	        weatherContent += '</table>';
	        weatherContent += '<br/>';
	        weatherContent += '<table class="table table-borderless bottom-weather">';
	        weatherContent += '<tr>';
	        weatherContent += '<th>';
	        
	        if (filteredItems[9].fcstValue == 1 || filteredItems[9].fcstValue == 4) {
	        	weatherContent += '<span class="bottom-weather-icon"><i class="bi bi-cloud-rain"></i></span>';
			} else if (filteredItems[9].fcstValue == 2) {
				weatherContent += '<span class="bottom-weather-icon"><i class="bi bi-cloud-sleet"></i></span>';
			} else if (filteredItems[9].fcstValue == 3) {
				weatherContent += '<span class="bottom-weather-icon"><i class="bi bi-snow3"></i></span>';
			} else {
				if (filteredItems[8].fcstValue == 1) {
					weatherContent += '<span class="bottom-weather-icon"><i class="bi bi-sun"></i></span>';
				} else {
					weatherContent += '<span class="bottom-weather-icon"><i class="bi bi-clouds"></i></span>';
				}
			}
	        
	        weatherContent += '</th>';
	        weatherContent += '<td>';
	        weatherContent += filteredItems[9].fcstDate.substring(0, 4) + '-' + filteredItems[9].fcstDate.substring(4, 6) + '-' + filteredItems[9].fcstDate.substring(6);
	        weatherContent += '<br/>';
	        weatherContent += '<span class="bottom-temp blue-color">' + Math.round(filteredItems[7].fcstValue) + '℃</span>&nbsp;&nbsp;';
	        weatherContent += '<span class="bottom-temp black-color">/</span>&nbsp;&nbsp;';
	        weatherContent += '<span class="bottom-temp red-color">' + Math.round(filteredItems[10].fcstValue) + '℃</span>';
	        weatherContent += '</td>';
	        weatherContent += '<th>';
	        
	        if (filteredItems[15].fcstValue == 1 || filteredItems[15].fcstValue == 4) {
	        	weatherContent += '<span class="bottom-weather-icon"><i class="bi bi-cloud-rain"></i></span>';
			} else if (filteredItems[15].fcstValue == 2) {
				weatherContent += '<span class="bottom-weather-icon"><i class="bi bi-cloud-sleet"></i></span>';
			} else if (filteredItems[15].fcstValue == 3) {
				weatherContent += '<span class="bottom-weather-icon"><i class="bi bi-snow3"></i></span>';
			} else {
				if (filteredItems[14].fcstValue == 1) {
					weatherContent += '<span class="bottom-weather-icon"><i class="bi bi-sun"></i></span>';
				} else {
					weatherContent += '<span class="bottom-weather-icon"><i class="bi bi-clouds"></i></span>';
				}
			}
	        
	        weatherContent += '</th>';
	        weatherContent += '<td>';
	        weatherContent += filteredItems[14].fcstDate.substring(0, 4) + '-' + filteredItems[14].fcstDate.substring(4, 6) + '-' + filteredItems[14].fcstDate.substring(6);
	        weatherContent += '<br/>';
	        weatherContent += '<span class="bottom-temp blue-color">' + Math.round(filteredItems[13].fcstValue) + '℃</span>&nbsp;&nbsp;';
	        weatherContent += '<span class="bottom-temp black-color">/</span>&nbsp;&nbsp;';
	        weatherContent += '<span class="bottom-temp red-color">' + Math.round(filteredItems[16].fcstValue) + '℃</span>';
	        weatherContent += '</td>';
	        weatherContent += '</tr>';
	        weatherContent += '</table>';
	        
	        $('.weather-div').html(weatherContent);
		},
		error: function(e) {
			console.log(e);
		}
	});
	
</script>
</html>