<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디찾기 결과 - 에듀케어</title>
    <link href="/resources/assets/img/favicon.png" rel="icon">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/login/login.css" rel="stylesheet">
    <style></style>
</head>
<body>
    <video width="100%" height="auto" autoplay loop playsinline muted>
        <source src="/resources/login/loginimage.mp4" type="video/mp4">
    </video>
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