<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>:: EduCare - 아이디 찾기 ::</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
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
            border-radius: 8px !important;
        }

        .btn-group .btn:not(:last-child) {
            margin-right: 8%;
        }
    </style>
</head>
<body>
    <div class="find-id-container">
        <h3 class="text-center"><b>아이디 찾기</b></h3>
        <p class="text-center">회원정보에 등록한 이름, 이메일로 찾기</p>
        <form id="findIdForm" action="/login/idFindResult.go" method="post">
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name">
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email">
            </div>
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">다음</button>
                <button type="button" class="btn btn-secondary" onclick="cancelVerification()">취소</button>
            </div>
        </form>
    </div>
    <script>
        function cancelVerification() {
            window.location.href = "/login.go";
        }

        var msg = '${msg}';
        if (msg != '') {
            alert(msg);
        }
    </script>
</body>
</html>