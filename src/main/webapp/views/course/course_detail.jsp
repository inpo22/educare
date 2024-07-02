<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>::EDUcare 강의상세 페이지::</title>
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
	background-color: #e9ecef;
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
    background-color: #d5d5d5;
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
	min-height: 500px;
    border: 1px solid #dfe1e5;
    border-radius: 8px;
    padding: 8px 25px;
    background-color: #eaecef;
}

#deleteBtn{
	margin-right: 10px;
}

.title-cate{
	color:#012970;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div class="pagetitle">
			<h1><a href="/course/list.go" class="title-cate" >강의 관리</a> > 강의 상세정보</h1>
		</div>
		<!-- End Page Title -->
	<div class="board mt-4">
		<div class="row">
		
			<div class="col-md-4">
				<div class="input-group input-group mb-3">
					<span class="input-group-text">강의번호</span> 
					<input type="text" class="form-control" name="course_no" id="course_no" value="${courseDTO[0].course_no}" disabled>
				</div>
				<div class="input-group input-group mb-3">
					<span class="input-group-text">강의실</span> 
					<input type="text" class="form-control" name="course_space" id="course_space" value="${courseDTO[0].course_space}" disabled>
				</div>
				<div class="input-group input-group mb-3">
					<span class="input-group-text">강사명</span> 
					<input type="text" class="form-control" name="name" id="name" value="${courseDTO[0].name}" disabled>
				</div>
			</div>
				
			<div class="col-md-8">	
				<div class="row mb-3">
                	<div class="col-md-6">
						<div class="input-group input-group">
							<span class="input-group-text">강의시작일</span> 
							<input type="text" class="form-control" name="course_start" id="course_start" value="<fmt:formatDate value="${courseDTO[0].course_start}" pattern="yyyy-MM-dd"/>" disabled>
						</div>
					</div>
					 <div class="col-md-6">
						<div class="input-group input-group">
							<span class="input-group-text">강의종료일</span> 
							<input type="text" class="form-control" name="course_end" id="course_end" value="<fmt:formatDate value="${courseDTO[0].course_end}" pattern="yyyy-MM-dd"/>" disabled>
						</div>
					</div>
				</div>
				<div class="form-control reservTextareaGo" id="reservTextareaGo" aria-label="With textarea">
					<c:forEach items="${courseDTO}" var="course">
						<div class="reservation-item mt-1"><span><fmt:formatDate value="${course.start_time}" pattern="yyyy-MM-dd HH:mm:ss" /></span></div>
					</c:forEach>
				</div>
			</div>
			
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="input-group input-group mb-3">
					<span class="input-group-text">강의명</span>
                	<input type="text" class="form-control" name="course_name" id="course_name" value="${courseDTO[0].course_name}" disabled>
				</div>
			</div>
		</div>
		<input type="hidden" name="content" id="content" />
		 	<div class="row">
    			<div class="col-md-12">
        			<div id="viewer"></div>
   		 		</div>
		 	</div>

    		<div class="row">
        		<div class="col-md-12 d-flex justify-content-end">
           			<button type="button" class="btn btn-dark mt-3 mb-1" id="deleteBtn" onclick="deleteCourseGo()">삭제하기</button>
       			 	<button type="button" class="btn btn-dark mt-3 mb-1" id="updateBtn" onclick="updateCourseGo()">수정하기</button>
       			</div>
    		</div>
	</div>
	
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
var msg = '${msg}';
if (msg !== '') {
    alert(msg);
}

var content = '${courseDTO[0].course_con}'

const viewer = toastui.Editor.factory({
	el: document.querySelector('#viewer'),
	viewer: true,
	initialValue: content
});

function deleteCourseGo(){
	var course_no = '${courseDTO[0].course_no}';
	console.log(course_no);
	if(confirm('정말삭제하시겠습니까?')){
		location.href="/course/delete.go?course_no=" + course_no;
		alert('삭제되었습니다.');
	}else{
		return;
	}
	
}
 
function updateCourseGo(){
	var course_no = '${courseDTO[0].course_no}'; 
	location.href="/course/update.go?course_no="+course_no;
	
}

</script>
</html>