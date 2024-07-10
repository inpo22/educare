<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디찾기 결과 - 에듀케어</title>
     <link href="/resources/assets/img/favicon.png" rel="icon">
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
            text-align: center;
        }

        .result-container h3,
        .result-container p {
            margin: 0;
            padding: 10px 0;
        }

        .result-container p.id {
            font-size: 1.5rem;
            font-weight: bold;
            background-color: #e9ecef;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ced4da;
        }

        .btn-group {
            display: flex;
            justify-content: space-around;
            width: 100%;
            margin-top: 20px;
        }

        .btn-group .btn {
            flex: 1;
            border-radius: 8px !important;
            margin: 5px;
            padding: 12px;
            flex-basis: 100%;
            max-width: 200px;
        }
    </style>
</head>
<body>
    <div class="result-container">
        <h3>아이디 찾기 결과</h3>
        <p>고객님의 정보와 일치하는 아이디입니다.</p>
        <br>
        <p class="id">아이디: ${userId}</p>
        <div class="btn-group">
            <button class="btn btn-primary" onclick="ToPwFind()">비밀번호 찾기</button>
            <button class="btn btn-secondary" onclick="ToLogin()">로그인</button>
        </div>
    </div>
    <script>
        function ToPwFind() {
            window.location.href = "/login/pwFind.go";
        }
        function ToLogin() {
            window.location.href = "/login.go";
        }
    </script>
</body>
</html>