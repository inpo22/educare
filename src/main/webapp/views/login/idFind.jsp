<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기 - 에듀케어</title>
    <link href="/resources/assets/img/favicon.png" rel="icon">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/login/login.css" rel="stylesheet">
    <style></style>
</head>
<body>
    <video width="100%" height="auto" autoplay loop playsinline muted>
        <source src="/resources/login/loginimage.mp4" type="video/mp4">
    </video>
    <div class="container">
        <h3><b>아이디 찾기</b></h3>
        <br/>
        <form id="findIdForm" action="/login/idFindResult.go" method="post">
            <table class="table table-borderless">
                <colgroup>
                    <col width="30%">
                    <col width="70%">
                </colgroup>
                <tr>
                    <td class="vertical-align-middle">이름</td>
                    <td><input type="text" class="form-control" id="name" name="name"></td>
                </tr>
                <tr>
                    <td class="vertical-align-middle">이메일</td>
                    <td><input type="text" class="form-control" id="email" name="email"></td>
                </tr>
            </table>
            <br/>
            <div class="text-align-center">
                <button type="submit" class="btn btn-primary" onclick="idFindvalidation()">다음</button>
                &nbsp;&nbsp;
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