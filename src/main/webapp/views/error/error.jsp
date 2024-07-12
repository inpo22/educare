<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>에듀 케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<jsp:include page="/views/common/head.jsp"></jsp:include>

<!-- css -->

<!-- js -->

<style>
	#main {
		margin-left: 0 !important;
	}
</style>
</head>

<body>

	<main id="main" class="main">
		<div class="container">

			<section class="section error-404 min-vh-100 d-flex flex-column align-items-center justify-content-center">
				<h1>ERROR</h1>
				<br/>
				<h2>실행 과정에서 오류가 발견되었습니다.</h2>
				<br/>
				<a class="btn" href="/">돌아가기</a>
				<img src="/resources/assets/img/not-found.svg" class="img-fluid py-5" alt="Page Not Found">
			</section>
		</div>

	</main>
	<!-- End #main -->
</body>
<script>
</script>
</html>