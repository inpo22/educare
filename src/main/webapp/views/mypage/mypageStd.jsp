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
<link href="/resources/mypage/stdStyle.css" rel="stylesheet">
<!-- js -->
<!-- 포트원 결제 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

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
#Psearch_btn,#reset_btn,#Csearch_btn,#Creset_btn,#Areset_btn,#Asearch_btn
{
	margin : 7px 5px;
}
/* #pay_btn, img{
	width:46px;
	height:31px;
	margin-right: 7px;
} */
.btn-kakaopay img {
    width: 40px;  /* 이미지 너비를 줄입니다 */
    height: 21px; /* 이미지 높이를 줄입니다 */
    margin-right: 2px;
}
.btn-tosspay img {
    width: 70px;  /* 이미지 너비를 줄입니다 */
    height: 21px; /* 이미지 높이를 줄입니다 */
    margin-right: 2px;
}

</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<div class="pagetitle">
				<h1>마이페이지</h1>
			</div>
			<!-- End Page Title -->
			
			<div id="detailBoard">
				<div class="std-profile row">
				    <div class="col-md-3">
				        <c:choose>
				            <c:when test="${not empty mypageDto.photo}">
				                <img src="/photo/${mypageDto.photo}" class="img-fluid">
				            </c:when>
				            <c:otherwise>
				                <!-- 기본 프로필 사진 또는 다른 대체 이미지 -->
				                <i class="bi bi-person-fill"></i>
				            </c:otherwise>
				        </c:choose>
				        <div class="col-md-6">
		                    <div class="info-group mt-2">
		                        <input type="text" value="${mypageDto.name}" id="name" name="name" class="form-control" readonly>
		                    </div>
		                </div>
				    </div>
				    <div class="col-md-8">
				        <div class="std-info">
				            <div class="row">
				                <div class="col-md-6">
				                    <div class="info-group">
				                        <p><strong>학생번호:</strong></p>
				                        <input type="text" value="${mypageDto.user_code}" id="user_code" name="user_code" class="form-control custom-input" readonly>
				                    </div>
				                    <div class="info-group">
				                        <p><strong>이메일:</strong></p>
				                        <input type="text" value="${mypageDto.email}" id="email" name="email" class="form-control" readonly>
				                    </div>
				                    <div class="info-group">
				                        <p><strong>등록일:</strong></p>
				                        <input type="text" value="${mypageDto.reg_date}" id="reg_date" name="reg_date" class="form-control" readonly>
				                    </div>
				                </div>
				                <div class="col-md-6">
				                    <div class="info-group">
				                        <p><strong>아이디:</strong></p>
				                        <input type="text" value="${mypageDto.id}" id="id" name="id" class="form-control" readonly>
				                    </div>
				                    <div class="info-group">
				                        <p><strong>연락처:</strong></p>
				                        <input type="text" value="${mypageDto.phone}" id="phone" name="phone" class="form-control" readonly>
				                    </div>
				                    <div class="info-group">
				                        <p><strong>생년월일:</strong></p>
				                        <input type="text" value="${mypageDto.birth}" id="birth" name="birth" class="form-control" readonly>
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
			    	<form action="/mypageStd/update.go" method='get'>
			    		<input type="hidden" name="user_code" value="${mypageDto.user_code}">
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

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>

var msg = '${msg}'; // 쿼터 빠지면 넣은 문구가 변수로 인식됨.
if(msg != ''){
	alert(msg);
}

//성실도(출석률)
$(document).ready(function(){
	var user_code=$('#user_code').val();
	
	$.ajax({
		type:'get',
		url:'/mypage/attRate.ajax',
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
var type = -1;
var page = 1;
var totalPage = 0;
var Psearchbox = '';
var Csearchbox='';
var Asearchbox='';
var user_code = '${mypageDto.user_code}';

CourseListCall(page, Csearchbox, user_code);


/* !모든 수강이력 스크립트 시작! */

//수강이력 리스트 뿌리기 시작 
function CourseListCall(page, Csearchbox, user_code){
	$.ajax({
		type:'post',
		url:'/mypage/std_detail_course.ajax',
		data:{
			'page':page,
			'Csearchbox':Csearchbox,
			'user_code':user_code
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			
			type = 0;
			
			totalPage = data.totalPage;
			setupPagination(page, totalPage,type);
			drawCourseList(data.cList);
		},
		error:function(error){
			console.log(error);
		}
	});
}
//수강이력 리스트 그리기 시작
function drawCourseList(courseList){
	var content = '';
	
	if(courseList.length == 0){
		content = '<tr><td colspan ="5" class="no-course">등록된 강의가 없습니다.</td></tr>';
	}else{
		console.log(courseList);
		
		for(data of courseList){
			content += '<tr>';
			content += '<td>' + data.course_name + '</td>';
			content += '<td>' + data.name + '</td>';
			content += '<td>' + data.course_start + '</td>';
			content += '<td>' + data.course_end + '</td>';
			if(data.pay_state == 0) {
				content += '<td>';
				content += '<button id="pay_btn" class="btn btn-kakaopay" onclick="kakaopay(\'' + data.course_no + '\', \'' + data.course_name + '\', \'' + data.course_price + '\')">';
                content += '<img src="/resources/img/kakaopay.png"></button>';
                content += '<button id="pay_btn" class="btn btn-tosspay" onclick="tosspay(\'' + data.course_no + '\', \'' + data.course_name + '\', \'' + data.course_price + '\')">';
                content += '<img src="/resources/img/logo-toss-pay.png"></button>';                
                content += '<button id="cancel_btn" class="btn btn-info btn-sm" onclick="cancel(\'' + data.course_name + '\')">취소</button>';
	            content += '</td>';
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

// 결제하기버튼
function kakaopay(course_no, course_name, course_price){
	var name = '${mypageDto.name}';
	var user_code = '${mypageDto.user_code}';
	
	kakaopayment(course_no,course_name,course_price,name,user_code);
}

function tosspay(course_no, course_name, course_price){
	var name = '${mypageDto.name}';
	var user_code = '${mypageDto.user_code}';
	
	tosspayment(course_no,course_name,course_price,name,user_code);
}

// 결제 함수
function kakaopayment(course_no,course_name,course_price,name,user_code){
	var IMP = window.IMP; // 생략가능
    IMP.init('imp22121407'); // <-- 본인 가맹점 식별코드 삽입
    
    IMP.request_pay({
        pg: "kakaopay",
        pay_method: "card",
        merchant_uid: 'merchant_' + new Date().getTime(),
        name: course_name,
        course_no: course_no,
        amount: course_price,
        buyer_name: name
    }, function (rsp) {
        console.log(rsp);

        if (rsp.success) {
            var msg = '결제가 완료되었습니다.';
            msg += '결제금액:' + course_price;
            $.ajax({
                type: 'POST',
                url: '/pay/payment.ajax',
                data: {
                    'course_no': course_no,
                    'amount': course_price,
                    'name': rsp.name,
                    'user_code': user_code,
                    'merchant_uid': rsp.merchant_uid
                },
                success: function (data) {
                    alert(data.msg);
                    location.href="/mypageStd.go?user_code="+user_code;
                },
                error: function (error) {
                    alert('결제 정보를 저장하는 중 오류가 발생했습니다.');
                }
            });
        } else {
            var msg = "결제에 실패했습니다. 에러 내용: " + rsp.error_msg;
            alert(msg);
        }
    });
}

function tosspayment(course_no,course_name,course_price,name,user_code){
	var IMP = window.IMP; // 생략가능
    IMP.init('imp22121407'); // <-- 본인 가맹점 식별코드 삽입
    
    IMP.request_pay({
        pg: "tosspay",
        pay_method: "card",
        merchant_uid: 'merchant_' + new Date().getTime(),
        name: course_name,
        course_no: course_no,
        amount: course_price,
        buyer_name: name
    }, function (rsp) {
        console.log(rsp);

        if (rsp.success) {
            var msg = '결제가 완료되었습니다.';
            msg += '결제금액:' + course_price;
            $.ajax({
                type: 'POST',
                url: '/pay/payment.ajax',
                data: {
                    'course_no': course_no,
                    'amount': course_price,
                    'name': rsp.name,
                    'user_code': user_code,
                    'merchant_uid': rsp.merchant_uid
                },
                success: function (data) {
                    alert(data.msg);
                    location.href="/mypageStd.go?user_code="+user_code;
                },
                error: function (error) {
                    alert('결제 정보를 저장하는 중 오류가 발생했습니다.');
                }
            });
        } else {
            var msg = "결제에 실패했습니다. 에러 내용: " + rsp.error_msg;
            alert(msg);
        }
    });
}


// 결제취소버튼
function cancel(course_name) {
	var user_code = '${mypageDto.user_code}';
    location.href = '/mypage/pay-cancel.do?course_name=' + course_name + '&user_code=' + user_code;
    CourseListCall(page, Csearchbox, user_code);
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

/* !모든 출석현황 스크립트 시작! */

// 출석현황 리스트 뿌리기 시작
function attdListCall(page, Asearchbox, user_code){
	$.ajax({
		type:'post',
		url:'/mypage/std_detail_attd.ajax',
		data:{
			'page':page,
			'Asearchbox':Asearchbox,
			'user_code':user_code
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			
			type = 1;
			
			totalPage = data.totalPage;
			setupPagination(page, totalPage,type);			
			drawAttdList(data.aList);
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
			if(data.att_state == 1){
				content += '<td class = "attd_success">출석</td>';
			}else if(data.att_state == 2){
				content += '<td class="attd_fail">결석</td>';
			}
			content += '</tr>';
		}
	}	
	$('#attdList').html(content);
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

// 리셋버튼 함수
$('#Areset_btn').click(function(){
	$('#Asearchbox').val('');	
	Asearchbox = '';
	attdListCall(page, Asearchbox, user_code);
});

/* !모든 출석현황 스크립트 끝! */

/* -------------------------------------------------------------------------------------- */


/* !모든 결제내역 스크립트 시작! */

/* 결제내역 리스트 뿌리기 시작 */
function listCall(page, Psearchbox, user_code){
	$.ajax({
		type:'post',
		url:'/mypage/std_detail_pay.ajax',
		data:{
			'page':page,
			'Psearchbox':Psearchbox,
			'user_code':user_code
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			
			type=2;
			
			totalPage = data.totalPage;
			setupPagination(page, totalPage,type);			
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

//totalPage 활용하여 Pagination 버튼 설정
function setupPagination(page, totalPage,type) {
	var count = 0;
	var pagination;
	
	if(type == 0){
		pagination = $('#pagination_course');
	}else if(type == 1){
		pagination = $('#pagination_attd');
	}else if(type == 2){
		pagination = $('#pagination_pay');
	}
	
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
			if (i < 1) {
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

//페이징 버튼 클릭 이벤트 설정
$('.pagination').on('click', '.page-link', function(e) {
    e.preventDefault();
    var clickedPage = $(this).html();
    if (clickedPage == '«') {
        page = 1;
    } else if (clickedPage == '‹') {
        if (page > 1) {
            page--;
        }
    } else if (clickedPage == '›') {
        if (page < totalPage) {
            page++;
        }
    } else if (clickedPage == '»') {
        page = totalPage;
    } else {
        page = parseInt(clickedPage);
    }
    if (type == 0) {
        CourseListCall(page, Csearchbox, user_code);
    } else if (type == 1) {
        attdListCall(page, Asearchbox, user_code);
    } else if (type == 2) {
        listCall(page, Psearchbox, user_code);
    }
});

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