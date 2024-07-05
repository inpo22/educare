<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>학생정보 - 학생관리 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<jsp:include page="/views/common/head.jsp"></jsp:include>
<link href="/resources/std/std.css" rel="stylesheet">

<!-- js -->
<script src="/resources/js/pagination_module.js" type="text/javascript"></script>

<style>

.col-md-3{
	margin:10px 0 0 50px;
}
@media (max-width: 768px) {
    .std-profile {
        flex-direction: column; /* 작은 화면에서 세로 정렬 */
        align-items: center;
    }
    .std-info .row .col-md-6, .std-info .row .col-md-8 {
        flex: 0 0 100%; /* 전체 너비 차지 */
        max-width: 100%;
    }
    .std-info .row .col-md-2 {
        text-align: center;
    }
}

.info-group {
    display: flex;
    align-items: center;
    margin : 10px 0;
}

.info-group p {
    margin: 0;
    margin-right: 10px;
    min-width: 100px; /* 최소 너비 설정으로 정렬을 개선 */
}

.info-group input,.progress {
    flex: 1;
}

#name {
    font-weight: bold;
    text-align: center;
    margin-left: 30px;
}
.std-profile img{
    width: 150px; /* 사진의 너비 조정 */
    height: auto; /* 높이 자동 조정 */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
    margin-left: 30px;
}


#Asearchbox,#Psearchbox,#Csearchbox{
	width: 250px;
	margin : 7px 0;
}
#Asearch_btn,#Psearch_btn,#reset_btn,#Csearch_btn,#Creset_btn,#Areset_btn
{
	margin : 7px 5px;
}
#courseReg_btn{
	margin : 7px 0 7px 10px;
}

#stdList_go{
	height:38px;
	margin-right: 7px;
}

#attd_btn{
	margin-right: 7px;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<div id="detailBoard">
				<div class="std-profile row">
				    <div class="col-md-3">
				        <c:choose>
				            <c:when test="${not empty stdDto.photo}">
				                <img src="/photo/${stdDto.photo}" class="img-fluid">
				            </c:when>
				            <c:otherwise>
				                <!-- 기본 프로필 사진 또는 다른 대체 이미지 -->
				                <i class="bi bi-person-fill"></i>
				            </c:otherwise>
				        </c:choose>
				        <div class="col-md-6">
		                    <div class="info-group mt-2">
		                        <input type="text" value="${stdDto.name}" id="name" name="name" class="form-control" readonly>
		                    </div>
		                </div>
				    </div>
				    <div class="col-md-8">
				        <div class="std-info">
				            <div class="row">
				                <div class="col-md-6">
				                    <div class="info-group">
				                        <p><strong>학생번호:</strong></p>
				                        <input type="text" value="${stdDto.user_code}" id="user_code" name="user_code" class="form-control custom-input" readonly>
				                    </div>
				                    <div class="info-group">
				                        <p><strong>이메일:</strong></p>
				                        <input type="text" value="${stdDto.email}" id="email" name="email" class="form-control" readonly>
				                    </div>
				                    <div class="info-group">
				                        <p><strong>등록일:</strong></p>
				                        <input type="text" value="${stdDto.reg_date}" id="reg_date" name="reg_date" class="form-control" readonly>
				                    </div>
				                </div>
				                <div class="col-md-6">
				                    <div class="info-group">
				                        <p><strong>아이디:</strong></p>
				                        <input type="text" value="${stdDto.id}" id="id" name="id" class="form-control" readonly>
				                    </div>
				                    <div class="info-group">
				                        <p><strong>연락처:</strong></p>
				                        <input type="text" value="${stdDto.phone}" id="phone" name="phone" class="form-control" readonly>
				                    </div>
				                    <div class="info-group">
				                        <p><strong>생년월일:</strong></p>
				                        <input type="text" value="${stdDto.birth}" id="birth" name="birth" class="form-control" readonly>
				                    </div>
				                </div>
				                <div class="col-md-12">
				                    <div class="info-group mt-3">
				                        <p><strong>성실도:</strong></p>
				                        <div class="progress">
				                            <div id="attdRate" class="progress-bar progress-bar-striped" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">0%</div>
				                        </div>
				                    </div>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>
			    <div class="col-md-12 d-flex justify-content-end">
			    	<button id="stdList_go" class="btn btn-dark" type="button">학생리스트</button>
			    	<form action="/std/edit.go" method='get'>
			    		<input type="hidden" name="user_code" value="${stdDto.user_code}">
			    		<button id="edit_btn" class="btn btn-dark" type="submit">수정</button>
			    	</form>			    
				</div>

				
				

			</div>			
			<br><br>
			<div class="card-body">
              <!-- Default Tabs -->
              <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                  <button class="nav-link active" id="course-tab" data-bs-toggle="tab" data-bs-target="#course" type="button" role="tab" aria-controls="course" aria-selected="true" >수강이력</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" id="attd-tab" data-bs-toggle="tab" data-bs-target="#attd" type="button" role="tab" aria-controls="attd" aria-selected="false" tabindex="-1">출석현황</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" id="pay-tab" data-bs-toggle="tab" data-bs-target="#pay" type="button" role="tab" aria-controls="pay" aria-selected="false" tabindex="-1">결제내역</button>
                </li>
              </ul>
              <div class="tab-content pt-2" id="myTabContent">
                <div class="tab-pane fade active show" id="course" role="tabpanel" aria-labelledby="course-tab">
                	<div class="row justify-content-end">
					    <div class="col-auto">
					        <div class="d-flex">
					            <button id="courseReg_btn" type="button" class="btn btn-dark me-2" onclick="openModal()">+강의등록</button>
					            <input id="Csearchbox" type="text" class="form-control" placeholder="강의명을 입력하세요." aria-label="Recipient's course" aria-describedby="button-addon2">
					            <button id="Csearch_btn" class="btn btn-outline-dark" type="button">검색</button>
					        	<button id="Creset_btn" class="btn btn-outline-dark" type="button"><i class="bi bi-arrow-clockwise"></i></button>
					        </div>
					    </div>
					</div>

                
					<!-- Start table -->
					<table class="table">
					  <thead class="table-light">
					    <tr>
					      <th scope="col">강의명</th>
					      <th scope="col">강사명</th>
					      <th scope="col">시작일</th>
					      <th scope="col">종료일</th>
					      <th scope="col">결제여부</th>
					    </tr>
					  </thead>
					  <tbody id="courseList">
					  </tbody>
					</table>
					<!-- End table -->
					
					<br/>
			
					<!--  페이징 시작 -->
					<ul class="pagination d-flex justify-content-center" id="pagination_course"></ul>
					<!-- 페이징 끝 -->
					
                </div>
                <div class="tab-pane fade" id="attd" role="tabpanel" aria-labelledby="attd-tab">
					<div class="row justify-content-end">
					    <div class="col-auto">
					        <div class="d-flex">
					            <input id="Asearchbox" type="text" class="form-control" placeholder="강의명을 입력하세요." aria-label="Recipient's course" aria-describedby="button-addon2">
					            <button id="Asearch_btn" class="btn btn-outline-dark" type="button">검색</button>
					            <button id="Areset_btn" class="btn btn-outline-dark" type="button"><i class="bi bi-arrow-clockwise"></i></button>					        
					        </div>
					    </div>
					</div>
					
					<!-- Start table -->
					<table class="table">
					  <thead class="table-light">
					    <tr>
					      <th scope="col">강의명</th>
					      <th scope="col">날짜</th>
					      <th scope="col">출석여부</th>
					    </tr>
					  </thead>
					  <tbody id="attdList">
					  </tbody>
					</table>
					<!-- End table -->
					
					<br/>
			
					<!-- 페이징 시작 -->
					<ul class="pagination d-flex justify-content-center" id="pagination_attd"></ul>
					<!-- 페이징 끝 -->
			
                </div>
                <div class="tab-pane fade" id="pay" role="tabpanel" aria-labelledby="pay-tab">
					<div class="row justify-content-end">
					    <div class="col-auto">
					        <div class="d-flex">
					            <input id="Psearchbox" type="text" class="form-control" placeholder="강의명을 입력하세요." aria-label="Recipient's course" aria-describedby="button-addon2">
					            <button id="Psearch_btn" class="btn btn-outline-dark" type="button">검색</button>
					            <button id="reset_btn" class="btn btn-outline-dark" type="button"><i class="bi bi-arrow-clockwise"></i></button>
					        </div>
					    </div>
					</div>
					
					<!-- Start table -->
					<table class="table">
					  <thead class="table-light">
					    <tr>
					      <th scope="col">강의명</th>
					      <th scope="col">강사명</th>
					      <th scope="col">결제금액</th>
					      <th scope="col">결제날짜</th>
					    </tr>
					  </thead>
					  <tbody id="payList">
					  </tbody>
					</table>
					<!-- End table -->
					
					<br/>
			
					<!-- 페이징 시작 -->
					<ul class="pagination d-flex justify-content-center" id="pagination_pay"></ul>
					<!-- 페이징 끝 -->
					
                </div>
              </div><!-- End Default Tabs -->

            </div>
		
		</div>
	</main>
	<!-- End #main -->
	
	<!-- 강의 등록 모달 -->
	<div class="modal" id="course-modal">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title">강의선택</h3>
					<button type="button" class="btn-close" data-bs-dismiss=".modal" onclick="CloseModal()"></button>					
				</div>
				<div class="modal-body">
				    <table class="table">
				        <thead>
				        	<tr>
						      <th scope="col">강의명</th>
						      <th scope="col">강사명</th>
						      <th scope="col">강의실</th>
						    </tr>
				        </thead>
				        <tbody id="course-sel"></tbody>
				    </table>
				</div>
				<div class="modal-footer">
					<div class="selected-course-wrapper">
	                    <span><strong>선택한 강의: </strong></span>
	                    <textarea id="selected-course" readonly></textarea>
	                </div>
	                <form action="/std/course_reg.do" method="post">
	                	<input type="hidden" id="user_code" name="user_code" value="${stdDto.user_code}"/>
						<input type="hidden" id="course_name" name="course_name"/>					
						<button id="course_reg" class="btn btn-dark">선택하기</button>
	                </form>
	                
				</div>
			</div>			
		</div>
	</div>

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
var msg = '${msg}'; // 쿼터 빠지면 넣은 문구가 변수로 인식됨.
if(msg != ''){
	alert(msg);
}

/* // 수정버튼 클릭
$('#edit_btn').click(function(){
	window.location.href = '/std/edit.go';
}); */

//학생 리스트 이동
$('#stdList_go').click(function(){
	window.location.href = '/std/list.go';
});


//성실도(출석률)
$(document).ready(function(){
	var user_code=$('#user_code').val();
	
	$.ajax({
		type:'get',
		url:'/std/attRate.ajax',
		data:{
			'user_code':user_code
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			
			var attdRate = parseFloat(data);
			
			$('#attdRate').css('width', attdRate + '%');
            $('#attdRate').attr('aria-valuenow', attdRate);
            $('#attdRate').text(attdRate + '%');
		},
		error:function(error){
			console.log(error);
		}
	});
});




//Pagination 전 변수 선언
var type=-1;
var page = 1;
var totalPage = 0;
var Psearchbox = '';
var Csearchbox='';
var Asearchbox='';
var user_code = '${stdDto.user_code}';

CourseListCall(page, Csearchbox, user_code);


/* !모든 강의선택 모달 스크립트 시작! */

function select(row) {
    // 기존 선택된 행을 초기화
    var rows = document.querySelectorAll('#course-sel tr');
    rows.forEach(function(r) {
        r.classList.remove('selected');
    });
    // 선택된 행에 클래스 추가
    row.classList.add('selected');
    
 	// 선택된 행의 값 출력
    var selectedCourse = {
        course_name: row.cells[0].textContent,
        name: row.cells[1].textContent,
        course_space: row.cells[2].textContent
    };
    console.log('선택된 강의:', selectedCourse);
    
 // 선택된 행의 값을 텍스트 박스에 출력
    var selectedCourse = row.cells[0].textContent + ' - ' + row.cells[1].textContent + ' - ' + row.cells[2].textContent;
    var selectedCourseInput = document.getElementById('selected-course');
    selectedCourseInput.value = selectedCourse;
    
    // 강의 명 추출 후 텍스트 박스에 입력
    var course_name = document.getElementById('course_name');
    course_name.value = row.cells[0].textContent;
    
    // 텍스트 박스 크기 조절
    resizeTextarea(selectedCourseInput);
}

function resizeTextarea(textarea) {
    textarea.style.height = 'auto';
    textarea.style.height = textarea.scrollHeight + 'px';
}

// 선택하기 버튼
$('#course_reg').click(function(){
	course_name = $('#course_name').val();
	if(course_name == ''){
		alert("강의를 선택해주세요.");
		event.preventDefault();
	}
});

// 강의 선택 모달 리스트 뿌리기
function CourseModalList(){
	$.ajax({
		type:'post',
		url:'/std/course_modal.ajax',
		data:{
			
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			drawCourseModal(data.mList);
		},
		error:function(error){
			console.log(error);
		}
	});
}


//강의 선택 모달 리스트 그리기
function drawCourseModal(CourseModalList){
	var content='';
	console.log(CourseModalList);
	
	for(data of CourseModalList){
		content += '<tr onclick="select(this)">';
		content += '<td>' + data.course_name + '</td>';
		content += '<td>' + data.name + '</td>';
		content += '<td>' + data.course_space + '</td>';
		content += '</tr>';
	}
	$('#course-sel').html(content);
}

function openModal() {
    $('#course-modal').css('display', 'block');
    user_code = document.getElementById('user_code').value; // user_code 값 저장
    CourseModalList(); 
} 

function CloseModal() {
    $('#course-modal').css('display', 'none');
    
} 

/* !모든 강의선택 모달 스크립트 끝! */


/* !모든 수강이력 스크립트 시작! */
 

// 수강이력 리스트 뿌리기 시작 
function CourseListCall(page, Csearchbox, user_code){
	$.ajax({
		type:'post',
		url:'/std/detail_course.ajax',
		data:{
			'page':page,
			'Csearchbox':Csearchbox,
			'user_code':user_code
		},
		dataType:'json',
		success:function(data){
			//console.log(data);
			totalPage = data.totalPage;
			drawCourseList(data.cList);
			
			var option = {
				totalPages: totalPage,
				startPage: page
			};
			window.pagination.init($('#pagination_course'), option, function(currentPage) {
				page = currentPage;
				CourseListCall(page, Csearchbox, user_code);
			});
		},
		error:function(error){
			console.log(error);
		}
	});
}
// 수강이력 리스트 그리기 시작
function drawCourseList(courseList){
	var content = '';
	
	if(courseList.length == 0){
		content = '<tr><td colspan ="5" class="no-course">등록된 강의가 없습니다.</td></tr>';
	}else{
		console.log(courseList);
		
		for(data of courseList){
			var start = data.course_start.split("T")[0];
			var end = data.course_end.split("T")[0];
			
			content += '<tr>';
			content += '<td>' + data.course_name + '</td>';
			content += '<td>' + data.name + '</td>';
			content += '<td>' + start + '</td>';
			content += '<td>' + end + '</td>';
			if(data.pay_state == 0) {
				content += '<td class="payment-pending">결제대기</td>';
	        } else if(data.pay_state == 1) {
	        	content += '<td class="payment-completed">결제완료</td>';
	        } else if(data.pay_state == 2) {
	        	content += '<td class="payment-cancelled">결제취소</td>';
	        }
			content += '</tr>';
		}
	}	
	$("#courseList").html(content);
}


//필터링 검색 버튼 함수
$('#Csearch_btn').click(function(){
	Csearchbox = $('#Csearchbox').val();
	if(Csearchbox == ''){
		alert("검색어를 입력해주세요.");
		return;
	}
	CourseListCall(page, Csearchbox, user_code);
});

//리셋버튼 함수
$('#Creset_btn').click(function(){
	$('#Csearchbox').val('');	
	Csearchbox = '';
	CourseListCall(page, Csearchbox, user_code);
});

/* !모든 수강이력 스크립트 끝! */

/* -------------------------------------------------------------------------------------- */

/* ! 출석현황 스크립트 시작 ! */

// 출석현황 리스트 뿌리기 시작
function attdListCall(page, Asearchbox, user_code){
	$.ajax({
		type:'post',
		url:'/std/detail/attd.ajax',
		data:{
			'page':page,
			'Asearchbox':Asearchbox,
			'user_code':user_code
		},
		success:function(data){
			//console.log(data);

			totalPage = data.totalPage;
			drawAttdList(data.aList);
			
			var option = {
				totalPages: totalPage,
				startPage: page
			};
			window.pagination.init($('#pagination_attd'), option, function(currentPage) {
				page = currentPage;
				attdListCall(page, Asearchbox, user_code);
			});
		},
		error:function(error){
			console.log(error);
		}
	});
}

// 출석현황 리스트 그리기 시작
function drawAttdList(attdList){
	var content = '';
	
	if(attdList.length == 0){
		content = '<tr><td colspan ="3" class="no-attd">출석내역이 없습니다.</td></tr>';
	}else{
		console.log(attdList);
		
		for(data of attdList){
			content += '<tr>';
			content += '<td>' + data.course_name + '</td>';
			content += '<td>' + data.att_date + '</td>';
			if(data.att_state == 0){
				content += '<td>';
				content += '<button id="attd_btn" class="btn btn-danger btn-sm" onclick="attd(\'' + data.course_name + '\', \'' + data.att_date + '\')">출석</button>';
				content += '<button id="absent_btn" class="btn btn-primary btn-sm" onclick="absent(\'' + data.course_name + '\', \'' + data.att_date + '\')">결석</button>';
				content += '</td>';
			}else if(data.att_state == 1){
				content += '<td class = "attd_success">출석</td>';
			}else if(data.att_state == 2){
				content += '<td class="attd_fail">결석</td>';
			}
			content += '</tr>';
		}
	}	
	$('#attdList').html(content);
}

// 출석 버튼 함수
function attd(course_name,att_date){
	var user_code = '${stdDto.user_code}';
	location.href = '/std/attd.do?course_name='+course_name+'&user_code='+user_code+'&att_date='+att_date;
}

// 결석 버튼 함수
function absent(course_name,att_date){
	var user_code = '${stdDto.user_code}';
	location.href = '/std/absent.do?course_name='+course_name+'&user_code='+user_code+'&att_date='+att_date;
}

//필터링 검색 버튼 함수
$('#Asearch_btn').click(function(){
	Asearchbox = $('#Asearchbox').val();
	if(Asearchbox == ''){
		alert("검색어를 입력해주세요.");
		return;
	}
	attdListCall(page, Asearchbox, user_code);
});

//리셋버튼 함수
$('#Areset_btn').click(function(){
	$('#Asearchbox').val('');	
	Asearchbox = '';
	attdListCall(page, Asearchbox, user_code);
});

/* ! 출석현황 스크립트 끝 ! */

/* -------------------------------------------------------------------------------------- */


/* !모든 결제내역 스크립트 시작! */

/* 결제내역 리스트 뿌리기 시작 */
function listCall(page, Psearchbox, user_code){
	$.ajax({
		type:'post',
		url:'/std/detail_pay.ajax',
		data:{
			'page':page,
			'Psearchbox':Psearchbox,
			'user_code':user_code
		},
		dataType:'json',
		success:function(data){
			//console.log(data);
			totalPage = data.totalPage;			
			drawPayList(data.list);
			
			var option = {
				totalPages: totalPage,
				startPage: page
			};
			window.pagination.init($('#pagination_pay'), option, function(currentPage) {
				page = currentPage;
				listCall(page, Psearchbox, user_code);
			});
		},
		error:function(error){
			console.log(error);
		}
	});
}
/* 결제내역 리스트 뿌리기 끝 */


/* 결제내역 리스트 그리기 시작 */
function drawPayList(payList){
	var content = '';
	
	if(payList.length == 0){
		content = '<tr><td colspan ="4" class="no-payment">결제내역이 없습니다.</td></tr>';
	}else{
		console.log(payList);
		
		for(data of payList){
			content += '<tr>';
			content += '<td>' + data.course_name + '</td>';
			content += '<td>' + data.name + '</td>';
			content += '<td>' + data.course_price + '</td>';
			content += '<td>' + data.pay_date + '</td>';
			content += '</tr>';
		}
	}	
	$('#payList').html(content);
}
/* 결제내역 리스트 그리기 끝 */


//필터링 검색 버튼 함수
$('#Psearch_btn').click(function(){
	Psearchbox = $('#Psearchbox').val();
	if(Psearchbox == ''){
		alert("검색어를 입력해주세요.");
		return;
	}
	listCall(page, Psearchbox, user_code);
});

// 리셋버튼 함수
$('#reset_btn').click(function(){
	$('#Psearchbox').val('');	
	Psearchbox = '';
	listCall(page, Psearchbox, user_code);
});
/* 모든 결제내역 스크립트 끝 */

/* -------------------------------------------------------------------------------------- */

/* 페이징처리 스크립트 시작 */

$('.nav-link').click(function() {
	var html = $(this).html();
	page = 1;
	if (html == '수강이력') {
		CourseListCall(page, Csearchbox, user_code);
	} else if (html == '출석현황') {
		attdListCall(page, Asearchbox, user_code);
	} else if (html == '결제내역') {
		listCall(page, Psearchbox, user_code);
	}
 });

/* 페이징처리 스크립트 끝 */


 
</script>
</html>