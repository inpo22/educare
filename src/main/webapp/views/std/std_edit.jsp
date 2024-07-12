<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>학생정보수정 - 학생관리 - 에듀케어</title>
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
input[readonly] {
    background-color: white; /* 배경색 */
    /* border: none; */ /* 테두리 없앰 */
    outline: none; 
    pointer-events: none;
    font-weight: bold;
}
#pw_msg{
	font-weight: bold;
	color: red;
}
#pw_reset{
	width:155px;
}
#stdDetail_go{
	margin:0 7px;
}
#status{
	width:80%;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<div class="pagetitle">
				<h1><a href="/std/list.go">학생 정보 수정</a></h1>
			</div>
			<!-- End Page Title -->
			
			<form action="/std/edit.do" method="post">
				<div class="form-row">
	                 <div class="form-group">
	                     <label for="name">성명:</label>
	                     <input type="text" value="${stdDto.name}" id="name" name="name" readonly>
	                 </div>
	                 <div class="form-group">
	                     <label for="user_code">학생번호:</label>
	                     <input type="text" value="${stdDto.user_code}" id="user_code" name="user_code" readonly>
	                 </div>                 
	             </div>
	             <div class="form-row">
	                 <div class="form-group">
	                     <label for="email">이메일:</label>
	                     <input type="text" value="${stdDto.email}" id="email" name="email" required>
	                 </div>
	                 <div class="form-group">
	                     <label for="phone">연락처:</label>
	                     <input type="text" value="${stdDto.phone}" id="phone" name="phone" oninput="phoneNumber(this)" placeholder="숫자만 입력하세요">
	                 </div>
	             </div>
	             <div class="form-row">
	                 <div class="form-group">
	                     <label for="birth">생년월일:</label>
	                     <input type="date" value="${stdDto.birth}" id="birth" name="birth" required>
	                 </div>
	                 <div class="form-group">
	                     <label for="gender">성별:</label>
	                     <div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="gender" id="male" value="남" ${stdDto.gender == '남' ? 'checked' : ''}>
						  <label class="form-check-label" for="male">남성</label>
						</div>
						<div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="gender" id="female" value="여" ${stdDto.gender == '여' ? 'checked' : ''}>
						  <label class="form-check-label" for="female">여성</label>
						</div>
	                 </div>
	             </div>
	             <div class="form-row">
	                 <div class="form-group">
	                     <label for="id">아이디:</label>
	                     <input type="text" value="${stdDto.id}" id="id" name="id" readonly>
	                 </div>
	                 <div class="form-group">
	                     <label for="status">계정상태:</label>
					     <select id="status" name="status" class="form-select" aria-label="Default select example">
					         <option value="0" ${stdDto.status == '0' ? 'selected' : ''}>정상</option>
					         <option value="1" ${stdDto.status == '1' ? 'selected' : ''}>중지</option>
					     </select>
	                 </div>	                 
	             </div>   
		         <div class="row mt-3">
	            	<div class="col-md-6"></div>
		            <div class="d-flex justify-content-end">
		            	<span id="pw_msg"></span><br>
		            </div>
		         </div>
		         <div class="row mt-3">
	            	<div class="col-md-6"></div>
		            <div class="d-flex justify-content-end">
		                <button id="pw_reset" class="btn btn-outline-danger" type="button" onclick="reset()">비밀번호 초기화</button>
		            	<input type="hidden" id="pw" name="pw" value="${stdDto.pw}"/>
		            </div>
		         </div>
		         <div class="row mt-3">
	            	<div class="col-md-6"></div>
		            <div class="col-md-6 d-flex justify-content-end">
		           		<button id="stdDetail_go" class="btn btn-secondary" type="button" onclick="detail('${stdDto.user_code}')">취소</button>
		            	<button id="stdDetail_fn" class="btn btn-primary" type="button" onclick="edit()">수정완료</button>
		            </div>
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

//비밀번호 초기화
$('#pw_reset').on('click',function(){
	$('#pw').val('00000000'); // 비밀번호를 '00000000'으로 설정
	$('#pw_msg').html("수정완료 버튼을 누르면 비밀번호 00000000 으로 초기화 됩니다.")
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

//수정버튼 (유효성 검사)
function edit(){
	var $email = $('input[name="email"]');
	var $phone = $('input[name="phone"]');
	var $birth = $('input[name="birth"]');
	
	if($email.val()==''){ // 이메일 값이 비었을 경우
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
	}
	else{
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
			alert("정보수정에 성공했습니다.");
			$('form').submit();
		}
	
	}
	
}

// 취소버튼 클릭
function detail(user_code){
	window.location.href = '/std/detail.go?user_code='+user_code;
}
</script>
</html>