<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>EDUcare - Login</title>
    <link
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        rel="stylesheet">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f5f5f5;
        }

        .login-container {
            width: 400px;
            padding: 20px;
            background-color: white;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            
        }

        .login-container img {
            display: block;
            margin: 0 auto 20px;
        }

        .login-container .form-group {
            position: relative;
        }

        .login-container .form-group i {
            position: absolute;
            top: 10px;
            left: 10px;
        }

        .login-container input {
            padding-left: 30px;
        }

        .login-container .btn-primary {
            width: 100%;
            background-color: #007bff;
            border: none;
        }

        .login-container .forgot-links {
            display: flex;
            justify-content: space-between;
        }

        .login-container .alert {
            display: none;
        }

        #findIdLink, #findPwLink {
            font-size: 14px;
            color: #007bff;
            text-decoration: none;
            margin-left: 270px;
        }

        #findIdLink:hover, #findPwLink:hover {
            text-decoration: underline;
        }

        #LoginButton {
            width: 100%;
            height: 50px;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            padding-top: 10px;
            line-height: 1.2;
            margin-top: 10px;
        }
    </style>


</head>
<body>
    <div class="login-container">
        <img src="/resources/img/EDUcare_logo.png" alt="EduCare Logo" class="img-fluid">
        <form action="/login.do" method="post">
            <div class="form-group">
                <i class="fa fa-user"></i>
                <input type="text" class="form-control" id="name" name="id" placeholder="ID">
            </div>
            <div class="form-group">
                <i class="fa fa-lock"></i>
                <input type="password" class="form-control" id="password" name="pw" placeholder="PW">
            </div>
            <div class="form-group form-check">
                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                <label class="form-check-label" for="rememberMe">아이디저장</label>
            </div>
            <div class="forgot-links">
                <a href="" id="findIdLink">아이디찾기</a>
            </div>
            <div>
                <a href="" id="findPwLink">패스워드찾기</a>
            </div>
            <button type="submit" class="btn-primary" id="LoginButton">LOGIN</button>
            <div class="alert alert-danger mt-3" role="alert" id="errorMsg">아이디 또는 비밀번호를 확인해 주세요.</div>
        </form>
    </div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    var rememberMe = $("#rememberMe");
    var idField = $("#name");

    // 페이지 로드 할때 쿠키에서 아이디를 읽어와 입력 필드에 채움
    var savedId = getCookie('saveId');
    console.log("쿠키에서 읽어온 saveId:", savedId);
    if (savedId) {
        idField.val(savedId);
        rememberMe.prop('checked', true);
        console.log("쿠키 값이 입력 필드에 설정되었습니다.");
    } else {
        console.log("쿠키 값이 존재하지 않습니다.");
    }

    // 로그인 폼 제출 시 쿠키 설정/삭제
    $('form').on('submit', function() {
        if (rememberMe.is(':checked')) {
            setCookie('saveId', idField.val(), 7); // 쿠키 유효기간 7일
            console.log("쿠키가 설정되었습니다.");
        } else {
            setCookie('saveId', '', -1); // 쿠키 삭제
            console.log("쿠키가 삭제되었습니다.");
        }
    });
});

// 쿠키 설정 함수
function setCookie(name, value, days) {
    var expires = '';
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = '; expires=' + date.toUTCString();
    }
    document.cookie = name + '=' + (value || '') + expires + '; path=/';
}

// 쿠키 읽기 함수
function getCookie(name) {
    var nameEQ = name + '=';
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}
    	//로그아웃 메세지
        var msg = '${msg}';
        if (msg != '') {
            alert(msg);
        }
    </script>
</body>
</html>