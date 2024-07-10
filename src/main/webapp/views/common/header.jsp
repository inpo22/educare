<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- ======= Header ======= -->
<header id="header" class="header fixed-top d-flex align-items-center">
    <div class="d-flex align-items-center justify-content-between">
        <a href="/" class="logo d-flex align-items-center">
            <img src="/resources/img/EDUcare_logo.png" alt="">
        </a>
        <!-- <i class="bi bi-list toggle-sidebar-btn"></i> -->
    </div>
    <!-- End Logo -->

    <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">
            <!-- 알림 -->
            <jsp:include page="/views/common/notification.jsp"></jsp:include>

            <li class="nav-item dropdown pe-3">
                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                    <!-- <img src="/resources/assets/img/profile-img.jpg" alt="Profile" class="rounded-circle"> -->
                    <c:choose>
                        <c:when test='${not empty sessionScope.photo}'>
                            <img src="/photo/${sessionScope.photo}" class="rounded-circle">
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-person-circle" style="font-size: 30px;"></i>
                        </c:otherwise>
                    </c:choose>
                    <!-- <span>${sessionScope.photo}</span> -->
                    <span class="d-none d-md-block dropdown-toggle ps-2">${sessionScope.user_name}</span>
                </a>
                <!-- 프로필 아이콘 끝 -->

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                    <li class="dropdown-header">
                        <!-- <h6>${sessionScope.user_code}</h6> -->                         
                        <h6>
                        	${sessionScope.user_name}
                            <c:if test="${not empty sessionScope.class_name}">
                                 ${sessionScope.class_name}
                            </c:if>                                                     
                        </h6>
                        <c:if test="${not empty sessionScope.team_name}">
                            <span>${sessionScope.team_name}</span>
                        </c:if>
                        <!-- <span>${sessionScope.classify_name}</span> -->
                    </li>

                    <li>
                         <hr style="border-top: 1px solid #6c757d; margin: 0;">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="/mypage.go">
                            <i class="bi bi-person"></i>
                            <span>마이페이지</span>
                        </a>
                    </li>
                    <li>
                         <hr style="border-top: 1px solid #6c757d; margin: 0;">
                    </li>

                    <li>
                        <a href="/logout.do" class="dropdown-item d-flex align-items-center" onclick="logoutAccess()">
                            <i class="bi bi-box-arrow-right"></i>
                            <span>로그아웃</span>
                        </a>
                    </li>
                </ul>
                <!-- 프로필 드롭다운 끝 -->
            </li>
            <!-- 프로필 구획 끝 -->
        </ul>
    </nav>
    <!-- 아이콘 구획 끝 -->
</header>
<!-- End Header -->

<script>
    function logoutAccess() {
        var id = "${user_code}";
        //console.log("user_code:", id);
        if (id != null && id != "") {
        	alert("로그아웃 되었습니다.")
            window.location.href = "/logout.do";
            
        } else {
            alert("이미 로그아웃 상태입니다.");
        
        }
    }
    
 // 세션 타임아웃을 감지하는 타이머 설정 (30분 후 자동 로그아웃)
    var logoutTimer;
    function startLogoutTimer() {
        console.log("로그아웃 타이머 시작");
        clearTimeout(logoutTimer);
        logoutTimer = setTimeout(function() {
            alert('로그인이 만료되었습니다');
            window.location.href = '/logout.do';
        }, 30 * 60 * 1000); // 30분
    }

    // 페이지 로드 시 타이머 시작
    startLogoutTimer();

    // 사용자가 페이지에서 활동할 때마다 타이머 리셋
    document.addEventListener('click', function() {
        //console.log("클릭 이벤트 감지, 타이머 리셋");
        startLogoutTimer();
    });
    document.addEventListener('keypress', function() {
        //console.log("키보드 입력 감지, 타이머 리셋");
        startLogoutTimer();
    });
</script>