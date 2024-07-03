<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>사원 목록</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<jsp:include page="/views/common/head.jsp"></jsp:include>
<link href="/resources/emp/emp.css" rel="stylesheet">

<!-- js -->
<script src="/resources/js/pagination_module.js" type="text/javascript"></script>

<style>
#type,#del{
	width: 100px;
	margin : 7px 0 7px 10px;
}
#searchbox,#date,#date{
	width: 250px;
	margin : 7px 0;
}
#search_btn,#reset_btn
{
	margin : 7px 5px;
}	
.chk,#chkAll{
	margin:3px 0;
	border: 1px solid black;
}
#empReg_btn,#quitList_btn{
	margin : 7px 0 7px 10px;
}
.pagetitle{
	margin:0 10px;
}
#inputdate,#searchdate_btn{
	margin:7px 0;
}
#quit_btn{
	margin-right: 10px;
}
.bi.bi-arrow-clockwise{
	font-size: 24px;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard"><br/>
			<div class="pagetitle">
				<h1>사원 목록</h1>
			</div>
			
			<!-- End Page Title -->
			
			<br/>
			<br/>
			<br/>
			
			<!-- Start 버튼 및 필터링 -->
			
			<div class="row">          
	          <div class="d-flex">
	              <button id="empReg_btn" type="button" class="btn btn-dark me-2">+사원등록</button>
	              <button id="quitList_btn" type="button" class="btn btn-dark">퇴사자목록</button>  
	          </div>
	      	</div>
	      	
	      	<div class="row">          
	          <div class="d-flex">
	              <select id="type" class="form-select" aria-label="Default select example">
	                  <option value="team">부서</option>
	                  <option value="class">직책</option>
	                  <option value="position">직급</option>
	                  <option value="name">이름</option>
	              </select>   
			      <input id="searchbox" type="text" class="form-control" placeholder="검색어를 입력하세요." aria-label="Recipient's username" aria-describedby="button-addon2">
				  <button id="search_btn" class="btn btn-outline-dark" type="button">검색</button>
				  
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
				  <button id="reset_btn" class="btn btn-outline-dark" type="button"><i class="bi bi-arrow-clockwise"></i></button>
				  
				  <div id="del" class="ms-auto">
				  	<button id="quit_btn" type="button" class="btn btn-dark" onclick="quit()">퇴사처리</button>																  
				  </div>
	          </div>  
	      	</div>
			
			<!-- End 버튼 및 필터링 -->
			
			<!-- Start table -->
			<table class="table">
			  <thead>
			    <tr class="table-active">
			      <th scope="col">사원번호</th>
			      <th scope="col">이름</th>
			      <th scope="col">부서</th>
			      <th scope="col">직책</th>
			      <th scope="col">직급</th>
			      <th scope="col">입사일</th>
			      <th><input class="form-check-input" type="checkbox" value="" id="chkAll"></th>
			      
			    </tr>
			  </thead>
			  <tbody id="empList">
			  </tbody>
			</table>
			<!-- End table -->
			
			<br/>
			 <p>사원 수 : 총  ${empCnt}명</p>
			
			<!-- 페이징 시작 -->
			<ul class="pagination d-flex justify-content-center" id="pagination"></ul>
			<!-- 페이징 끝 -->
		</div>
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
//스크립트 영역

/* 체크박스 전체선택 스크립트 시작 */
$(function () {
	// 전체 선택 체크박스를 클릭했을 때 이벤트 처리
	$("#chkAll").click(function(){
		// .form-check-input 클래스를 가진 모든 체크박스의 상태를 #chkAll 체크박스의 상태와 동일하게 설정
    	$(".chk").prop("checked", this.checked); //attr : HTML 속성을 체크로 변경 / prop : 체크박스 상태를 체크 상태로 설정
    });
});
/* 체크박스 전체선택 스크립트 끝 */


/* 사원 리스트 출력 스크립트 시작 */
// Pagination 전 변수 선언
var page = 1;
var totalPage = 0;
var type = '';
var searchbox = '';
var startDate = '';
var endDate = '';

listCall(page, type, searchbox, startDate, endDate);

function listCall(page, type, searchbox, startDate, endDate){
	$.ajax({
		type:'post',
		url:'/emp/list.ajax',
		data:{
			'page':page,
			'type':type,
			'searchbox':searchbox,
			'startDate':startDate,
			'endDate':endDate
		},
		dataType:'json',
		success:function(data){
			//console.log(data);
			totalPage = data.totalPage;
			drawEmpList(data.list);
			
			var option = {
				totalPages: totalPage,
				startPage: page
			};
			window.pagination.init($('#pagination'), option, function(currentPage) {
				page = currentPage;
				listCall(page, type, searchbox, startDate, endDate);
			});
			
		},
		error:function(error){
			console.log(error);
		}
	});
}


// list 그리기
function drawEmpList(empList){
	var content = '';
	console.log(empList);
	
	for(data of empList){
		content += '<tr>';
		content += '<td><a href="/emp/detail.go?user_code='+ data.user_code +'">' + data.user_code + '</td>';
		content += '<td>' + data.name + '</td>';
		content += '<td>' + data.team_name + '</td>';
		content += '<td>' + data.class_name + '</td>';
		content += '<td>' + data.position_name + '</td>';
		content += '<td>' + data.reg_date + '</td>';
		content += '<td><input class="form-check-input chk" type="checkbox" value="' + data.user_code + '"></td>';
		content += '</tr>';
	}
	$('#empList').html(content);
}

// 필터링 검색 버튼 함수
$('#search_btn').click(function(){
	type = $('#type').val();
	searchbox = $('#searchbox').val();
	if(searchbox == ''){
		alert("검색어를 입력해주세요.");
		return;
	}
	listCall(page, type, searchbox, startDate, endDate);
});

// 날짜 검색 버튼 함수
$('#searchdate_btn').click(function(){
	startDate = $('#startDate').val();
	endDate = $('#endDate').val();
	if(startDate == '' && endDate == ''){
		alert("날짜를 선택해주세요.");
		return;
	}else if(startDate > endDate){
		alert("날짜를 확인해주세요.");
		return;
	}
	listCall(page, type, searchbox, startDate, endDate);
});

// 사원등록페이지 이동버튼
$('#empReg_btn').click(function(){
	window.location.href = '/emp/regform.go';
});

// 퇴사자목록 페이지 이동버튼
$('#quitList_btn').click(function(){
	window.location.href = '/emp/quitList.go';
});

// 퇴사 처리 함수
function quit(){
	var quitArr = [];
	
	$('.chk:checked').each(function(idx, item) {
        quitArr.push($(this).val());
    });
	
	if(quitArr.length > 0){
		var del = confirm(quitArr.length+'명의 사원을 퇴사처리하시겠습니까?');
		if(del){
			$.ajax({
				type:'post',
				url:'/emp/quit.ajax',
				data:{
					quitList:quitArr
				},
				dataType:'json',
				success:function(data){
					console.log(data);
					if(data.cnt>0){
						alert(data.cnt+'명의 사원이 퇴사처리되었습니다.');
					}
					//$('#empList').empty();
					listCall(page, type, searchbox, startDate, endDate);
				},
				error:function(error){
					console.log(error);
				}
			});
		}
	}
}

//리셋버튼 함수
$('#reset_btn').click(function(){
	$('#searchbox').val('');
	$('#startDate').val('');
	$('#endDate').val('');
	searchbox='';
	startDate='';
	endDate='';
	listCall(page, type, searchbox, startDate, endDate);
});

</script>
</html>