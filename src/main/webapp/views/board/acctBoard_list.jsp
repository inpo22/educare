<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Dashboard - NiceAdmin Bootstrap Template</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="/resources/assets/img/favicon.png" rel="icon">
  <link href="/resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="/resources/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="/resources/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="/resources/assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="/resources/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="/resources/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="/resources/assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="/resources/assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Updated: Apr 20 2024 with Bootstrap v5.3.3
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
<style>
</style>
</head>

<body>
  <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
      <a href="/" class="logo d-flex align-items-center">
        <img src="/resources/img/EDUcare_logo.png" alt="">
      </a>
      <i class="bi bi-list toggle-sidebar-btn"></i>
    </div><!-- End Logo -->

    <nav class="header-nav ms-auto">
      <ul class="d-flex align-items-center">
        <li class="nav-item dropdown">

          <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
            <i class="bi bi-bell"></i>
            <span class="badge bg-primary badge-number">4</span>
          </a><!-- 알림 개수 끝 -->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
            <li class="dropdown-header">
              You have 4 new notifications
              <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li class="notification-item">
              <i class="bi bi-exclamation-circle text-warning"></i>
              <div>
                <h4>Lorem Ipsum</h4>
                <p>Quae dolorem earum veritatis oditseno</p>
                <p>30 min. ago</p>
              </div>
            </li>

            <li>
              <hr class="dropdown-divider">
            </li>

            <li class="notification-item">
              <i class="bi bi-x-circle text-danger"></i>
              <div>
                <h4>Atque rerum nesciunt</h4>
                <p>Quae dolorem earum veritatis oditseno</p>
                <p>1 hr. ago</p>
              </div>
            </li>

            <li>
              <hr class="dropdown-divider">
            </li>

            <li class="notification-item">
              <i class="bi bi-check-circle text-success"></i>
              <div>
                <h4>Sit rerum fuga</h4>
                <p>Quae dolorem earum veritatis oditseno</p>
                <p>2 hrs. ago</p>
              </div>
            </li>

            <li>
              <hr class="dropdown-divider">
            </li>

            <li class="notification-item">
              <i class="bi bi-info-circle text-primary"></i>
              <div>
                <h4>Dicta reprehenderit</h4>
                <p>Quae dolorem earum veritatis oditseno</p>
                <p>4 hrs. ago</p>
              </div>
            </li>

          </ul><!-- 알림 드롭다운 끝 -->

        </li><!-- 알림 구획 끝 -->

        <li class="nav-item dropdown pe-3">

          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
            <img src="/resources/assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
            <span class="d-none d-md-block dropdown-toggle ps-2">K. Anderson</span>
          </a><!-- 프로필 아이콘 끝 -->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
            <li class="dropdown-header">
              <h6>Kevin Anderson</h6>
              <span>Web Designer</span>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="/mypage.go">
                <i class="bi bi-person"></i>
                <span>마이페이지</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="#">
                <i class="bi bi-box-arrow-right"></i>
                <span>로그아웃</span>
              </a>
            </li>

          </ul><!-- 프로필 드롭다운 끝 -->
        </li><!-- 프로필 구획 끝 -->

      </ul>
    </nav><!-- 아이콘 구획 끝 -->

  </header><!-- End Header -->

  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link collapsed" href="/">
          <i class="bi bi-grid"></i>
          <span>대시보드</span>
        </a>
      </li><!-- 대시보드 구획 끝 -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="/receivedMail/list.go">
          <i class="bi bi-envelope"></i>
          <span>메일</span>
        </a>
      </li><!-- 메일 구획 끝 -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="/getApproval/list.go">
          <i class="bi bi-file-earmark-text"></i>
          <span>전자결재</span>
        </a>
      </li><!-- 전자결재 구획 끝 -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="/schedule.go">
          <i class="bi bi-calendar-check"></i>
          <span>일정 관리</span>
        </a>
      </li><!-- 일정 관리 구획 끝 -->

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#commute-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-check-circle"></i><span>근태 관리</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="commute-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="/commuteState.go">
              <i class="bi bi-circle"></i><span>근태 현황</span>
            </a>
          </li>
          <li>
            <a href="/vacaHistory.go">
              <i class="bi bi-circle"></i><span>연차 내역</span>
            </a>
          </li>
        </ul>
      </li><!-- 근태 관리 구획 끝 -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="/course/list.go">
          <i class="bi bi-book"></i>
          <span>강의 관리</span>
        </a>
      </li><!-- 강의 관리 구획 끝 -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" href="/courseReservation.go">
          <i class="bi bi-geo"></i>
          <span>강의실 관리</span>
        </a>
      </li><!-- 강의실 관리 구획 끝 -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="/std/list.go">
          <i class="bi bi-people"></i>
          <span>학생 관리</span>
        </a>
      </li><!-- 학생 관리 구획 끝 -->

      <li class="nav-item">
        <a class="nav-link" data-bs-target="#board-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-archive"></i><span>게시판</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="board-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="/allBoard/list.go">
              <i class="bi bi-circle"></i><span>전사 공지사항</span>
            </a>
          </li>
          <li>
            <a href="/affairsBoard/list.go">
              <i class="bi bi-circle"></i><span>총무인사팀 공지사항</span>
            </a>
          </li>
          <li>
            <a href="/trainingBoard/list.go">
              <i class="bi bi-circle"></i><span>훈련운영팀 공지사항</span>
            </a>
          </li>
          <li>
            <a href="/mgmtBoard/list.go">
              <i class="bi bi-circle"></i><span>행정관리팀 공지사항</span>
            </a>
          </li>
          <li>
            <a href="/acctBoard/list.go">
              <i class="bi bi-circle"></i><span>재무회계팀 공지사항</span>
            </a>
          </li>
          <li>
            <a href="/stuBoard/list.go">
              <i class="bi bi-circle"></i><span>학생 공지사항</span>
            </a>
          </li>
          <li>
            <a href="/dataBoard/list.go">
              <i class="bi bi-circle"></i><span>학생 자료실</span>
            </a>
          </li>
        </ul>
      </li><!-- 게시판 구획 끝 -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="/dept.go">
          <i class="bi bi-diagram-3"></i>
          <span>부서 관리</span>
        </a>
      </li><!-- 부서 관리 구획 끝 -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="/emp/list.go">
          <i class="bi bi-people"></i>
          <span>사원 관리</span>
        </a>
        <br/><br/>
      </li><!-- 사원 관리 구획 끝 -->

      <li class="nav-heading">Pages</li>

      <li class="nav-item">
        <a class="nav-link collapsed" href="/mypage.go">
          <i class="bi bi-person"></i>
          <span>마이페이지</span>
        </a>
      </li><!-- 마이페이지 구획 끝 -->
    </ul>

  </aside><!-- End Sidebar-->

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>재무회계팀 공지사항</h1>
    </div><!-- End Page Title -->
    
  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">
    <div class="copyright">
      &copy; Copyright <strong><span>NiceAdmin</span></strong>. All Rights Reserved
    </div>
    <div class="credits">
      <!-- All the links in the footer should remain intact. -->
      <!-- You can delete the links only if you purchased the pro version. -->
      <!-- Licensing information: https://bootstrapmade.com/license/ -->
      <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
      Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="/resources/assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="/resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/resources/assets/vendor/chart.js/chart.umd.js"></script>
  <script src="/resources/assets/vendor/echarts/echarts.min.js"></script>
  <script src="/resources/assets/vendor/quill/quill.js"></script>
  <script src="/resources/assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="/resources/assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="/resources/assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="/resources/assets/js/main.js"></script>

</body>
<script>
</script>
</html>