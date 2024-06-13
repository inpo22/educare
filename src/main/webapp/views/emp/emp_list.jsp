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
<!-- js -->

<style>
#code,#quit_btn{
	width: 100px;
	margin : 7px 0;
}
#searchbox,#datefilter_start,#datefilter_end{
	width: 250px;
	margin : 7px 0;
}
#chk,#chkAll{
	margin:3px 0;
	border: 1px solid black;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">

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
              <button type="button" class="btn btn-secondary me-2">+사원등록</button>
              <button type="button" class="btn btn-secondary">퇴사자목록</button>  
          </div>
      	</div>
      	
      	<div class="row">          
          <div class="d-flex">
              <select id="code" class="form-select" aria-label="Default select example">
                  <option selected>All</option>
                  <option value="1">부서</option>
                  <option value="2">직책</option>
                  <option value="3">직급</option>
              </select>   
              
              <div id="searchbox" class="input-group me-2 ms-2">
		      	<input type="text" class="form-control" placeholder="사원 이름" aria-label="Recipient's username" aria-describedby="button-addon2">
			  	<button class="btn btn-outline-secondary" type="button" id="button-addon2">검색</button>
			  </div>
			  
			  <div id="datefilter_start" class="input-group date">
			    <input type="text" class="form-control" id="datepicker" placeholder="시작 날짜 선택">
			    <div class="input-group-append">
			        <span class="input-group-text"><i class="bi bi-calendar"></i></span>
			    </div>
			  </div>
			  <div id="datefilter_end" class="input-group date">
			    <input type="text" class="form-control" id="datepicker" placeholder="종료 날짜 선택">
			    <div class="input-group-append">
			        <span class="input-group-text"><i class="bi bi-calendar"></i></span>
			    </div>
			  </div>
			  
			  <div id="quit_btn" class="ms-auto">
			  	<button type="button" class="btn btn-secondary">퇴사처리</button>
			  </div>
          </div>
          
          
      	</div>
		
		<!-- End 버튼 및 필터링 -->
		
		<!-- Start table -->
		<table class="table">
		  <thead>
		    <tr>
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
		
		<!-- 페이징 시작 -->
		<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    <li class="page-item">
		      <a class="page-link" href="#" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    <li class="page-item"><a class="page-link" href="#">1</a></li>
		    <li class="page-item"><a class="page-link" href="#">2</a></li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
		    <li class="page-item"><a class="page-link" href="#">4</a></li>
		    <li class="page-item"><a class="page-link" href="#">5</a></li>
		    <li class="page-item">
		      <a class="page-link" href="#" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</nav>
		<!-- 페이징 끝 -->

	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
//스크립트 영역

/* 체크박스 전체선택 스크립트 시작 */
$(function () {
	$("#chkAll").click(function(){
    	$(".form-check-input").prop("checked", this.checked); //attr : HTML 속성을 체크로 변경 / prop : 체크박스 상태를 체크 상태로 설정
    });
});
/* 체크박스 전체선택 스크립트 끝 */


/* 사원 리스트 출력 스크립트 시작 */
$.ajax({
	type:'post',
	url:'/emp/list.ajax',
	data:{
		
	},
	dataType:'json',
	success:function(data){
		console.log(data);
		drawEmpList(data.empList);
	},
	error:function(error){
		console.log(error);
	}
});

// list 그리기
function drawEmpList(empList){
	var content = '';
	console.log(empList);
	
	for(data of empList){
		content += '<tr>';
		content += '<td>' + data.user_code + '</td>';
		content += '<td>' + data.name + '</td>';
		content += '<td>' + data.team_name + '</td>';
		content += '<td>' + data.class_name + '</td>';
		content += '<td>' + data.position_name + '</td>';
		content += '<td>' + data.reg_date + '</td>';
		content += '<td><input class="form-check-input" type="checkbox" id="chk"></td>';
		content += '</tr>';
	}
	$('#empList').html(content);
}



</script>
</html>