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
	.display-flex {
		display: flex;
	}
	#left-section {
		width: 15%;
		height: 100%;
	}
	#right-section {
		width: 84%;
		height: 100%;
		background-color: white;
		padding: 30px;
	}
	.text-align-right {
		text-align: right;
	}
	.second-sidebar td {
		padding: 5px 0;
	}
	a {
		color: black;
	}
	.blue-color {
		color: rgb(88, 88, 255);
	}
	.modal {
	    display: none;
	    position: fixed;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    overflow: auto;
	    background-color: rgba(0,0,0,0.4);
	}
	.modal-content {
	    margin: 0 auto;
	    padding: 20px;
	    height: 600px;
	    width: 400px;
	    top: 150px;
	    background-color: white;
	}
	.close {
	    color: #aaa;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	}
	.close:hover {
	    color: black;
	    text-decoration: none;
	    cursor: pointer;
	}
	.modal-title {
		font-weight: bold;
		font-size: 25px;
	}
	.approval-type-list {
		height: 400px;
		width: 360px;
		overflow-y: auto;
		background-color: #f9f9f9;
		padding: 20px;
	}
	.approval-type-list ul {
		list-style-type: none;
	}
	.approval-type-list li {
		cursor: pointer;
		padding-left: 10px;
	}
	.approval-type-list li:hover {
		background-color: rgba(75, 150, 230, 0.1);
		background: #e7eff7;
	}
	.selected-value {
		background-color: rgba(75, 150, 230, 0.1);
		background: #e7eff7;
		color: #4b96e6;
	}
	.right-padding {
		padding-right: 40px;
	}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div class="display-flex">
			<div id="left-section">
				<div class="pagetitle">
					<h1>전자 결재</h1>
				</div>
				<button class="btn btn-primary btn-newApproval">새 결재 작성</button>
				<br/><br/><br/>
				<table class="second-sidebar">
					<tr>
						<td><b>결재하기</b></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/getApproval/list.go" class="blue-color"><b>결재 요청 받은 문서</b></a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/compApproval/list.go">결재 완료한 문서</a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/viewApproval/list.go">열람 가능한 문서</a></td>
					</tr>
				</table>
				<br/>
				<table class="second-sidebar">
					<tr>
						<td><b>상신한 결재</b></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/requestApproval/list.go">결재 요청한 문서</a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/finishApproval/list.go">결재 완료된 문서</a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/rejectedApproval/list.go">반려된 문서</a></td>
					</tr>
				</table>
			</div>
			<div id="right-section"></div>
		</div>
	</main>
	<!-- End #main -->
	<jsp:include page="/views/common/footer.jsp"></jsp:include>
	<jsp:include page="/views/common/newApproval_modal.jsp"></jsp:include>
	
</body>
<script>
</script>
</html>