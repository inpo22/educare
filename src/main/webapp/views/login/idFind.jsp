<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>:: EduCare - 아이디 찾기 ::</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	rel="stylesheet">
<style>
/*body를 쓴 이유: 페이지 전체중간 정렬을 및 배경색 지정을 위해 */
body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background-color: #f5f5f5;
}

.find-id-container {
	width: 400px;
	padding: 20px;
	background-color: white;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.find-id-container img {
	display: block;
	margin: 0 auto 20px;
}

.form-group {
	position: relative;
	margin-bottom: 20px;
	width: 100%;
}

.form-group label {
	font-weight: bold;
}

.form-group input {
	width: 100%;
	padding: 10px;
	box-sizing: border-box;
	border: 1px solid #ced4da;
	border-radius: 4px;
}

.btn-group {
	display: flex;
	justify-content: space-between;
	width: 100%;
}

.btn-group .btn {
	width: 48%;
}

.modal {
	display: none; 
	position: fixed; 
	z-index: 1; 
	left: 0;
	top: 0;
	width: 100%;
	height: 100%; 
	overflow: auto; 
	background-color: rgb(0,0,0);
	background-color: rgba(0,0,0,0.4); 
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto; 
	padding: 20px;
	border: 1px solid #888;
	width: 80%; 
	max-width: 500px; 
}

.close-button {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close-button:hover,
.close-button:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}
</style>
</head>
<body>
    <div class="find-id-container">
        <img src="/resources/img/EDUcare_logo.png" alt="EduCare Logo" class="img-fluid">
        <h3 class="text-center">아이디 찾기</h3>
        <p class="text-center">회원정보에 등록한 이름, 이메일로 찾기</p>
        <form id="findIdForm">
            <div class="form-group">
                <label for="name"><span style="color: red;">&#9679;</span> 이름</label>
                <input type="text" id="name" name="name" placeholder="이름" required>
            </div>
            <div class="form-group">
                <label for="email"><span style="color: red;">&#9679;</span> 이메일</label>
                <input type="email" id="email" name="email" placeholder="이메일" required>
            </div>
            <div class="btn-group">
                <button type="button" class="btn btn-secondary" onclick="cancelVerification()">취소</button>
                <button type="submit" class="btn btn-primary">다음</button>
            </div>
        </form>
    </div>
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close-button" onclick="closeModal()">&times;</span>
            <h3 class="title">아이디 찾기창</h3>
            <div class="box">
                <p id="foundIdMessage" class="found-id-message"></p>
            </div>
            <input type="button" id="loginButton" class="submit" value="로그인하러가기" onclick="redirectToLogin()">
        </div>
    </div>
</body>
    <script>
    $(document).ready(function() {
        $('#findIdForm').on('submit', function(e) {
            e.preventDefault();
            validateInputs();
        });
    });

    function cancelVerification() {
        window.location.href = "/login.go";
    }

    function validateInputs() {
        var name = $('#name').val();
        var email = $('#email').val();

        if (!name || !email) {
            alert("이름과 이메일을 모두 입력해주세요.");
            return;
        }

        openModal(name, email);
    }

    function openModal(name, email) {
        $.ajax({
            url: 'idFind.ajax',
            type: 'POST',
            data: {
                name: name,
                email: email
            },
            success: function(response) {
                console.log("서버 응답:", response.use); // 응답 값 콘솔에 출력
                if (response.use !== "" && response.use !== null) {
                    // 아이디를 찾은 경우 모달에 표시
                    $('#foundIdMessage').text("고객님의 아이디는 " + response.use + " 입니다.");
                    $('#myModal').show();
                } else {
                    // 아이디를 찾지 못한 경우 메세지 표시
                    alert("회원님의 가입한 ID가 없습니다.");
                }
            },
            error: function() {
                // 요청이 실패한 경우 에러 처리
                alert("서버와의 통신에 문제가 발생했습니다.");
            }
        });
    }

    function closeModal() {
        $('#myModal').hide();
    }

    function redirectToLogin() {
        window.location.href = "/login.go";
    }
    </script>
    
</html>