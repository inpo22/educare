<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>연차내역 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- css -->

<!-- js -->
<script src="/resources/js/pagination_module.js" type="text/javascript"></script>
<style>
#backBoard{
	background-color: white;
	width: 100%;
    border-radius: 20px;
	padding: 20px 0;
}

#vacaTitle{
	margin-left: 20px;
}

.subTitle h5{
	font-weight: bold;
	color: rgba(52, 152, 219, 0.76);
	margin-left: 20px;
}

.leaveVacation {
    text-align: center;
    border-collapse: collapse; 
    width: 95%; 
    margin-left: 20px;
}

.leaveVacation .thead th {
    background-color: lightgray;
    border: 1px solid darkgray; 
    font-size: 20px; 
    font-weight: bold;
    vertical-align: middle;
}

.leaveVacation .tbody td {
    border: 1px solid darkgray; 
    color: rgba(52, 152, 219, 0.76); 
    font-weight: bold; 
    font-size: 20px; 
    height: 100px;
    vertical-align: middle;
}

.useVacationHistory {
	text-align: center;
	border-collapse: collapse;
	width: 95%;
	margin: 0px 20px;
}

.useVacationHistory .thead th {
	background-color: lightgray;
    border: 1px solid darkgray;
    font-size: 17px; 
    font-weight: bold;
    height : 30px;
    vertical-align: middle;
}

.useVacationHistory .tbody td{
	border: 1px solid darkgray;
	height : 30px;
    vertical-align: middle;
}

</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<br/>
			<div class="pagetitle">
				<h1 id="vacaTitle"><a href="/vacaHistory.go" style="color:black;">연차 내역</a></h1>
			</div>
			<br/>
			<div class="subTitle"><h5>남은 연차</h5></div>
			<br/>
			<table class="leaveVacation">
				<thead class="thead">
					<tr>
						<th scope="col">총 연차</th>
						<th scope="col">사용 연차</th>
						<th scope="col">남은 연차</th>
					</tr>
				</thead>
				<tbody class="tbody">
					<tr>
						<td scope="col" id="totalLeave">15</td>
						<td scope="col" id="useLeave">${dto.useLeave}</td>
						<td scope="col" id="remain">${dto.remain}</td>
					</tr>
				</tbody>
			</table>
			<br/><br/>
			<div class="subTitle"><h5>연차 사용 이력</h5></div>
			<br/>
			<table class="useVacationHistory">
				<colgroup>
					<col width="15%">
					<col width="20%">
					<col width="10%">
					<col width="5%">
				</colgroup>
				<thead class="thead">
					<tr>
						<th scope="col">연차 신청 일자</th>
						<th scope="col">연차 사용 기간</th>
						<th scope="col">연차 유형</th>
						<th scope="col">사용 일수</th>
					</tr>	
				</thead>
				<tbody class="tbody" id="list">

				</tbody>
			</table>
			<br/><br/>
			<div id="pagination-div">
					<ul class="pagination d-flex justify-content-center" id="pagination"></ul>
				</div>
		</div>
		<!-- End Page Title -->

	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body> 
<script>
var page = 1;
var totalPage = 0;
listCall(page);

function listCall(page){
	$.ajax({
		type:'post',
		url:'/vacaHistory/list.ajax',
		data:{
			'page':page
		},
		dataType:'JSON',
		success:function(data){
			console.log(data);
			totalPage = data.totalPage;
			
			drawList(data.list);
			
			var option = {
				totalPages: totalPage,
				startPage: page
			};
			window.pagination.init($('#pagination'), option, function(currentPage) {
				page = currentPage;
				listCall(page);
			});
		},
		error:function(error){
			console.log("code: " + request.status);
			console.log("message: " + request.responseText);
			console.log("error: " + error);
		}
	});
}

function drawList(list){
	var context = '';
	for (var item of list){
		context += '<tr class="useVacationHistoryTr">'
		context += '<td scope="col">'+formatDate(item.reg_date)+'</td>'
		context += '<td scope="col">'+formatDate(item.start_date)+' ~ '+formatDate(item.end_date)+'</td>'
		context += '<td scope="col">'+getVacationTypeName(item.va_type)+'</td>'
		context += '<td scope="col">'+item.va_days+'</td>'
		context += '</tr>';
	}
	$('#list').html(context);
}

// 휴가 종류 반환 
function getVacationTypeName(vaType) {
    switch (vaType) {
        case 0: return "연차";
        case 1: return "오전 반차";
        case 2: return "오후 반차";
        case 3: return "경조사";
        case 4: return "공가";
        case 5: return "병가";
        case 6: return "대체휴가";
        default: return "알 수 없음";
    }
}

function formatDate(dateStr) {
    var date = new Date(dateStr); // dateStr을 Date 객체로 변환
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1, 2자리로 만듦
    var day = ('0' + date.getDate()).slice(-2); // 일도 2자리로 만듦
    return year + '-' + month + '-' + day;
}










</script>
</html>