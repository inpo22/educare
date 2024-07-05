<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>사원정보 - 사원관리 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<jsp:include page="/views/common/head.jsp"></jsp:include>
<link href="/resources/emp/emp.css" rel="stylesheet">
<!-- js -->

<style>
h3 {
    margin-left: 40px;
    margin-top: 10px;
    font-weight: bold;
}
.emp-profile {
    display: flex;
    align-items: flex-start; /* 세로 정렬 시작점을 맞추기 위해 */
}

.profile-picture {
    flex: 0 0 auto; /* 고정 너비 */
    margin-right: 20px;
}

.emp-profile img{
    width: 250px; /* 사진의 너비 조정 */
    height: auto; /* 높이 자동 조정 */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
    margin-left: 30px;
    margin-bottom: 20px;
    margin-right: 10px;
}
.bi.bi-person-fill {
    font-size: 250px;
    width: 250px; /* 사진의 너비 조정 */
    height: auto; 
    margin-left: 30px;
    margin-bottom: 20px;
    margin-right: 10px;
}


.employee-info {
    flex: 1; /* 남은 공간을 모두 차지하도록 */
    margin-left: 20px;
}

.employee-info .row {
    display: flex;
    flex-wrap: wrap; /* 줄 바꿈 설정 */
}

.employee-info .row .col-6 {
    flex: 0 0 50%; /* 50%의 너비를 가지도록 */
    max-width: 50%; /* 최대 너비 설정 */
    padding: 10px; /* 간격 설정 */
    box-sizing: border-box; /* padding 고려하여 너비 계산 */
}

.employee-info p {
    margin: 10px 0;
    font-weight: bold;
}

.employee-info input {
    width: 100%;
    padding: 5px;
    margin-bottom: 10px;
    box-sizing: border-box;
}

@media (max-width: 768px) {
    .emp-profile {
        flex-direction: column; /* 작은 화면에서 세로 정렬 */
        align-items: center;
    }

    .profile-picture img {
        margin-left: 0;
        margin-bottom: 20px;
    }

    .employee-info .row .col-6 {
        flex: 0 0 100%; /* 전체 너비 차지 */
        max-width: 100%;
    }
}
#empList_go{
	margin:0 7px;
}
input[readonly] {
    background-color: white; /* 배경색 */
    /* border: none; */ /* 테두리 없앰 */
    outline: none; 
    pointer-events: none;
    text-align: center;
    font-weight: bold;
}
.info-group {
    display: flex;
    align-items: center;
    margin : 30px 0;
}

.info-group p {
    margin: 0;
    margin-right: 10px;
    min-width: 100px; /* 최소 너비 설정으로 정렬을 개선 */
}

.info-group input {
    flex: 1;
}
#empList_go{
	height:38px;
}
</style>
</head>

<body>

    <jsp:include page="/views/common/header.jsp"></jsp:include>
    <jsp:include page="/views/common/sidebar.jsp"></jsp:include>

    <main id="main" class="main">
        <div id="backBoard">
            <div class="pagetitle">
                <h1>사원 상세정보</h1>
            </div>
            <!-- End Page Title -->
            <br>
            <div>
                <h3>${empDto.name}</h3>
            </div>
			<br>
            <div class="emp-profile">
                <c:choose>
			        <c:when test="${not empty empDto.photo}">
			            <img src="/photo/${empDto.photo}">
			        </c:when>
			        <c:otherwise>
			            <!-- 기본 프로필 사진 또는 다른 대체 이미지 -->
			            <i class="bi bi-person-fill"></i>
			        </c:otherwise>
			    </c:choose>
                <div class="employee-info">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-group">
                                <p><strong>사원번호:</strong></p>
                                <input type="text" value="${empDto.user_code}" id="user_code" name="user_code" class="form-control custom-input" readonly>
                            </div>
                            <div class="info-group">
                                <p><strong>이메일:</strong></p>
                                <input type="text" value="${empDto.email}" id="email" name="email" class="form-control" readonly>
                            </div>
                            <div class="info-group">
                                <p><strong>생년월일:</strong></p>
                                <input type="text" value="${empDto.birth}" id="birth" name="birth" class="form-control" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-group">
                                <p><strong>아이디:</strong></p>
                                <input type="text" value="${empDto.id}" id="id" name="id" class="form-control" readonly>
                            </div>
                            <div class="info-group">
                                <p><strong>연락처:</strong></p>
                                <input type="text" value="${empDto.phone}" id="phone" name="phone" class="form-control" readonly>
                            </div>
                            <div class="info-group">
                                <p><strong>부서:</strong></p>
                                <input type="text" value="${empDto.team_name}" id="team_code" name="team_code" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="emp-profile">
                <div class="employee-info">
				    <div class="row">
				        <div class="col-md-6">
				            <div class="info-group">
				                <p><strong>직급:</strong></p>
				                <input type="text" value="${empDto.class_name}" id="class_code" name="class_code" class="form-control" readonly>
				            </div>
				            <div class="info-group">
				                <p><strong>입사일:</strong></p>
				                <input type="text" value="${empDto.reg_date}" id="reg_date" name="reg_date" class="form-control" readonly>
				            </div>
				            <div class="info-group">
				                <p><strong>회원구분:</strong></p>
				                <input type="text" value="${empDto.classify_name}" id="classify_code" name="classify_code" class="form-control" readonly>
				            </div>
				            <div class="info-group">
				                <p><strong>성별:</strong></p>
				                <input type="text" value="${empDto.gender}" id="gender" name="gender" class="form-control" readonly>
				            </div>
				        </div>
				        <div class="col-md-6">
				            <div class="info-group">
				                <p><strong>직책:</strong></p>
				                <input type="text" value="${empDto.position_name}" id="position_code" name="position_code" class="form-control" readonly>
				            </div>
				            <div class="info-group">
				                <p><strong>퇴사일:</strong></p>
				                <input type="text" value="${empDto.quit_date}" id="quit_date" name="quit_date" class="form-control" readonly>
				            </div>
				            <div class="info-group">
				                <p><strong>계정상태:</strong></p>
				                <c:choose>
				                    <c:when test="${empDto.status == 0}">
				                        <input type="text" value="정상" class="form-control" readonly>
				                    </c:when>
				                    <c:when test="${empDto.status == 1}">
				                        <input type="text" value="중지" class="form-control" readonly>
				                    </c:when>
				                </c:choose>
				            </div>
				        </div>
				    </div>
				</div>               
            </div>
            <div class="row mt-3">
            	<div class="col-md-6"></div>
	            <div class="col-md-6 d-flex justify-content-end">
	                <button id="empList_go" class="btn btn-dark" type="button">사원리스트</button>
	            	<form action="/emp/edit.go" method="get">
	            		<input type="hidden" name="user_code" value="${empDto.user_code}">
	            		<button id="edit_go" class="btn btn-dark" type="submit">수정하기</button>
	            	</form>
	            </div>
	        </div>

        </div>
    </main>
    <!-- End #main -->

    <jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
// 사원 리스트 이동
$('#empList_go').click(function(){
	var quit_date = "${empDto.quit_date}"; //퇴사일 가져옴
	
	// 퇴사자일 경우 퇴사자 목록으로
	if(quit_date !== null && quit_date != ''){
		window.location.href = '/emp/quitList.go';
	}else{
		window.location.href = '/emp/list.go';
	}
	
});

// 수정 페이지 이동
$('#edit_go').click(function(){
	window.location.href = '/emp/edit.go';
});

// 퇴사자일 경우 수정 버튼 비활성화
document.addEventListener('DOMContentLoaded',function(){
	var quit_date = "${empDto.quit_date}"; //퇴사일 가져옴
	var edit_btn = document.getElementById('edit_go');
	
	// quit_date가 null이 아닌 경우 버튼을 비활성화합니다.
    if (quit_date !== null && quit_date !== '') {
    	edit_btn.disabled = true;
    }
});
</script>
</html>
