<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>퇴사자관리 - 사원관리 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<jsp:include page="/views/common/head.jsp"></jsp:include>
<link href="/resources/emp/emp.css" rel="stylesheet">

<!-- js -->
<script src="/resources/js/pagination_module.js" type="text/javascript"></script>

<style>
#searchbox, #date {
	width: 100%;
	margin: 7px 0;
}
#inputdate, #searchdate_btn {
	margin: 7px 0;
}
#type {
	width: 100%;
	margin: 7px 0;
}
#search_btn, #reset_btn {
	margin: 7px 5px;
	height:40px;
}
.input-group {
	width: 100%;
}
@media (min-width: 768px) {
	#searchbox {
		width: 250px;
	}
	#date {
		width: auto;
	}
	#type,#dateType {
		width: 100px;
	}
	.input-group.date {
		width: auto;
	}
}
.bi.bi-arrow-clockwise{
	font-size: 20px;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<div class="pagetitle">
				<h1><a href="/emp/list.go">퇴사자 목록</a></h1>
			</div>
			<!-- End Page Title -->
			<br/>
			<br/>
			<br/>
			
			<div class="row">
				<div class="d-flex">
					<button id="empList_btn" type="button" class="btn btn-secondary">사원 목록</button>  
				</div>
			</div>

			<div class="row mb-2">          
				<div class="d-flex flex-wrap align-items-center">
					<select id="dateType" class="form-select" aria-label="Default select example">
						<option value="reg_date">입사일</option>
						<option value="quit_date">퇴사일</option>
					</select>
					<div id="date" class="input-group date">
						<input id="startDate" type="date" class="form-control">
					</div>
					<div>
						<span id="inputdate" class="input-group-text">~</span>
					</div>
					<div id="date" class="input-group date">
						<input id="endDate" type="date" class="form-control">
					</div>
					<button id="searchdate_btn" type="button" class="btn btn-outline-dark">검색</button>

					<div id="search" class="ms-auto d-flex align-items-center">
						<select id="type" class="form-select" aria-label="Default select example">
							<option value="team">부서</option>
							<option value="class">직책</option>
							<option value="position">직급</option>
							<option value="name">이름</option>
						</select>
						<input id="searchbox" type="text" class="form-control" placeholder="검색어를 입력하세요." aria-label="Recipient's username" aria-describedby="button-addon2">
						<button id="search_btn" class="btn btn-outline-dark" type="button">검색</button>
						<button id="reset_btn" class="btn btn-outline-dark" type="button"><i class="bi bi-arrow-clockwise"></i></button>						
					</div>
				</div>
			</div>
			
			<!-- Start table -->
			<table class="table">
			  <thead>
			    <tr class="table-active">
			      <th scope="col">사원번호</th>
			      <th scope="col">이름</th>
			      <th scope="col">부서</th>
			      <th scope="col">직급</th>
			      <th scope="col">직책</th>
			      <th scope="col">입사일</th>
			      <th scope="col">퇴사일</th>			      
			    </tr>
			  </thead>
			  <tbody id="quitList">
			  </tbody>
			</table>
			<!-- End table -->
			
			<br/>
			<p>퇴사자 수 : 총  ${quitCnt}명</p>
			
			<!-- 페이징 시작 -->
			<ul class="pagination d-flex justify-content-center" id="pagination"></ul>
			<!-- 페이징 끝 -->
			
		</div>
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
//Pagination 전 변수 선언
var page = 1;
var totalPage = 0;
var dateType = '';
var type = '';
var searchbox = '';
var startDate = '';
var endDate = '';

listCall(page, dateType, type, searchbox, startDate, endDate);

// 사원목록 페이지 이동
$('#empList_btn').click(function(){
	window.location.href = '/emp/list.go';
});

// 리스트 뿌리기
function listCall(page, dateType, type, searchbox, startDate, endDate){
	$.ajax({
		type:'post',
		url:'/emp/quitList.ajax',
		data:{
			'page':page,
			'dateType':dateType,
			'type':type,
			'searchbox':searchbox,
			'startDate':startDate,
			'endDate':endDate
		},
		dataType:'json',
		success:function(data){
			//console.log(data);
			totalPage = data.totalPage;		
			drawQuitList(data.Qlist);
			
			var option = {
				totalPages: totalPage,
				startPage: page
			};
			window.pagination.init($('#pagination'), option, function(currentPage) {
				page = currentPage;
				listCall(page, dateType, type, searchbox, startDate, endDate);
			});
		},
		error:function(error){
			console.log(error)
		}
	});
}

// 리스트 그리기
function drawQuitList(quitList){
	var content='';
	
	for(data of quitList){
		content += '<tr>';
		content += '<td><a href="/emp/detail.go?user_code='+ data.user_code +'">' + data.user_code + '</td>';
		content += '<td>' + data.name + '</td>';
		content += '<td>' + data.team_name + '</td>';
		content += '<td>' + data.class_name + '</td>';
		content += '<td>' + data.position_name + '</td>';
		content += '<td>' + data.reg_date + '</td>';
		content += '<td>' + data.quit_date + '</td>';
		content += '</tr>';
	}
	$('#quitList').html(content);
}

// 날짜 검색 버튼 함수
$('#searchdate_btn').click(function(){
	dateType = $('#dateType').val();
	startDate = $('#startDate').val();
	endDate = $('#endDate').val();
	if(startDate == '' && endDate == ''){
		alert("날짜를 선택해주세요.");
		return;
	}else if(startDate > endDate){
		alert("날짜를 확인해주세요.");
		return;
	}
	listCall(page, dateType, type, searchbox, startDate, endDate);
});

//필터링 검색 버튼 함수
$('#search_btn').click(function(){
	type = $('#type').val();
	searchbox = $('#searchbox').val();
	if(searchbox == ''){
		alert("검색어를 입력해주세요.");
		return;
	}
	listCall(page, dateType, type, searchbox, startDate, endDate);
});

// 리셋버튼 함수
$('#reset_btn').click(function(){
	$('#searchbox').val('');
	$('#startDate').val('');
	$('#endDate').val('');
	searchbox='';
	startDate='';
	endDate='';
	listCall(page, dateType, type, searchbox, startDate, endDate);
});

</script>
</html>