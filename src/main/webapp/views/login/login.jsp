<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>::LOGIN PAGE::</title>
<!--<link rel="stylesheet" href="css/common.css" type="text/css">-->

<!-- Vendor CSS Files -->
<link href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">


<!-- Template Main CSS File -->
<link href="/resources/assets/css/style.css" rel="stylesheet">


<!-- Vendor JS Files -->
<script src="/resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


<!-- Template Main JS File -->
<script src="/resources/assets/js/main.js"></script>

<!-- J-Query JS File -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
.divider:after,
.divider:before {
  content: "";
  flex: 1;
  height: 1px;
  background: #eee;
}
.h-custom {
  height: calc(100% - 73px);
}
@media (max-width: 450px) {
  .h-custom {
    height: 100%;
  }
}
</style>
</head>
<body>
<H2> EDUcare 로그인</H2>

<form action="login.do" method="post">
	<section class="vh-100">
  <div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-md-9 col-lg-6 col-xl-5">
         <!--  <img src="../img/EDUcare_logo.png" class="img-fluid" alt="Login Image">-->
          <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp" class="img-fluid"
          alt="Sample image"> 
      </div>
      <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
       
          <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
            <p class="lead fw-normal mb-0 me-3">Sign in with</p>
            <button type="button" class="btn btn-primary btn-floating mx-1">
              <i class="fab fa-facebook-f"></i>
            </button>

            <button type="button" class="btn btn-primary btn-floating mx-1">
              <i class="fab fa-twitter"></i>
            </button>

            <button type="button" class="btn btn-primary btn-floating mx-1">
              <i class="fab fa-linkedin-in"></i>
            </button>
          </div>

          <div class="divider d-flex align-items-center my-4">
            <p class="text-center fw-bold mx-3 mb-0"></p><!--  p태그안에 입력하면 아이디란 위에 글자추가 가능 -->
          </div>

          <!-- Email input -->
          <div class="form-outline mb-4">
            <input type="text" id="name" name="id" class="form-control form-control-lg"
              placeholder="아이디를 입력하세요" />
            <label class="form-label" for="form3Example3">ID</label>
          </div>

          <!-- Password input -->
          <div class="form-outline mb-3">
            <input type="password" name="pw" id="form3Example4" class="form-control form-control-lg"
              placeholder="비밀번호를 입력하세요" />
            <label class="form-label" for="form3Example4">Password</label>
          </div>

          <div class="d-flex justify-content-between align-items-center">
            <!-- Checkbox -->
            <div class="form-check mb-0">
              <input class="form-check-input me-2" type="checkbox" value="" id="form2Example3" />
              <label class="form-check-label" for="form2Example3">
                아이디 저장하기
              </label>
            </div>
            <a href="#!" class="text-body">비밀번호를 잊어버리셨나요?</a>
          </div>

          <div class="text-center text-lg-start mt-4 pt-2">
            <button type="submit"  class="btn btn-primary btn-lg"
              style="padding-left: 2.5rem; padding-right: 2.5rem;">Login</button>
            <p class="small fw-bold mt-2 pt-1 mb-0">아이디를 잊어버리셨나요? <a href="#!"
                class="link-danger">찾으러가기</a></p>
          </div>

      </div>
    </div>
  </div>
  <div class="d-flex flex-column flex-md-row text-center text-md-start justify-content-between py-4 px-4 px-xl-5 bg-primary">
    <!-- Copyright -->
    <div class="text-white mb-3 mb-md-0">
      Copyright © 2024. All rights reserved.
    </div>
    <!-- Copyright -->

    <!-- Right -->
    <div>
      <a href="#!" class="text-white me-4">
        <i class="fab fa-facebook-f"></i>
      </a>
      <a href="#!" class="text-white me-4">
        <i class="fab fa-twitter"></i>
      </a>
      <a href="#!" class="text-white me-4">
        <i class="fab fa-google"></i>
      </a>
      <a href="#!" class="text-white">
        <i class="fab fa-linkedin-in"></i>
      </a>
    </div>
    <!-- Right -->
  </div>
</section>
</form>
</body>
<script>
var loginError = '${loginError}'; 
console.log("Login Error Status: ", loginError);
if (loginError === "true") {
	alert("아이디 또는 비밀번호를 확인해주세요.");
}



</script>
</html>