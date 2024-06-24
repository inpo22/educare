<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Dashboard - NiceAdmin Bootstrap Template</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- js -->

<style>
#profile-update-img {
	display: none;
}
.profile-default-img {
	font-size: 150px;
	color: #012970;
}
.changed-profile-img {
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div class="pagetitle">
			<h1>마이페이지</h1>
		</div>
		<!-- End Page Title -->

		<section class="section profile">
			<div class="row">
				<div class="col-xl-4">
					<div class="card">
						<div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
							<span class="profile-default-img">
								<c:if test="${dto.photo eq null}">
									<i class="bi bi-person-circle"></i>
								</c:if>
								<c:if test="${dto.photo ne null}">
									<img src="/photo/${dto.photo}" alt="Profile" class="rounded-circle">
								</c:if>
							</span>
							<br/>
							<h2>${dto.user_name}&nbsp;&nbsp;${dto.class_name}</h2>
							<br/>
							<h3>${dto.team_name}</h3>
							<br/>
						</div>
					</div>
				</div>
				<div class="col-xl-8">
					<div class="card">
						<div class="card-body pt-3">
							<!-- Bordered Tabs -->
							<ul class="nav nav-tabs nav-tabs-bordered">
								<li class="nav-item">
									<button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview"><b>나의 정보</b></button>
								</li>
								<li class="nav-item">
									<button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit"><b>개인정보 수정</b></button>
								</li>
								<li class="nav-item">
									<button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password"><b>비밀번호 변경</b></button>
								</li>
							</ul>
							<div class="tab-content pt-2">
								<div class="tab-pane fade show active profile-overview" id="profile-overview">
									<br/>
									<div class="row">
										<div class="col-lg-3 col-md-4 label ">이름</div>
										<div class="col-lg-9 col-md-8">${dto.user_name}</div>
									</div>
									<br/>
									<div class="row">
										<div class="col-lg-3 col-md-4 label">직급</div>
										<div class="col-lg-9 col-md-8">${dto.class_name}</div>
									</div>
									<br/>
									<div class="row">
										<div class="col-lg-3 col-md-4 label">부서</div>
										<div class="col-lg-9 col-md-8">${dto.team_name}</div>
									</div>
									<br/>
									<div class="row">
										<div class="col-lg-3 col-md-4 label">연락처</div>
										<div class="col-lg-9 col-md-8">${dto.phone}</div>
									</div>
									<br/>
									<div class="row">
										<div class="col-lg-3 col-md-4 label">이메일</div>
										<div class="col-lg-9 col-md-8">${dto.email}</div>
									</div>
									<br/>
									<div class="row">
										<div class="col-lg-3 col-md-4 label">입사일</div>
										<div class="col-lg-9 col-md-8">
											<fmt:formatDate value="${dto.reg_date}" pattern="yyyy.MM.dd"/>
										</div>
									</div>
								</div>

								<div class="tab-pane fade profile-edit pt-3" id="profile-edit">
									<!-- Profile Edit Form -->
									<form action="/mypage/empProfile/edit.do" method="post" id="profile-edit-form">
										<div class="row mb-3">
											<label for="profileImage" class="col-md-4 col-lg-3 col-form-label">프로필 사진</label>
											<div class="col-md-8 col-lg-9">
												<span class="profile-default-img">
													<c:if test="${dto.photo eq null}">
														<i class="bi bi-person-bounding-box"></i>
													</c:if>
													<c:if test="${dto.photo ne null}">
														<img src="/photo/${dto.photo}" alt="Profile" class="rounded-circle">
													</c:if>
												</span>
												<div class="pt-2">
													<a href="#" class="btn btn-primary btn-sm" id="profile-update-img-button">
														<i class="bi bi-upload"></i>
													</a>
													<a href="#" class="btn btn-danger btn-sm" id="profile-remove-img-button">
														<i class="bi bi-trash"></i>
													</a>
													<input type="file" name="photo" id="profile-update-img"/>
												</div>
											</div>
										</div>
										<div class="row mb-3">
											<label for="email" class="col-md-4 col-lg-3 col-form-label">이메일</label>
											<div class="col-md-8 col-lg-9">
												<input name="email" type="text" class="form-control" id="email" value="${dto.email}">
											</div>
										</div>
										<div class="row mb-3">
											<label for="phone" class="col-md-4 col-lg-3 col-form-label">연락처</label>
											<div class="col-md-8 col-lg-9">
												<input name="phone" type="text" class="form-control" id="phone" value="${dto.phone}">
											</div>
										</div>
										<div class="text-center">
											<button type="button" class="btn btn-primary" id="profileEdit-submit">저장하기</button>
										</div>
									</form>
									<!-- End Profile Edit Form -->
								</div>

								<div class="tab-pane fade pt-3" id="profile-change-password">
									<br/>
									<!-- Change Password Form -->
									<form action="/mypage/empPw/edit.do" method="post" id="password-edit-form">
										<div class="row mb-3">
											<label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">현재 비밀번호</label>
											<div class="col-md-8 col-lg-9">
												<input name="currentPassword" type="password" class="form-control" id="currentPassword"/>
											</div>
										</div>
										<div class="row mb-3">
											<label for="newPassword" class="col-md-4 col-lg-3 col-form-label">새 비밀번호</label>
											<div class="col-md-8 col-lg-9">
												<input name="newPassword" type="password" class="form-control" id="newPassword"/>
											</div>
										</div>
										<div class="row mb-3">
											<label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">비밀번호 확인</label>
											<div class="col-md-8 col-lg-9">
												<input name="reNewPassword" type="password" class="form-control" id="reNewPassword"/>
											</div>
										</div>
										<br/>
										<div class="text-center">
											<button type="button" class="btn btn-primary" id="pwEdit-submit">저장하기</button>
										</div>
									</form>
									<!-- End Change Password Form -->
								</div>
							</div>
							<!-- End Bordered Tabs -->
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>

$('#profileEdit-submit').click(function() {
	$('#profile-edit-form').submit();
});

$('#pwEdit-submit').click(function() {
	$('#password-edit-form').submit();
});

</script>
</html>