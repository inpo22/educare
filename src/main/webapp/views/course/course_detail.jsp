<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>::EDUcare 강의등록 페이지::</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<jsp:include page="/views/common/head.jsp"></jsp:include>

<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

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

.search-btn {
	border: none;
	box-shadow: 3px 1px 6px #929297;
}

textarea {
	resize: none;
	height: 91px;
}

.reserv-textarea{
	resize: none;
	height: 280px;
	overflow: auto; 
}

.reservTextareaGo{
	resize: none;
	height: 91px;
	overflow: auto; 
	pointer-events: none;
}

.modal-body{
	padding: 0px 22px !important;
}
#calendar {
  	border-radius: 12px;
}

.cal-header {
    display: flex;
    justify-content: space-between;
    text-align: center;
    padding: 10px 5px;
    border-top-left-radius: 12px;
    border-top-right-radius: 12px;
}

.cal-header .nav-btn {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 20px;
    color: #6c757d;
}

.cal-header .nav-btn:hover {
    color: black;
}

#year-month {
    font-size: 20px;
    font-weight: 600;
    color: black;
}

.mainRow {
    display: flex;
    padding: 10px 0px;
}

.mainRow .day {
    flex: 1;
    text-align: center;
    font-weight: 600;
    color: #495057;
    text-transform: uppercase;
    font-size: 14px;
}

.days {
    display: flex;
    flex-wrap: wrap;
}

.days .day, .days .emptyDay {
    width: calc(100% / 7);
    height: 30px;
    box-sizing: border-box;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 16px;
    margin-bottom: 3px;
}

.days .day {
    cursor: pointer;
    border: 1px solid transparent; 
}

.days .day:hover {
    background-color: #FFC107;
    color: white;
    border-radius:20px;
    border: 1px solid transparent; 
}

.days .emptyDay {
    background-color: transparent;
    border: none; 
}

.input-group .btn {
    width: 70px;
}

.reservation-item {
    display: inline-block;
    margin-right: 5px;
    margin-bottom: 5px;
    padding: 3px 8px;
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    border-radius: 10px;
}

.btn-remove {
    font-size: 0.8rem;
    padding: 0.2rem 0.4rem;
    background-color: transparent;
    border: none;
    color: #333;
    width: 20px !important;
}

.btn-remove:hover {
    background-color: #ccc;
    color: #fff; 
    border-radius: 50%; 
}

.highlight {
    background-color: #545fc8 !important;
    color: white;
    border-radius: 20px;
}

.today {
    background-color: #f78686;
    color: white;
    border-radius: 20px;
}

.miniBox{
 	background-color: #545fc8;
 	font-size:8px;
    color: white;
    border-radius: 20px;
}
small{
	font-size: 10px;
}
.todayBox{
	background-color: #f78686;
 	font-size: 8px;
    color: white;
    border-radius: 20px;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div class="pagetitle">
			<h1>강의 관리 > 강의 등록</h1>
		</div>
		<!-- End Page Title -->

		<div class="row">
			<div class="d-grid gap-2 col-12 mt-3 board">
				<div class="row">
					<div class="col-md-4">
						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon1">강의번호</span> 
							<input type="text" class="form-control" name="course_no" id="course_no" value="${courseDTO[0].course_no}">
						</div>

						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon2">강의명</span> 
							<input type="text" class="form-control" name="course_name" id="course_name" value="${courseDTO[0].course_name}">
						</div>

						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon3">강의료</span> 
							<input type="text" class="form-control" name="course_price" id="course_price" value="${courseDTO[0].course_price}">
						</div>
					</div>

					<div class="col-md-4">
						<div class="row">
							<div class="col-md-12">
								<div class="input-group input-group mb-3">
									<button class="btn btn-outline-warning w-100" type="button" data-bs-toggle="modal" data-bs-target="#reservationModal">강의실 확인 및 예약하기</button>
								</div>
							</div>
						</div>
					</div>
						
						
						<div class="col-md-4">
						<div class="row">
							<div class="col-md-12">
								<div class="input-group input-group mb-3">
									<button class="btn btn-outline-warning w-100" type="button" data-bs-toggle="modal" data-bs-target="#reservationModal">강의실 확인 및 예약하기</button>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12">
								<div class="input-group input-group mb-3">
									<div class="form-control reservTextareaGo" id="reservTextareaGo" aria-label="With textarea"></div>
								</div>
							</div>
						</div>
					</div>
					
					<input type="hidden" name="content" id="content"/>
					
				</div>
				<div id="editor"></div>
					<button type="button" class="btn text-light bg-dark" id="submitButton" onclick="submitCourseWrite()">등록</button>
			</div>
		</div>

	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>

function course_wirte() {
	location.href = '/course/write.go'
}

const editor = new toastui.Editor({
	el : document.querySelector('#editor'),
	height : '500px',
	initialEditType : 'wysiwyg',
	hideModeSwitch : true,
	initialValue : "** 이곳에 강의에 대한 상세 커리큘럼에 대해서 적어주세요.**"
});
editor.removeToolbarItem('code');
editor.removeToolbarItem('codeblock');

</script>

</html>