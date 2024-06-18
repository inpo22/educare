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
.pln_btn {
	height: 54px;
}

.board {
	background-color: white;
	padding: 15px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.card-header {
	font-weight: bold;
}

.form-select{
	border: none;
    box-shadow: -1px 1px 6px #929297;
}

.form-control{
	border: none;
    box-shadow: 1px 1px 6px #929297;
}

.search-btn {
    border: none;
    box-shadow: 3px 1px 6px #929297;
}

.input-group-text{
	border:none;
}

.form-check-input:checked {
    background-color: #000000;
    border-color: #000000;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>강의 관리</h1>
		</div>
		<!-- End Page Title -->
		<div class="row">
			<div class="col-2 rounded-5 p-3">
			<button class="btn btn-dark border-secondary pln_btn w-100" data-bs-toggle="modal" id="write_btn" onclick="course_wirte()">+ 강의 등록</button>
			<!-- End Schedule Button -->
				<div class="input-group mt-4">
					<div class="input-group-text">
						<div class="form-check form-switch" id="showYn">
							<input class="form-check-input" type="checkbox" id="showOnlytPreCourse" checked="">
						</div>
							<label class="form-check-label" for="showOnlytPreCourse">현재 진행중인 강의만 보기</label>
					</div>
				</div>
			</div>
			<!-- End Schedule filter -->
			<div class="d-grid gap-2 col-10 mt-3 board h-100">
			
			<!-- 검색 -->
				<div class="input-group mb-3 w-25">
					<select class="form-select text-secondary" aria-label="Default select example">
						<option selected>검색필터</option>
						<option value="1">강사명</option>
						<option value="2">강의명</option>
						<option value="3">강의실</option>
					</select> 
					<input type="text" class="form-control w-25" aria-label="Text input with dropdown button">
					<button class="btn form-control btn-outline-secondary w-10 search-btn" type="button"><i class="bi bi-search"></i></button>
				</div>

				<table class="table table-hover">
					<thead>
						<tr class="table-active">
							<th scope="col">강사</th>
							<th scope="col">강의명</th>
							<th scope="col">강의실</th>
							<th scope="col">강의시작일</th>
							<th scope="col">강의종료일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Mark</td>
							<td>중1 중간고사대비용 예습반</td>
							<td>A101</td>
							<td>2024-05-05</td>
							<td>2024-06-06</td>
						</tr>
						<tr>
							<td>Mark</td>
							<td>중1 중간고사대비용 예습반</td>
							<td>A101</td>
							<td>2024-05-05</td>
							<td>2024-06-06</td>
						</tr>
						<tr>
							<td>Mark</td>
							<td>중1 중간고사대비용 예습반</td>
							<td>A101</td>
							<td>2024-05-05</td>
							<td>2024-06-06</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>

function course_wirte(){
	location.href='/course/write.go'
}
</script>
</html>