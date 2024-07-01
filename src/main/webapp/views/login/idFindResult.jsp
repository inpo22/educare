<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>:: EduCare - 아이디 찾기 결과 ::</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f5f5f5;
        }

        .result-container {
            width: 400px;
            padding: 20px;
            background-color: white;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .result-container img {
            display: block;
            margin: 0 auto 20px;
        }

        .btn-group {
            display: flex;
            justify-content: space-between;
            width: 100%;
        }

        .btn-group .btn {
            width: 48%;
            border-radius: 8px !important;
        }

        .btn-group .btn:not(:last-child) {
            margin-right: 4%;
        }
    </style>
</head>
<body>
    <div class="result-container">
        <h3 class="text-center">아이디 찾기 결과</h3>
        <p class="text-center">고객님의 정보와 일치하는 아이디입니다.</p>
        <br>
        <p class="text-center" style="font-size: 1.5rem; font-weight: bold;">아이디: ${userId}</p>
        <div class="btn-group">
            <button class="btn btn-primary" onclick="redirectToPwFind()">비밀번호 찾기</button>
            <button class="btn btn-secondary" onclick="redirectToLogin()">로그인</button>
        </div>
    </div>
    <script>
        function redirectToLogin() {
            window.location.href = "/login.go";
        }

        function redirectToPwFind() {
            window.location.href = "/login/pwFind.go";
        }
    </script>
</body>
</html>