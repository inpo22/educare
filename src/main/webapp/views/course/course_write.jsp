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

.form-select {
	border: none;
	box-shadow: -1px 1px 6px #929297;
}

.search-btn {
	border: none;
	box-shadow: 3px 1px 6px #929297;
}

textarea {
	resize: none;
	height: 91px;
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
					<div class="col-md-6">
						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon1">강의명</span> <input
								type="text" class="form-control" name="course_name" id="title"
								placeholder="강의명을 입력해주세요.">
						</div>

						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon2">강사명</span> <input
								type="text" class="form-control" name="user_name" id="name"
								placeholder="강사명을 입력해주세요.">
						</div>

						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon3">강의료</span> <input
								type="text" class="form-control" name="course_price" id="pay"
								placeholder="강의료를 입력해주세요.">
						</div>
					</div>

					<div class="col-md-6">
						<div class="row">
							<div class="col-md-12">
								<div class="input-group input-group mb-3">
									<button class="btn btn-outline-warning w-100" type="button">강의실
										확인 및 예약하기</button>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12">
								<div class="input-group input-group mb-3">
									<textarea class="form-control" aria-label="With textarea"
										placeholder="강의실 예약시 예약정보가 출력됩니다."></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="editor"></div>
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

const editor = new toastui.Editor({
	el: document.querySelector('#editor'),
	height: '500px',
	initialEditType: 'wysiwyg',
	hideModeSwitch: true,
	initialValue:"** 이곳에 강의에 대한 상세 커리큘럼에 대해서 적어주세요.**"
});
editor.removeToolbarItem('code');
editor.removeToolbarItem('codeblock');

</script>
</html>