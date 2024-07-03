<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link collapsed" href="/">
                <i class="bi bi-grid"></i>
                <span>대시보드</span>
            </a>
        </li><!-- 대시보드 구획 끝 -->

        <li class="nav-item pm-admin">
            <a class="nav-link collapsed" href="/receivedMail/list.go">
                <i class="bi bi-envelope"></i>
                <span>메일</span>
            </a>
        </li><!-- 메일 구획 끝 -->

        <li class="nav-item pm-admin">
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

        <li class="nav-item pm-admin">
            <a class="nav-link collapsed" data-bs-target="#commute-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-check-circle"></i><span>근태 관리</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="commute-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
                <li>
                    <a href="/commuteState.go">
                        <i class="bi bi-circle"></i><span>근태 관리</span>
                    </a>
                </li>
                <li>
                    <a href="/vacaHistory.go">
                        <i class="bi bi-circle"></i><span>연차 내역</span>
                    </a>
                </li>
            </ul>
        </li><!-- 근태 관리 구획 끝 -->

        <li class="nav-item pm-admin">
            <a class="nav-link collapsed" href="/course/list.go">
                <i class="bi bi-book"></i>
                <span>강의 관리</span>
            </a>
        </li><!-- 강의 관리 구획 끝 -->

        <li class="nav-item pm-admin">
            <a class="nav-link collapsed" href="/courseReservation.go">
                <i class="bi bi-geo"></i>
                <span>강의실 관리</span>
            </a>
        </li><!-- 강의실 관리 구획 끝 -->

        <li class="nav-item pm-admin">
            <a class="nav-link collapsed" href="/std/list.go">
                <i class="bi bi-people"></i>
                <span>학생 관리</span>
            </a>
        </li><!-- 학생 관리 구획 끝 -->

        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#board-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-archive"></i><span>게시판</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="board-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
                <li class="pm-admin">
                    <a href="/allBoard/list.go">
                        <i class="bi bi-circle"></i><span>전사 공지사항</span>
                    </a>
                </li>
                <li class="pm-admin">
                    <a href="/teamBoard/list.go">
                        <i class="bi bi-circle"></i><span>부서 공지사항</span>
                    </a>
                </li>
                <li>
                    <a href="/stdBoard/list.go">
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

        <li class="nav-item pm-superadmin">
            <a class="nav-link collapsed" href="/dept.go">
                <i class="bi bi-diagram-3"></i>
                <span>부서 관리</span>
            </a>
        </li><!-- 부서 관리 구획 끝 -->

        <li class="nav-item pm-superadmin">
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
<script>
var superadmin_team_code = ['T001', 'T006'];
var pm_classify_code = '${sessionScope.classify_code}';

if (!superadmin_team_code.includes('${sessionScope.team_code}')) {
	// console.log('관리자 권한 설정 완료');
	$('.pm-superadmin').css('display', 'none');
	
}

if (pm_classify_code == 'U03') {
	// console.log('이용자 권한 설정 완료');
	$('.pm-superadmin').css('display', 'none');
	$('.pm-admin').css('display', 'none');
	
}
</script>