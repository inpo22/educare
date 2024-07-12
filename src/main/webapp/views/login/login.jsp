<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>로그인 - 에듀케어</title>
    <link href="/resources/assets/img/favicon.png" rel="icon">
    <link href="/resources/login/login.css" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <style></style>
</head>
<body>
    <video width="100%" height="auto" autoplay loop playsinline muted>
        <source src="/resources/login/loginimage.mp4" type="video/mp4">
    </video>
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
                <a href="login/idFind.go" id="findIdLink">아이디찾기</a>
            </div>
            <div>
                <a href="/login/pwFind.go" id="findPwLink">패스워드찾기</a>
            </div>
            <button type="submit" class="btn-primary" id="LoginButton">LOGIN</button>
            <div class="alert alert-danger mt-3" role="alert" id="errorMsg"></div>
        </form>
    </div>
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        var $rememberMe = $("#rememberMe");
        var $idField = $("#name");

        // 페이지 로드 할때 쿠키에서 아이디를 읽어와 입력 필드에 채움
        var savedId = getCookie('saveId');
        if (savedId) {
            $idField.val(savedId);
            $rememberMe.prop('checked', true);
        }

        // 로그인 폼 제출 시 쿠키 설정/삭제
        $('form').on('submit', function() {
            if ($rememberMe.is(':checked')) {
                setCookie('saveId', $idField.val(), 7); // 쿠키 유효기간 7일
            } else {
                setCookie('saveId', '', -1); // 쿠키 삭제
            }
        });

        var timeout = getParameterByName('timeout');
        if (timeout) {
            alert("로그인이 만료되었습니다");
        }
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

    // 로그아웃 메세지
    var msg = '${msg}';
    if (msg != '') {
        alert(msg);
    }

    // 세션 타임아웃으로 타임아웃 메시지를 표시하기 위해
    var timeout = getParameterByName('timeout');
    if (timeout) {
        alert("로그인이 만료되었습니다");
    }

    // URL 파라미터 읽기 함수 추가
    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }
</script>
</html>