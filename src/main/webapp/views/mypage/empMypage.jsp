<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>마이페이지 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<jsp:include page="/views/common/head.jsp"></jsp:include>

<!-- css -->
<link href="/resources/mypage/empStyle.css" rel="stylesheet">

<!-- js -->

<style>
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
									<img src="/photo/${dto.photo}" alt="Profile" class="rounded-circle load-profile-img">
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
										<div class="col-lg-3 col-md-4 label">직책</div>
										<div class="col-lg-9 col-md-8">${dto.position_name}</div>
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
										<div class="col-lg-3 col-md-4 label ">사원번호</div>
										<div class="col-lg-9 col-md-8">${sessionScope.user_code}</div>
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
									<form action="/mypageEmp/profile/update.do" method="post" id="profile-edit-form" enctype="multipart/form-data">
										<div class="row mb-3">
											<label for="profileImage" class="col-md-4 col-lg-3 col-form-label">프로필 사진</label>
											<div class="col-md-8 col-lg-9">
												<span class="profile-default-img" id="profile-change-img">
													<c:if test="${dto.photo eq null}">
														<i class="bi bi-person-bounding-box"></i>
													</c:if>
													<c:if test="${dto.photo ne null}">
														<img src="/photo/${dto.photo}" alt="Profile" class="load-profile-img">
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
												<input name="phone" type="text" class="form-control" id="phone" oninput="phoneNumber(this)" value="${dto.phone}">
											</div>
										</div>
										<div class="row mb-3">
											<label for="profileImage" class="col-md-4 col-lg-3 col-form-label">서명 사진</label>
											<div class="col-md-8 col-lg-9">
												<span class="profile-default-img" id="sign-change-img">
													<c:if test="${dto.sign_photo eq null}">
														<img src="/resources/img/approve_mark.png"/>
													</c:if>
													<c:if test="${dto.sign_photo ne null}">
														<img src="/photo/${dto.sign_photo}" class="load-sign-img">
													</c:if>
												</span>
												<div class="pt-2">
													<a href="#" class="btn btn-primary btn-sm" id="sign-draw-img-button">
														<i class="bi bi-pencil-square"></i>
													</a>
													<a href="#" class="btn btn-primary btn-sm" id="sign-update-img-button">
														<i class="bi bi-upload"></i>
													</a>
													<a href="#" class="btn btn-danger btn-sm" id="sign-remove-img-button">
														<i class="bi bi-trash"></i>
													</a>
													<input type="file" name="sign_photo" id="sign-update-img"/>
													<input type="hidden" name="sign_canvas_photo" id="sign-canvas-img"/>
												</div>
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
									<form action="/mypageEmp/pw/update.do" method="post" id="password-edit-form">
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
	
	<!-- 받는 사람 모달 -->
	<div id="sign-modal" class="modal" onclick="closeModal()">
		<div class="modal-content" onclick="event.stopPropagation()">
			<div>
				<span class="modal-title">서명 그리기</span>
				<span class="close" onclick="closeModal()">&times;</span>
				<br/><br/>
				<div class="canvas-div">
					<canvas id="sign-canvas"></canvas>
				</div>
				<br/>
				<div class="text-align-right">
					<button class="btn btn-danger btn-sm" id="sign-del">지우기</button>
					<button class="btn btn-primary btn-sm" id="sign-save">저장</button>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
	var msg = '${msg}';
	if (msg) {
		alert(msg);
	}
	
	function closeModal() {
		$('#sign-modal').css('display', 'none');
		signDel();
	}
	
	$('#profile-update-img-button').click(function(e) {
		e.preventDefault();
		
		$('#profile-update-img').click();
	});
	
	$('#profile-update-img').change(function() {
		var file = this.files[0];
		var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/;
		
		var content = '';
		
		if (!allowedExtensions.exec(file.name)) {
			alert("이미지 파일 첨부만 가능합니다.");
			this.value = '';
			return;
		}
		
		if (file) {
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function (){
				content += '<img src="' + reader.result + '" class="load-profile-img"/>';
				// console.log(content);
				
				$('#profile-change-img').html(content);
			};
		}
	});
	
	$('#profile-remove-img-button').click(function(e) {
		e.preventDefault();
		var content = '<i class="bi bi-person-bounding-box"></i>';
		$('#profile-change-img').html(content);
		$('#profile-update-img').val('')
	});
	
	$('#sign-update-img-button').click(function(e) {
		e.preventDefault();
		
		$('#sign-update-img').click();
	});
	
	$('#sign-update-img').change(function() {
		$('#sign-canvas-img').val('');
		var file = this.files[0];
		var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/;
		
		var content = '';
		
		if (!allowedExtensions.exec(file.name)) {
			alert("이미지 파일 첨부만 가능합니다.");
			this.value = '';
			return;
		}
		
		if (file) {
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function (){
				content += '<img src="' + reader.result + '" class="load-sign-img"/>';
				// console.log(content);
				
				$('#sign-change-img').html(content);
			};
		}
	});
	
	$('#sign-remove-img-button').click(function(e) {
		e.preventDefault();
		var content = '<img src="/resources/img/approve_mark.png"/>';
		$('#sign-change-img').html(content);
		$('#sign-update-img').val('');
		$('#sign-canvas-img').val('');
	});
	
	$('#sign-draw-img-button').click(function(e) {
		e.preventDefault();
		
		$('#sign-modal').css('display', 'block');
	});
	
	// 캔버스
	var canvas = $('#sign-canvas');
	// 캔버스의 오브젝트를 가져옵니다.
	var ctx = canvas[0].getContext('2d');
	var drawble = false;
	
	var div = canvas.parent('div');
	canvas[0].height = div.height();
	canvas[0].width = div.width();
	
	// 캔버스 스타일 설정
	ctx.strokeStyle = "#000000";  // 검은색 선
	ctx.lineWidth = 5;  
		
	// pc에서 서명을 할 경우 사용되는 이벤트입니다.
	function draw(e){
		function getPosition(){
			return {
				X: e.offsetX,
				Y: e.offsetY
			}
		}
		
		switch(e.type) {
			case 'mousedown': {
				drawble = true;
				ctx.beginPath();
				ctx.moveTo(getPosition().X, getPosition().Y);
				// console.log('mousedown', getPosition());
				break;
			}
			case 'mousemove': {
				if (drawble) {
					ctx.lineTo(getPosition().X, getPosition().Y);
					ctx.stroke();
					// console.log('mousemove', getPosition());
				}
				break;
			}
			case 'mouseup': case 'mouseout': {
				drawble = false;
				ctx.closePath();
				// console.log('mouseup', getPosition());
				break;
			}
		}
	}
	
	canvas.on('mousedown', draw);
	canvas.on('mousemove', draw);
	canvas.on('mouseup', draw);
	canvas.on('mouseout', draw);
	
	$('#sign-save').on('click', function() {
		var signImgContent = '';
		var signImg = canvas[0].toDataURL('image/png');
		
		if (signImg) {
			/*
			var link = document.createElement('a');
			// base64데이터 링크 달기
			link.href = canvas[0].toDataURL("image/png");
			// 다운로드시 파일명 지정
			link.download = "image.png";
			// body에 추가
			document.body.appendChild(link);
			link.click();
			document.body.removeChild(link);
			*/
			
			var dataURL = canvas[0].toDataURL("image/png");
			
			var content = '<img src="' + dataURL + '"/>';
			$('#sign-change-img').html(content);
			$('#sign-update-img').val('');
			$('#sign-canvas-img').val(dataURL);
			
			
		}
		closeModal();
	});
	
	$('#sign-del').click(function() {
		signDel();
	});
	
	function signDel() {
		// 캔버스 지우기
		ctx.clearRect(0, 0, canvas[0].width, canvas[0].height);
	}
	
	$('#profileEdit-submit').click(function() {
		var $email = $('#email');
		var $phone = $('#phone');
		
		if($email.val() == ''){
			alert('이메일을 입력해주세요.');
			$email.focus();
		} else if($phone.val() == ''){
			alert('연락처를 입력해주세요.');
			$phone.focus();
		} else {
			// 이메일 유효성 검사
			var regEmail = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
			//핸드폰번호 유효성검사
			var regphone = /^(010)-?[0-9]{4}-?[0-9]{4}$/;
			
			if (regEmail.test($email.val()) == false) {
				alert('이메일 형식이 올바르지 않습니다.');
				$email.focus();
			} else if (regphone.test($phone.val()) == false) {
				alert('연락처 형식이 올바르지 않습니다.');
				$phone.focus();
			} else {
				var result = confirm('입력하신 정보로 변경하시겠습니까?');
				if (result) {
					$('#profile-edit-form').submit();
				}
			}
		}
	});
	
	$('#pwEdit-submit').click(function() {
		var $newPw = $('#newPassword');
		var $reNewPw = $('#reNewPassword');
		
		// 비밀번호 유효성 검사
		var regex = /^(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$%^&*()_+={}[\]:;'"<>,./?\\|~-]).{8,16}$/;
		
		if(!regex.test($newPw.val())){
			alert("비밀번호는 8-16자리, 숫자, 소문자, 특수문자를 모두 포함해야 합니다.")
			$newPw.focus();
		} else if ($newPw.val().indexOf(" ") != -1) {
			alert("비밀번호는 공백을 포함할 수 없습니다.")
			$newPw.focus();
		} else if ($newPw.val() != $reNewPw.val()){
			alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.")
			$reNewPw.focus();
		} else {
			var result = confirm('입력하신 비밀번호로 변경하시겠습니까?');
			if (result) {
				$('#password-edit-form').submit();
			}
		}
	});
	
	//연락처 입력 시 하이픈 자동생성
	$(document).on("keyup", "#phone", function() {
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
	});
	// 하이픈 포함 13자리까지만 입력 가능하도록
	function phoneNumber(e){
		if(e.value.length>13){
		e.value=e.value.slice(0,13);
		}
	}
</script>
</html>