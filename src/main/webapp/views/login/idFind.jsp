<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기 - 에듀케어</title>
     <link href="/resources/assets/img/favicon.png" rel="icon">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
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
</body>
    <script>
    function cancelVerification() {
        window.location.href = "/login.go";
    }
    
    var msg = '${msg}';
    if (msg != '') {
        alert(msg);
    }

    
    
    
    
    </script>
</html>