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

#viewer {
	min-height: 400px;
    border: 1px solid #bababa;
    border-radius: 8px;
    padding: 8px 25px;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div class="pagetitle">
			<h1>강의 관리 > 강의 상세정보</h1>
		</div>
		<!-- End Page Title -->
		<div class="row">
			<div class="d-grid gap-2 col-12 mt-3 board">
				<div class="row">
					<div class="col-md-4">
						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon1">강의실</span> 
							<input type="text" class="form-control" name="course_space" id="course_space" value="${courseDTO[0].course_space}" disabled>
						</div>
						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon3">강사명</span> 
							<input type="text" class="form-control" name="name" id="name" value="${courseDTO[0].name}" disabled>
						</div>
						<div class="input-group input-group">
							<span class="input-group-text" id="basic-addon2">강의명</span> 
							<input type="text" class="form-control" name="course_name" id="course_name" value="${courseDTO[0].course_name}">
						</div>
					</div>

					<div class="col-md-4">
						<div class="row">
							<div class="input-group input-group mb-3">
								<span class="input-group-text" id="basic-addon1">강의시작일</span> 
								<input type="text" class="form-control" name="course_start" id="course_start" value="${formatStart}" disabled>
							</div>
							<div class="input-group input-group">
								<span class="input-group-text" id="basic-addon1">강의종료일</span> 
								<input type="text" class="form-control" name="course_end" id="course_end" value="${courseDTO[0].course_end}" disabled>
							</div>
						</div>
					</div>

					<div class="col-md-4">
						<div class="row">
							<div class="input-group input-group mb-3">
								<span class="input-group-text" id="basic-addon1">강의번호</span> 
								<input type="text" class="form-control" name="course_no" id="course_no" value="${courseDTO[0].course_no}" disabled>
							</div>
							<div class="input-group input-group">
								<div class="input-group input-group mb-3">
									<div class="form-control reservTextareaGo" id="reservTextareaGo" aria-label="With textarea"></div>
								</div>
							</div>
						</div>
					</div>
					<input type="hidden" name="content" id="content" />
				</div>
				<div id="viewer"></div>
				<button type="button" class="btn text-light bg-dark mt-3 mb-2" id="submitButton" onclick="submitCourseWrite()">등록</button>
			</div>
		</div>
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
var startCourse = '${courseDTO[0].course_start}';
var endCourse = '${courseDTO[0].course_end}';

// 날짜 문자열을 Date 객체로 변환 (주의: 원래 문자열이 올바른 ISO 형식이 아닌 경우)
var startDate = new Date(startCourse);
var endDate = new Date(endCourse);

// Date 객체에서 필요한 정보 추출
var startYear = startDate.getFullYear();
var startMonth = ('0' + (startDate.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1 필요
var startDay = ('0' + startDate.getDate()).slice(-2);
var startHours = ('0' + startDate.getHours()).slice(-2);
var startMinutes = ('0' + startDate.getMinutes()).slice(-2);

var endYear = endDate.getFullYear();
var endMonth = ('0' + (endDate.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1 필요
var endDay = ('0' + endDate.getDate()).slice(-2);
var endHours = ('0' + endDate.getHours()).slice(-2);
var endMinutes = ('0' + endDate.getMinutes()).slice(-2);

// 원하는 포맷으로 날짜와 시간을 조합
var formattedStartDate = `${startYear}-${startMonth}-${startDay} ${startHours}:${startMinutes}`;
var formattedEndDate = `${endYear}-${endMonth}-${endDay} ${endHours}:${endMinutes}`;

console.log(startYear); // 시작 날짜 출력 예: 2024-07-17 18:00
console.log(formattedEndDate); 


var content = '${courseDTO[0].course_con}'
const viewer = toastui.Editor.factory({
	el: document.querySelector('#viewer'),
	viewer: true,
	initialValue: content
});



</script>

</html>