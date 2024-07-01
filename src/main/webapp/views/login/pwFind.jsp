<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/views/common/head.jsp"></jsp:include>
<style>
	body {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
		background-color: #f5f5f5;
	}
	.container {
		width: 600px;
		padding: 20px;
		background-color: white;
		box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
		border-radius: 10px;
	}
	.text-align-center {
		text-align: center;
	}
	.vertical-align-middle {
		vertical-align: middle;
	}
</style>
</head>
<body>
	<div class="container">
		<h3><b>비밀번호 찾기</b></h3>
		<br/>
		<form action="/login/tempPw.do" method="post">
			<table class="table table-borderless">
				<colgroup>
					<col width="30%">
					<col width="70%">
				</colgroup>
				<tr>
					<td scope="col" class="vertical-align-middle">아이디</td>
					<td scope="col"><input type="text" class="form-control" name="id" id="id"/></td>
				</tr>
				<tr>
					<td class="vertical-align-middle">이메일</td>
					<td><input type="text" class="form-control" name="email" id="email"/></td>
				</tr>
			</table>
			<br/>
			<div class="text-align-center">
				<button type="button" class="btn btn-primary" onclick="tempPw()">임시비밀번호 발급</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-secondary" onclick="goBack()">돌아가기</button>
			</div>
		</form>
	</div>
</body>
<script>
	var msg = '${msg}';
	if (msg) {
		alert(msg);
	}
	
	var verifyCheck = 0;
	
	function tempPw() {
		var $id = $('#id');
		var $email = $('#email');
		
		if ($id.val() == '') {
			alert('아이디를 입력해주세요.');
			$id.focus();
		} else if($email.val() == ''){
			alert('이메일을 입력해주세요.');
			$email.focus();
		} else {
			// 이메일 유효성 검사
			var regEmail = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
			if (regEmail.test($email.val()) == false) {
				alert("이메일 형식이 올바르지 않습니다.");
				$email.focus();
			} else {
				var result = confirm('임시비밀번호를 발급하시겠습니까?');
				if (result) {
					alert('임시비밀번호 발급이 완료되었습니다.');
					$('form').submit();
				}
			}
		}
	}
	
	function goBack() {
		location.href = '/login.go';
	}
</script>
</html>