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
.main-section {
	background-color: white;
	width: 100%;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin-top: 15px;
}
.display-flex {
	display: flex;
}
.left-section {
	width: 50%;
	height: 100%;
	padding-right: 20px;
}
.right-section {
	width: 50%;
	height: 100%;
	padding-left: 20px;
}
.small-section {
	width: 33%;
}
.blue-color {
	color: rgb(88, 88, 255);
}
.white-color {
	color: white;
}
.gray-color {
	color: gray;
}
.text-align-center {
	text-align: center;
}
.big-font-size {
	font-size: 45px;
}
.blue-circle {
	width: 85px;
	height: 85px;
	border-radius: 50px;
	background-color: #0d6efd;
	margin: 0 auto;
	display: grid;
	align-content: center;
}
.datepicker {
	width: 200px;
	display: inline;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div class="main-section">
			<div class="pagetitle">
				<h1>근태 관리</h1>
			</div>
			<br/><br/>
			<div class="display-flex">
				<div class="left-section">
					<p class="blue-color"><b>오늘의 근태</b></p>
					<p class="gray-color" id="clock"></p>
					<table class="table table-bordered border-secondary">
						<colgroup>
							<col width="50%"/>
							<col width="50%"/>
						</colgroup>
						<tr>
							<td scope="col">
								<p><b>출근시간</b></p>
								<br/>
								<div class="text-align-center">
									<c:if test="${att.start_time eq null}">
										<button class="btn btn-primary btn-lg" onclick="attendance()">출근하기</button>
									</c:if>
									<c:if test="${att.start_time ne null}">
										<span><fmt:formatDate value="${att.start_time}" pattern="HH:mm:ss"/></span>
									</c:if>
								</div>
								<br/>
							</td>
							<th scope="col">
								<p><b>퇴근시간</b></p>
								<br/>
								<div class="text-align-center">
									<c:if test="${att.start_time ne null and att.end_time eq null}">
										<button class="btn btn-primary btn-lg" onclick="leaveWork()">퇴근하기</button>
									</c:if>
									<c:if test="${att.end_time ne null}">
										<span><fmt:formatDate value="${att.end_time}" pattern="HH:mm:ss"/></span>
									</c:if>
								</div>
								<br/>
							</th>
						</tr>
					</table>
				</div>
				<div class="right-section">
					<p class="blue-color"><b>당월 근태 현황</b></p>
					<p class="gray-color" id="month"></p>
					<table class="table table-bordered border-secondary">
						<tr>
							<td>
								<div class="display-flex">
									<div class="small-section text-align-center">
										<div class="blue-circle">
											<span class="big-font-size white-color">50</span>
										</div>
										<br/>
										<b>지각</b>
									</div>
									<div class="small-section text-align-center">
										<div class="blue-circle">
											<span class="big-font-size white-color">50</span>
										</div>
										<br/>
										<b>조퇴</b>
									</div>
									<div class="small-section text-align-center">
										<div class="blue-circle">
											<span class="big-font-size white-color">50</span>
										</div>
										<br/>
										<b>결근</b>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<br/><br/>
			<p class="blue-color"><b>누적 근태 현황</b></p>
			<p>
				<input type="date" id="start_date" class="form-control datepicker"/>
				&nbsp;&nbsp;~&nbsp;&nbsp;
				<input type="date" id="end_date" class="form-control datepicker"/>
				&nbsp;&nbsp;
				<button class="btn btn-outline-primary" onclick="searchList()">검색</button>
			</p>
			<table class="table">
				<colgroup>
					<col width="22%">
					<col width="22%">
					<col width="22%">
					<col width="22%">
					<col width="12%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="table-active text-align-center">날짜</th>
						<th scope="col" class="table-active text-align-center">출근시간</th>
						<th scope="col" class="table-active text-align-center">퇴근시간</th>
						<th scope="col" class="table-active text-align-center">근무시간</th>
						<th scope="col" class="table-active text-align-center">비고</th>
					</tr>
				</thead>
				<tbody id="attList"></tbody>
			</table>
			<ul class="pagination d-flex justify-content-center" id="pagination"></ul>
		</div>
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
	setClock();
	setInterval(setClock, 1000);

	setMonth();
	
	var start_date = $('#start_date').val();
	var end_date = $('#end_date').val();
	var page = 1;
	var totalPage = 0;
	
	listCall(page, start_date, end_date);
	
	function setClock() {
		var now = new Date();
		
		var hour = now.getHours();
		if (hour < 10) {
			hour = '0' + hour;
		}
		var min = now.getMinutes();
		if (min < 10) {
			min = '0' + min;
		}
		var sec = now.getSeconds();
		if (sec < 10) {
			sec = '0' + sec;
		}
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var day = now.getDate();
		
		var clockContent = '<b>' + year + '년 ' + month + '월 ' + day + '일 ' + hour + ':' + min + ':' + sec + '</b>';
		
		$('#clock').html(clockContent);
	}
	
	function setMonth() {
		var now = new Date();
		
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var monthContent = '<b>' + year + '년 ' + month + '월</b>';
		$('#month').html(monthContent);
	}
	
	function listCall(page, start_date, end_date) {
		$.ajax({
			type:'get',
			url:'/commute/att/List.ajax',
			data:{
				'page':page,
				'start_date':start_date,
				'end_date':end_date
			},
			dataType:'json',
			success:function(data) {
				// console.log('시작');
				totalPage = data.totalPage;
				
				drawList(data.list);
				
				var option = {
					totalPages: totalPage,
					startPage: page
				};
				window.pagination.init($('#pagination'), option, function(currentPage) {
					page = currentPage;
					listCall(page, searchCondition, searchContent);
				});
			},
			error : function(request, status, error) {
				console.log("code: " + request.status)
				console.log("message: " + request.responseText)
				console.log("error: " + error);
			}
		});
	}
	
	function drawList(list) {
		var content = '';
		
		if (list.length == 0) {
			content += '<tr>';
			content += '<td colspan="5">조회할 수 있는 근태 자료가 없습니다.</td>';
			content += '</tr>';
			
			$('#pagination').css('display', 'none');
		} else {
			for (var item of list) {
				content = '<tr>';

				var date = new Date(item.work_date);
				var dateStr = date.toLocaleDateString("ko-KR");
				content = '<td class="text-align-center">' + dateStr + '</td>';
				
				date = new Date(item.start_time);
				dateStr = date.toLocaleDateString("ko-KR");
				content = '<td class="text-align-center">' + dateStr + '</td>';
				
				date = new Date(item.end_time);
				dateStr = date.toLocaleDateString("ko-KR");
				content = '<td class="text-align-center">' + dateStr + '</td>';
				
				content = '<td class="text-align-center">' + item.work_hour + '</td>';
				
				if (item.state == 0) {
					content = '<td class="text-align-center">지각</td>';
				} else if (item.state == 1) {
					content = '<td class="text-align-center">조퇴</td>';
				} else if (item.state == 2) {
					content = '<td class="text-align-center">결근</td>';
				}
				content = '</tr>';
			}
		}
		
		$('#attList').html(content);
	}
	
	function attendance() {
		location.href = "/commute/attendance.do";
	}
	
	function leaveWork() {
		location.href = "/commute/leaveWork.do";
	}
</script>
</html>