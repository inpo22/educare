<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>개인정보수정 - 마이페이지 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<jsp:include page="/views/common/head.jsp"></jsp:include>
<link href="/resources/mypage/stdStyle.css" rel="stylesheet">
<!-- js -->

<style>
.form-row {
    display: flex;
    gap: 20px;
}

.form-group {
    flex: 1;
    margin-bottom: 1rem;
}
label {
    display: block;
    font-weight: bold;
    color: #555555;
    margin:3px 50px;
}

input, select {
    width: 80%;
    padding: 0.75rem;
    border: 1px solid #cccccc;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 1rem;
    color: #333333;
    margin:0 50px;
}

input:focus, select:focus {
    border-color: #0066cc;
    outline: none;
}
.form-check-label{
	width:80px;
}
.form-check{
	margin:0 50px;
}
#msg,#length-msg,#pattern-msg{
	margin-left: 50px;
}
#mypageStd_go{
	margin:0 7px;
}
#id{
	width:39.5%;
}
#id, #user_code, #name{
	font-weight: bold;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<div class="pagetitle">
			<h1>개인 정보 수정</h1>
		</div>
		<!-- End Page Title -->
		
		<form action="/mypageStd/update.do" method="post" enctype="multipart/form-data">
				<div class="form-row">
	                 <div class="form-group">
	                     <label for="name">성명:</label>
	                     <input type="text" value="${mypageDto.name}" id="name" name="name" readonly>
	                 </div>
	                 <div class="form-group">
	                     <label for="user_code">학생번호:</label>
	                     <input type="text" value="${mypageDto.user_code}" id="user_code" name="user_code" readonly>
	                 </div>                 
	             </div>
	             <div class="form-row">
	                 <div class="form-group">
	                     <label for="email">이메일:</label>
	                     <input type="text" value="${mypageDto.email}" id="email" name="email" required>
	                 </div>
	                 <div class="form-group">
	                     <label for="phone">연락처:</label>
	                     <input type="text" value="${mypageDto.phone}" id="phone" name="phone" oninput="phoneNumber(this)" placeholder="숫자만 입력하세요">
	                 </div>
	             </div>
	             <div class="form-row">
	                 <div class="form-group">
	                     <label for="birth">생년월일:</label>
	                     <input type="date" value="${mypageDto.birth}" id="birth" name="birth" required>
	                 </div>
	                 <div class="form-group">
	                     <label for="gender">성별:</label>
	                     <div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="gender" id="male" value="남" ${mypageDto.gender == '남' ? 'checked' : ''}>
						  <label class="form-check-label" for="male">남성</label>
						</div>
						<div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="gender" id="female" value="여" ${mypageDto.gender == '여' ? 'checked' : ''}>
						  <label class="form-check-label" for="female">여성</label>
						</div>
	                 </div>
	             </div>
	             <div class="form-row">
	                 <div class="form-group">
	                     <label for="id">아이디:</label>
	                     <input type="text" value="${mypageDto.id}" id="id" name="id" readonly>
	                 </div>                 
	             </div>   
		         <div class="form-row">
	                 <div class="form-group">
	                     <label for="pw">새로운 비밀번호:</label>
	                     <input type="password" id="pw" name="pw" required>
	                     <br/><span id="length-msg"></span>
	                     <br/><span id="pattern-msg"></span>
	                 </div>
	                 <div class="form-group">
	                     <label for="pwchk">비밀번호 확인:</label>
	                     <input type="password" id="pwchk" name="pwchk" required>
	                     <br/><span id="msg"></span>
	                 </div>
	             </div>
	             <div class="form-row">
	             	<div class="form-group">
	             		<label for="photo">선택한 사진:</label>
		                 <img id="photo-preview" src="" alt="Photo Preview"> 
		             </div>	
		             <div class="form-group">
		                 <label for="photo">Photo:</label>	                 
		                 <input type="file" id="photo" name="photo" onchange="previewImage(event)" accept=".jpeg, .jpg, .png, .jfif">	                 	             	 
		             </div>		                          
		         </div>	
		         <div class="row mt-3">
	            	<div class="col-md-6"></div>
		            <div class="col-md-6 d-flex justify-content-end">
		           		<button id="mypageStd_go" class="btn btn-dark" type="button" onclick="detail('${mypageDto.user_code}')">취소</button>
		            	<button id="stdUpdate_fn" class="btn btn-dark" type="button" onclick="edit()">수정완료</button>
		            </div>
		        </div>
	        </form>
		</div>
		

	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>

//사진 미리보기
function previewImage(event) {
    var reader = new FileReader();
    reader.onload = function(){
        var output = document.getElementById('photo-preview');
        output.src = reader.result;
        output.style.display = 'block';
    };
    reader.readAsDataURL(event.target.files[0]);
}

// 수정버튼 (유효성 검사)
function edit(){
	
	var $email = $('input[name="email"]');
	var $phone = $('input[name="phone"]');
	var $birth = $('input[name="birth"]');
	
	if($email.val()==''){ 
		alert('이메일을 입력해주세요.');
		$email.focus(); 
	}
	else if($phone.val()==''){ 
		alert('핸드폰 번호를 입력해주세요.');
		$phone.focus(); 
	}
	else if($birth.val()==''){ 
		alert('생년월일을 입력해주세요.');
		$birth.focus(); 
	}else{
		// 이메일 유효성 검사
		var regEmail = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		if(regEmail.test($email.val())==false){			

			alert("이메일형식이 올바르지 않습니다.");

			$email.focus();

			return false;		
		}
		
		//핸드폰번호 유효성검사
		var regphone = /^(010)-?[0-9]{4}-?[0-9]{4}$/;
		if(!regphone.test($phone.val())){
			alert("핸드폰번호를 확인해주세요.");
			$phone.focus();
			return false;
		}
		else{
			$('form').submit();
		}
	
	}
}

//비밀번호 확인
$('#pwchk').on('keyup', function(){
    var pw = $('input[name="pw"]').val();
    var pwchk = $(this).val();

    if(pw === pwchk){
        $('#msg').html("☺ 비밀번호가 일치합니다.");
        $('#msg').css({'color': 'green'});
    } else {
        $('#msg').html('☹ 비밀번호가 일치하지 않습니다.');
        $('#msg').css({'color': 'red'});
    }
});

// 비밀번호 유효성검사
$('#pw').on('keyup', function(){
	var pw = $('input[name="pw"]').val();
	
	// 비밀번호 길이 확인 (8-16자)
    if (pw.length < 8 || pw.length > 16) {
        $('#length-msg').html("☹ 비밀번호는 8자 이상 16자 이하여야 합니다.");
        $('#length-msg').css({'color': 'red'});
    } else {
    	 $('#length-msg').html("☺ 비밀번호는 8자 이상 16자 이하여야 합니다.");
         $('#length-msg').css({'color': 'green'});
    }
	
 	// 비밀번호 패턴 확인 (영어, 소문자, 특수문자 포함)
    var pattern = /^(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[a-zA-Z\d!@#$%^&*(),.?":{}|<>]{8,}$/;

 
    if (!pattern.test(pw)) {
        $('#pattern-msg').html("☹ 영어 소문자, 숫자, 특수문자를 포함해야 합니다.");
        $('#pattern-msg').css({'color': 'red'});
    } else {
    	$('#pattern-msg').html("☺ 영어 소문자, 숫자, 특수문자를 포함해야 합니다.");
        $('#pattern-msg').css({'color': 'green'});
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

// 취소 버튼
function detail(user_code){
	window.location.href='/mypageStd.go?user_code='+user_code;
}
</script>
</html>