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

<title>강의 관리 - 에듀케어</title>
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
			<h1><a href="/course/list.go" class="title-cate" >강의 관리</a> > 강의 수정</h1>
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
                	<input type="text" class="form-control" name="course_name" id="course_name" value="${courseDTO[0].course_name}">
				</div>
			</div>
		</div>
		<input type="hidden" name="content" id="content" />
		 	<div class="row">
    			<div class="col-md-12">
        			<div id="editor"></div>
   		 		</div>
		 	</div>

    		<div class="row">
        		<div class="col-md-12 d-flex justify-content-end">
           			<button type="button" class="btn btn-secondary mt-3 mb-1" id="deleteBtn" onclick="cancelCourseUpdate()">취소</button>
       			 	<button type="button" class="btn btn-primary mt-3 mb-1" id="updateBtn" onclick="updateCourseSubmit()">수정완료</button>
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

const editor = toastui.Editor.factory({
	el: document.querySelector('#editor'),
	initialEditType : 'wysiwyg',
	height : '500px',
	hideModeSwitch : true,
	initialValue: content
});
editor.removeToolbarItem('code');
editor.removeToolbarItem('codeblock');

function cancelCourseUpdate(){
	var course_no = '${courseDTO[0].course_no}';
	location.href="/course/detail.go?course_no=" + course_no;
}

function updateCourseSubmit(){
	var course_no = '${courseDTO[0].course_no}';
	var courseName = $('#course_name').val();
	//console.log("course_name >> "+ course_name);
	var editorContent = editor.getHTML();
	var formatContent = $('#content').val(editorContent);
	var content = formatContent.val();
	//console.log("content >> "+ content);
	
	var paramData = {
		course_no: course_no,
		course_name: courseName,
		course_con: content
	}
	
	$.ajax({
		url:'/course/update.ajax',
		type:'POST',
		dataType:'JSON',
		data: JSON.stringify(paramData),
		contentType: 'application/json',
		success:function(data) {
			//console.log(data.result);
			if(data.result === "success" ){
				alert('수정이 완료되었습니다.');
				location.href='/course/detail.go?course_no='+course_no;
			}else{
				alert('수정에 실패하였습니다.');
			}
		},
		error:function(request, status, error){
			console.log(error);
		}
		
	}); 
}

</script>
</html>