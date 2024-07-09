<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>학생등록 - 학생관리 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<jsp:include page="/views/common/head.jsp"></jsp:include>
<link href="/resources/std/std.css" rel="stylesheet">
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
#name, #id {
    width: 80%;
}
#id{
	margin-left: 100px;
	width:500px;
}
/* 아이디 중복 체크 버튼 위치 조정 */
#idchk {
	margin-top:30px;
    margin-left: 10px;
    width:100px;
	height:50px;
}
label[for="id"]{
	margin-left: 100px;
}
#name,#reg_date{
	width:590px;
}
.form-select,#photo{
	width: 80%;
}
#no_btn{
	margin:10px 15px;
}
#reg_btn{
	margin:10px 0;
}
#msg,#length-msg,#pattern-msg{
	margin-left: 50px;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<div class="pagetitle">
				<h1>학생 등록</h1>
			</div>
			<!-- End Page Title -->
			
			<form action="/std/reg.do" method="post" enctype="multipart/form-data">
			<div class="form-row">
                 <div class="form-group">
                     <label for="name">성명:</label>
                     <input type="text" id="name" name="name" required>
                 </div>
                 <div class="form-group">
                     <label for="id">아이디:</label>
                     <input type="text" id="id" name="id" required>
                 </div>
                 <div class="form-group">
                     <button id="idchk" class="btn btn-dark" type="button" onclick="overlay()">중복체크</button>
                 </div>
                 
             </div>
             <div class="form-row">
                 <div class="form-group">
                     <label for="pw">비밀번호:</label>
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
                     <label for="email">이메일:</label>
                     <input type="text" id="email" name="email" required>
                     <br/><span id="email-msg"></span>
                 </div>
                 <div class="form-group">
                     <label for="phone">연락처:</label>
                     <input type="text" id="phone" name="phone" oninput="phoneNumber(this)" placeholder="숫자만 입력하세요">
                 </div>
             </div>
             <div class="form-row">
                 <div class="form-group">
                     <label for="birth">생년월일:</label>
                     <input type="date" id="birth" name="birth" required>
                 </div>
                 <div class="form-group">
                     <label for="gender">성별:</label>
                     <div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="gender" id="male" value="남">
					  <label class="form-check-label" for="male">남성</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="gender" id="female" value="여">
					  <label class="form-check-label" for="female">여성</label>
					</div>
                 </div>
             </div>
             <div class="form-row">
                 <div class="form-group">
                     <label for="reg_date">등록일:</label>
                     <input type="date" id="reg_date" name="reg_date" required>
                 </div>
             </div>
             <div class="form-row">
             	<div class="form-group">
             		<label for="photo">등록한 사진:</label>
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
	           		<button id="reg_btn" class="btn btn-dark" type="button" onclick="reg()">등록</button>
	            	<button id="no_btn" class="btn btn-dark" type="button">취소</button>
	            </div>
	        </div>	
        </form>
			
		</div>
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
// 사진 미리보기
function previewImage(event) {
    var reader = new FileReader();
    reader.onload = function(){
        var output = document.getElementById('photo-preview');
        output.src = reader.result;
        output.style.display = 'block';
    };
    reader.readAsDataURL(event.target.files[0]);
}

//학생 리스트 이동
$('#no_btn').click(function(){
	window.location.href = '/std/list.go';
});

//아이디 중복체크
var overChk = false;

function overlay(){
	var id = $('input[name="id"]').val();
	
	// 아이디 유효성 검사
    var idRegex = /^[a-zA-Z0-9]{4,12}$/;
    if (!idRegex.test(id)) {
        alert("아이디는 4글자 이상 12글자 이하, 영어 또는 숫자만 가능합니다.");
        $('input[name="id"]').focus();
        return false;
    }
	
	$.ajax({
		type:'post',
		url:'/std/overlay.ajax',
		data:{'id':id},
		dataType:'json',
		success:function(data){
			console.log(data);
			if(data.use>0){
				alert("이미 사용 중인 아이디 입니다.");
				$('input[name="id"]').val('');
				overChk = false;
			}else{
				alert("사용 가능한 아이디 입니다.");
				overChk = true;
			}
		},
		error:function(error){
			console.log(error);
		}
	});
}

//아이디 입력 필드 변경 시 중복 체크 다시 하도록 설정
$('input[name="id"]').on('input', function() {
    overChk = false;
});

//등록버튼 (유효성 검사)
function reg(){
	var $id = $('input[name="id"]'); 
	var $pw = $('input[name="pw"]');
	var $name = $('input[name="name"]');
	var $email = $('input[name="email"]');
	var $phone = $('input[name="phone"]');
	var $gender = $('input[name="gender"]:checked');
	var $birth = $('input[name="birth"]');
	var $reg_date = $('input[name="reg_date"]');
	
	if($name.val()==''){ // 이름 값이 비었을 경우
		alert('이름을 입력해주세요.');
		$name.focus(); // 커서가 이름으로	
	}else if($id.val()==''){ // 아이디 값이 비었을 경우
		alert('아이디를 입력해주세요.');
		$id.focus();
	}
	else if(overChk == false){
		alert('중복 체크를 해주세요.');
		$id.focus(); 
		return false;
	}
	else if($pw.val()==''){ // 비밀번호 값이 비었을 경우
		alert('비밀번호를 입력해주세요.');
		$pw.focus(); // 커서가 비밀번호로
	}
	else if($email.val()==''){ // 이메일 값이 비었을 경우
		alert('이메일을 입력해주세요.');
		$email.focus(); // 커서가 나이로
	}
	else if($phone.val()==''){ // 이메일 값이 비었을 경우
		alert('핸드폰 번호를 입력해주세요.');
		$phone.focus(); // 커서가 나이로
	}
	else if($birth.val()==''){ // 이메일 값이 비었을 경우
		alert('생년월일을 입력해주세요.');
		$birth.focus(); // 커서가 나이로
	}else if($gender.val()==null){ // 성별 값이 비었을 경우
		alert('성별을 체크해주세요.');
	}else if($reg_date.val()==''){ // 이메일 값이 비었을 경우
		alert('등록일을 입력해주세요.');
		$reg_date.focus(); // 커서가 나이로
	}
	else{
		// 이메일 유효성 검사
		var regEmail = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		if(regEmail.test($email.val())==false){			

			alert("이메일형식이 올바르지 않습니다.");

			$email.focus();

			return false;
		
		}
		
		// 비밀번호 유효성 검사
		var regex = /^(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$%^&*()_+={}[\]:;'"<>,./?\\|~-]).{8,16}$/;
	    
		if(!regex.test($pw.val())){
			alert("비밀번호는 8-16자리, 숫자, 소문자, 특수문자를 모두 포함해야 합니다.")
			$pw.focus();
			return false;
		}else if($pw.val().indexOf(" ") !== -1){
			alert("비밀번호는 공백을 포함할 수 없습니다.")
			$pw.focus();
			return false;
		}
		
		//핸드폰번호 유효성검사
		var regphone = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		if(!regphone.test($phone.val())){
			alert("핸드폰번호를 확인해주세요.");
			$phone.focus();
			return false;
		}
		
		// 최종 중복 체크 (등록 시 중복 체크를 다시 수행)
	    $.ajax({
	        type: 'post',
	        url: '/emp/overlay.do',
	        data: {'id': $id.val()},
	        dataType: 'json',
	        success: function(data) {
	            console.log(data);
	            if (data.use > 0) {
	                alert("이미 사용 중인 아이디 입니다. 다시 확인해주세요.");
	                $id.focus();
	                overChk = false; // 중복 체크 실패 시 false로 설정
	            } else {
	                alert("학생 등록에 성공했습니다.");
	                $('form').submit();
	            }
	        },
	        error: function(error) {
	            console.log(error);
	            overChk = false; // 에러 발생 시 false로 설정
	        }
	    });

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


// 연락처 입력 시 하이픈 자동생성
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