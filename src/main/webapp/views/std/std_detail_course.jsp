<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
#backBoard {
    background-color: white;
    width: 100%;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-top: 20px;
}
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}
#detailBoard {
    background-color: #E2E2E2;
    width: 100%;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-top: 20px;
}
.bi.bi-person-fill {
    font-size: 150px;
    height: auto; 
    margin-left: 30px;
}
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


#searchbox,#Psearchbox,#Csearchbox{
	width: 250px;
	margin : 7px 0;
}
#search_btn,#Psearch_btn,#reset_btn,#Csearch_btn,#Creset_btn
{
	margin : 7px 5px;
}
#courseReg_btn{
	margin : 7px 0 7px 10px;
}
.bi.bi-arrow-clockwise{
	font-size: 24px;
}
#stdList_go{
	height:38px;
	margin-right: 7px;
}
.modal-body{
	max-height: 200px; 
	overflow-y: auto;
}
/* 텍스트 박스 스타일 */
#selected-course {
    width: 100%;
    border: none;
    background: none;
    outline: none;
    resize: none;
    overflow: hidden;
    text-align: center;
}
/* 레이블과 텍스트 박스 정렬 */

.selected-course-wrapper {
    width: 100%;
    text-align: center;
    margin-bottom: 10px;
}
.modal-footer button {
    margin-left: auto;
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
				                            <div class="progress-bar" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">75%</div>
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
					  <thead>
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
					            <input id="Psearchbox" type="text" class="form-control" placeholder="강의명을 입력하세요." aria-label="Recipient's course" aria-describedby="button-addon2">
					            <button id="search_btn" class="btn btn-outline-dark" type="button">검색</button>
					        </div>
					    </div>
					</div>
					
					<!-- Start table -->
					<table class="table">
					  <thead>
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
			
					<!-- 페이징 시작 
					<ul class="pagination d-flex justify-content-center" id="pagination"></ul>
					페이징 끝 -->
			
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
					  <thead>
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
		<div class="modal-dialog modal-m">
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
	                	<input type="text" id="user_code" name="user_code" value="${stdDto.user_code}"/>
						<input type="text" id="course_name" name="course_name"/>					
						<button id="course_reg" class="btn btn-outline-dark" onclick="course-reg()">선택하기</button>
	                </form>
	                
				</div>
			</div>			
		</div>
	</div>

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
// 수정버튼 클릭
$('#edit_btn').click(function(){
	window.location.href = '/std/edit.go';
});

//학생 리스트 이동
$('#stdList_go').click(function(){
	window.location.href = '/std/list.go';
});


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




//Pagination 전 변수 선언
var page = 1;
var totalPage = 0;
var Psearchbox = '';
var Csearchbox='';
var user_code = '${stdDto.user_code}';

listCall(page, Psearchbox, user_code);
CourseListCall(page, Csearchbox, user_code);


/* !모든 수강이력 스크립트 시작! */
 
function openModal() {
    $('#course-modal').css('display', 'block');
    user_code = document.getElementById('user_code').value; // user_code 값 저장
    CourseModalList(); 
} 

function CloseModal() {
    $('#course-modal').css('display', 'none');
    
} 

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
			console.log(data);
			
			totalPage = data.totalPage;
			SetupPagination(page, totalPage);
			drawCourseList(data.cList);
		},
		error:function(error){
			console.log(error);
		}
	});
}
// 수강이력 리스트 그리기 시작
function drawCourseList(courseList){
	var content = '';
	console.log(courseList);
	
	for(data of courseList){
		content += '<tr>';
		content += '<td>' + data.course_name + '</td>';
		content += '<td>' + data.name + '</td>';
		content += '<td>' + data.course_start + '</td>';
		content += '<td>' + data.course_end + '</td>';
		content += '<td>' + data.pay_state + '</td>';
		content += '</tr>';
	}
	$("#courseList").html(content);
}

// 수강이력 페이징 처리

//totalPage 활용하여 Pagination 버튼 설정
function SetupPagination(page, totalPage) {
	var pagination = $('#pagination_course');
	var count = 0;
	
	pagination.empty();
	
	var content = '<li class="page-item">';
	content += '<a class="page-link" href="#">&laquo;</a>';
	content += '</li>';
	content += '<li class="page-item">';
	content += '<a class="page-link" href="#">&lsaquo;</a>';
	content += '</li>';
	
	if (page < 3) {
		for (var i = 1; i <= totalPage; i++) {
			content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
			count++;
			if (count == 5) {
				break;
			}
		}
	}else if (page >= 3 && page < (totalPage - 2)) {
		for (var i = page - 2; i <= totalPage; i++) {
			content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
			count++;
			if (count == 5) {
				break;
			}
		}
	}else if (page >= 3 && page >= (totalPage - 2)) {
		for (var i = totalPage - 4; i <= totalPage; i++) {
			if (i == 0) {
				continue;
			}
			content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
			count++;
			if (count == 5) {
				break;
			}
		}
	}
	
	content += '<li class="page-item">';
	content += '<a class="page-link" href="#">&rsaquo;</a>';
	content += '</li>';
	
	content += '<li class="page-item">';
	content += '<a class="page-link" href="#">&raquo;</a>';
	content += '</li>';
	
	pagination.html(content);
	pagination.find('.page-item').removeClass('active');
	
	$('.page-link').each(function() {
		if ($(this).html() == page) {
			$(this).parent().addClass('active');
		}
	});
	
}

//설정된 버튼에 이벤트 적용
$('#pagination_course').on('click', '.page-link', function(e) {
    e.preventDefault();
    if ($(this).html() == '«') {
        page = 1;
    } else if ($(this).html() == '‹') {
        if (page > 1) {
            page--;
        }
    } else if ($(this).html() == '›') {
        if (page < totalPage) {
            page++;
        }
    } else if ($(this).html() == '»') {
        page = totalPage;
    } else {
        page = parseInt($(this).html());
    }
    CourseListCall(page, Csearchbox, user_code);
});


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
			console.log(data);
			
			totalPage = data.totalPage;
			setupPagination(page, totalPage);
			
			drawPayList(data.list);
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
	console.log(payList);
	
	for(data of payList){
		content += '<tr>';
		content += '<td>' + data.course_name + '</td>';
		content += '<td>' + data.name + '</td>';
		content += '<td>' + data.course_price + '</td>';
		content += '<td>' + data.pay_date + '</td>';
		content += '</tr>';
	}
	$('#payList').html(content);
}
/* 결제내역 리스트 그리기 끝 */

//totalPage 활용하여 Pagination 버튼 설정
function setupPagination(page, totalPage) {
	var pagination = $('#pagination_pay');
	var count = 0;
	
	pagination.empty();
	
	var content = '<li class="page-item">';
	content += '<a class="page-link" href="#">&laquo;</a>';
	content += '</li>';
	content += '<li class="page-item">';
	content += '<a class="page-link" href="#">&lsaquo;</a>';
	content += '</li>';
	
	if (page < 3) {
		for (var i = 1; i <= totalPage; i++) {
			content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
			count++;
			if (count == 5) {
				break;
			}
		}
	}else if (page >= 3 && page < (totalPage - 2)) {
		for (var i = page - 2; i <= totalPage; i++) {
			content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
			count++;
			if (count == 5) {
				break;
			}
		}
	}else if (page >= 3 && page >= (totalPage - 2)) {
		for (var i = totalPage - 4; i <= totalPage; i++) {
			if (i == 0) {
				continue;
			}
			content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
			count++;
			if (count == 5) {
				break;
			}
		}
	}
	
	content += '<li class="page-item">';
	content += '<a class="page-link" href="#">&rsaquo;</a>';
	content += '</li>';
	
	content += '<li class="page-item">';
	content += '<a class="page-link" href="#">&raquo;</a>';
	content += '</li>';
	
	pagination.html(content);
	pagination.find('.page-item').removeClass('active');
	
	$('.page-link').each(function() {
		if ($(this).html() == page) {
			$(this).parent().addClass('active');
		}
	});
	
}

//설정된 버튼에 이벤트 적용
$('#pagination_pay').on('click', '.page-link', function(e) {
    e.preventDefault();
    if ($(this).html() == '«') {
        page = 1;
    } else if ($(this).html() == '‹') {
        if (page > 1) {
            page--;
        }
    } else if ($(this).html() == '›') {
        if (page < totalPage) {
            page++;
        }
    } else if ($(this).html() == '»') {
        page = totalPage;
    } else {
        page = parseInt($(this).html());
    }
    listCall(page, Psearchbox, user_code);
});

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
</script>
</html>