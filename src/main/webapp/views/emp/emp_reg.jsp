<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
#team_btn{
	margin-left: 50px;
}
body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}
#no_btn{
	margin:0 10px;
}
#backBoard{
	background-color: white;
	width:100%;
	height:1000px;
	border-radius: 10px;
	position: relative;
	margin: 20px auto;
	box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}
.form-select,#photo{
	width: 80%;
}
#photo-preview{
	display: none;
	width : 250px;
	height:250px;
	margin:0 0 0 200px;
}
h1{
	margin:10px 20px;
}
.btn_group{
	display: flex;
	position: absolute;
	bottom: 20px;
    right: 20px; 
}

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
    width: 90%;
}
#id{
	margin-left: 110px;
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
	margin-left: 110px;
}
#name{
	width:600px;
}
</style>

</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard"><br/>

		<div class="pagetitle">
			<h1>사원 등록</h1>
		</div>
		<!-- End Page Title -->
		
		<form action="/emp/reg.do" method="post" enctype="multipart/form-data">
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
                 </div>
                 <div class="form-group">
                     <label for="pwchk">비밀번호 확인:</label>
                     <input type="password" id="pwchk" name="pwchk" required>
                     <span id="msg"></span>
                 </div>
             </div>
             <div class="form-row">
                 <div class="form-group">
                     <label for="email">이메일:</label>
                     <input type="text" id="email" name="email" required>
                 </div>
                 <div class="form-group">
                     <label for="phone">연락처:</label>
                     <input type="text" id="phone" name="phone" required>
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
                     <label for="email">직급:</label>
                     <select id="class_code" name="class_code" class="form-select" aria-label="Default select example">
		                  <option value="C06">사원</option>
		                  <option value="C05">대리</option>
		                  <option value="C04">과장</option>
		                  <option value="C03">차장</option>
		                  <option value="C02">부장</option>
		                  <option value="C01">대표이사</option>
		              </select> 
                 </div>
                 <div class="form-group">
                     <label for="class">회원구분:</label>
                     <select id="classify_code" name="classify_code" class="form-select" aria-label="Default select example">
		                  <option value="U01">정규직</option>
		                  <option value="U02">계약직</option>
		              </select> 
                 </div>
             </div>
             <div class="form-row">
                 <div class="form-group">
                     <label for="reg_date">입사일:</label>
                     <input type="date" id="reg_date" name="reg_date">
                 </div>
                 <div class="form-group">
                     <label for="team">부서:</label>
                     <button id="team_btn" class="btn btn-dark" type="button">부서 선택</button>
                     
                 </div>
             </div>
             <div class="form-row">
             	<div class="form-group">
             		<label for="photo">등록한 사진:</label>
	                 <img id="photo-preview" src="" alt="Photo Preview"> 
	             </div>	
	             <div class="form-group">
	                 <label for="photo">Photo:</label>	                 
	                 <input type="file" id="photo" name="photo" onchange="previewImage(event)">	                 	             	 
	             </div>
	                          
	         </div>	
	         <div class="btn_group">
        	<button id="reg_btn" class="btn btn-dark" type="button" onclick="reg()">등록</button>
        	<button id="no_btn" class="btn btn-dark" type="button">취소</button>
        </div>	
        </form>
        
        
		
		
		
		</div>
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
var msg = '${msg}'; // 쿼터 빠지면 넣은 문구가 변수로 인식됨.
if(msg != ''){
	alert(msg);
}


function previewImage(event) {
    var reader = new FileReader();
    reader.onload = function(){
        var output = document.getElementById('photo-preview');
        output.src = reader.result;
        output.style.display = 'block';
    };
    reader.readAsDataURL(event.target.files[0]);
}

//아이디 중복체크
var overChk = false;
overChk = true;

function overlay(){
	var id = $('input[name="id"]').val();
	
	$.ajax({
		type:'post',
		url:'/emp/overlay.do',
		data:{'id':id},
		dataType:'json',
		success:function(data){
			console.log(data);
			if(data.use>0){
				alert("이미 사용 중인 아이디 입니다.");
				$('input[name="id"]'.val(''));
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

// 등록버튼
var overChk = false;

function reg(){
	var $id = $('input[name="id"]'); 
	var $pw = $('input[name="pw"]');
	var $name = $('input[name="name"]');
	var $email = $('input[name="email"]');
	var $phone = $('input[name="phone"]');
	var $gender = $('input[name="gender"]:checked');
	var $class = $('#class');
	var $classify = $('#classify');
	var $birth = $('input[name="birth"]');
	var $reg_date = $('input[name="reg_date"]');
	
	if(overChk == false){
		alert('중복 체크를 해주세요.');
		$id.focus(); 
		return false;
	}else if($name.val()==''){ // 이름 값이 비었을 경우
		alert('이름을 입력해주세요.');
		$name.focus(); // 커서가 이름으로
	}
	else if($id.val()==''){ // 아이디 값이 비었을 경우
		alert('아이디를 입력해주세요.');
		$id.focus();
	}else if($pw.val()==''){ // 비밀번호 값이 비었을 경우
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
	}else if($class.val()==''){ // 이메일 값이 비었을 경우
		alert('직급을 입력해주세요.');
		$class.focus(); // 커서가 나이로
	}else if($classify.val()==''){ // 이메일 값이 비었을 경우
		alert('회원구분을 입력해주세요.');
		$classify.focus(); // 커서가 나이로
	}else if($reg_date.val()==''){ // 이메일 값이 비었을 경우
		alert('입사일을 입력해주세요.');
		$reg_date.focus(); // 커서가 나이로
	}else{
		var regex = /^(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$%^&*()_+={}[\]:;'"<>,./?\\|~-]).{8,16}$/;
	    
		if(!regex.test($pw.val())){
			alert("비밀번호는 8-16자리, 숫자, 소문자, 특수문자를 모두 포함해야 합니다.")
			$pw.focus();
			return false;
		}else if($pw.val().indexOf(" ") !== -1){
			alert("비밀번호는 공백을 포함할 수 없습니다.")
			$pw.focus();
			return false;
		}else{
			$('form').submit();
		}

	}
	
}



// 비밀번호 확인
// 비밀번호 확인
$('#pwchk').on('keyup', function(){
    var pw = $('input[name="pw"]').val();
    var pwchk = $(this).val();

    if(pw === pwchk){
        $('#msg').html("비밀번호가 일치합니다.");
        $('#msg').css({'color': 'green'});
    } else {
        $('#msg').html('비밀번호가 일치하지 않습니다.');
        $('#msg').css({'color': 'red'});
    }
});

</script>
</html>