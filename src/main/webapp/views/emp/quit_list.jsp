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
#search_btn {
	margin: 7px 5px;
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
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<div class="pagetitle">
				<h1>퇴사자 목록</h1>
			</div>
			<!-- End Page Title -->
			<br/>
			<br/>
			<br/>
			
			<div class="row">
				<div class="d-flex">
					<button id="empList_btn" type="button" class="btn btn-dark">사원 목록</button>  
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
						<button id="search_btn" class="btn btn-outline-secondary" type="button">검색</button>
					</div>
				</div>
			</div>
			
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
			      <th scope="col">퇴사일</th>			      
			    </tr>
			  </thead>
			  <tbody>
			  </tbody>
			</table>
			<!-- End table -->
			
			
		</div>
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
// 사원목록 페이지 이동
$('#empList_btn').click(function(){
	window.location.href = '/emp/list.go';
});
</script>
</html>