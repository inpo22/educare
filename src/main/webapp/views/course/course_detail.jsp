<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>${courseDTO[0].course_name} - 강의 관리 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<link href="/resources/course/course.css" rel="stylesheet">

<jsp:include page="/views/common/head.jsp"></jsp:include>

<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

<style>
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
				<div class="form-control reservTextareaGoIn" id="reservTextareaGo" aria-label="With textarea">
					<c:forEach items="${courseDTO}" var="course">
						<div class="reservation-itemIn mt-1"><span><fmt:formatDate value="${course.start_time}" pattern="yyyy-MM-dd HH:mm:ss" /></span></div>
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
           			<button type="button" class="btn btn-danger mt-3 mb-1" id="deleteBtn" onclick="deleteCourseGo()">삭제</button>
       			 	<button type="button" class="btn btn-primary mt-3 mb-1" id="updateBtn" onclick="updateCourseGo()">수정</button>
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
	/*console.log(course_no);*/
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