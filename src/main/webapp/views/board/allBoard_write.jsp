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
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css"/>
<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<style>
#backBoard{
	background-color: white;
	width: 100%;
    height: 80%; /* 높이를 원하는 크기로 설정 */
	border-radius: 20px;
}

#allBoardTitle{
	margin-left: 20px;
}

#fixedYn {
	float: right;
	margin-right: 30px;
	font-weight: bold;
}

#writeForm {
	margin-top: 30px;
	font-size: 20px;
	font-weight: bold;
}

.writeLabel{
	margin-left: 20px;
}

#titleText {
	float:right;
	margin-right: 30px;	
	width: 50%;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>

	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<div class="pagetitle">
				<h1 id="allBoardTitle">전사 공지글 작성</h1>
			</div>
			<br/>
			<div class="form-check form-switch" id="fixedYn">
				<input class="form-check-input" type="checkbox" id="flexSwitchCheckChecked" checked="">
				<label class="form-check-label" for="flexSwitchCheckChecked">상단 고정 여부</label>
			</div>
			<br/><br/>
			<form action="/allBoard/write.do" method="post" id="writeForm">
				<label class="writeLabel">제목</label>
				<input type="text" id="titleText" name="title" maxlength="30">
			</form>
		</div>
		<!-- End Page Title -->
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
</script>
</html>