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
		width: 800px;
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
	.btn-verify {
		width: 130px;
		text-align: center;
	}
	.display-none {
		display: none;
	}
</style>
</head>
<body>
	<div class="container">
		<h3><b>비밀번호 찾기</b></h3>
		<br/>
		<table class="table table-borderless">
			<colgroup>
				<col width="20%">
				<col width="60%">
				<col width="20%">
			</colgroup>
			<tr>
				<td scope="col" class="vertical-align-middle">아이디</td>
				<td scope="col"><input type="text" class="form-control" id="id"/></td>
				<td scope="col"></td>
			</tr>
			<tr>
				<td class="vertical-align-middle">이메일</td>
				<td><input type="text" class="form-control" id="email"/></td>
				<td>
					<button class="btn btn-primary btn-verify" onclick="sendEmail()">인증메일 발송</button>
					<button class="btn btn-secondary btn-verify display-none" onclick="sendEmail()">다시 받기</button>
				</td>
			</tr>
			<tr>
				<td class="vertical-align-middle">인증번호</td>
				<td><input type="text" class="form-control" id="verifyCode"/></td>
				<td><button class="btn btn-primary btn-verify display-none" onclick="verifyMail()">인증하기</button></td>
			</tr>
		</table>
		<br/>
		<div class="text-align-center">
			<button class="btn btn-primary" onclick="resetPw()">다음</button>
			&nbsp;&nbsp;
			<button class="btn btn-secondary" onclick="goBack()">돌아가기</button>
		</div>
	</div>
</body>
<script>
	var msg = '${msg}';
	if (msg) {
		alert(msg);
	}
	
	var verifyCheck = 0;
	
	function sendEmail() {
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
				$(this).addClass('display-none');
				$('.display-none').removeClass('display-none');
				
				$.ajax ({
					type:'post',
					url:'/login/sendVerifyMail.ajax',
					data:{
						'id':$id.val(),
						'email':$email.val()
					},
					dataType:'json',
					success:function(data) {
						if (data.result == 0) {
							alert('입력하신 내용의 회원 정보를 찾을 수 없습니다.');
						} else if (data.result == 1) {
							console.log('email 전송에 실패했습니다.');
						}
					},
					error:function(e) {
						console.log(e);
					}
				});
			}
		}
	}
	
	function verifyMail() {
		var verifyCode = $('#verifyCode').val();
		
		$.ajax ({
			type:'post',
			url:'/login/verifyCode.ajax',
			data:{
				'code':verifyCode
			},
			dataType:'json',
			success:function(data) {
				if (data.result == 0) {
					alert('입력하신 인증번호가 일치하지 않습니다.');
				} else if (data.result == 1) {
					alert('이메일 인증이 완료되었습니다.');
					verifyCheck = 1;
				}
			},
			error:function(e) {
				console.log(e);
			}
		});
	}
	
	function resetPw() {
		if (verifyCheck == 1) {
			location.href = '/login/pwReset.go?id=' + $('#id').val();
	}
	
	function goBack() {
		location.href = '/login.go';
	}
</script>
</html>