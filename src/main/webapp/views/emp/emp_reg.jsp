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
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css" />
<jsp:include page="/views/common/head.jsp"></jsp:include>
<link href="/resources/emp/emp.css" rel="stylesheet">
<!-- js -->
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>

<style>
#msg,#length-msg,#pattern-msg,#email-msg{
	margin-left: 50px;
}

#team_btn{
	margin-left: 50px;
}
#no_btn{
	margin:10px 15px;
}
#reg_btn{
	margin:10px 0;
}
.form-select,#photo{
	width: 80%;
}
h1{
	margin:10px 20px;
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
    width: 70%;
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
#name{
	width:590px;
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
                     <label for="team" class="team-select">부서:</label>
                     <button id="team_btn" class="btn btn-dark" type="button" onclick="openModal()">부서 선택</button>
                     <input type="hidden" id="team_code" name="team_code"/>
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

	<!-- 받는 사람 모달 -->
	<div id="dept-modal" class="modal" onclick="closeModal()">
		<div class="modal-content" onclick="event.stopPropagation()">
			<div>
				<span class="modal-title">부서 등록</span>
	        	<span class="close" onclick="closeModal()">&times;</span>
	        	<br/><br/>
	        	<div id="dept-tree" class="tui-tree-wrap"></div>
	        	<br/>
	        	<div class="text-align-right">
	        		<button class="btn btn-primary btn-sm dept-reg disabled-button">추가</button>
	        	</div>
			</div>
	    </div>
	</div>
	
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



// 부서 등록 모달 창 열기
function openModal() {
    $('#dept-modal').css('display', 'block');
}

// 모달 창 닫기
function closeModal() {
    $('.modal').css('display', 'none');
	selectedNodeText = '';
	selectedNodeValue = '';
	$('.tui-tree-selected').removeClass('tui-tree-selected');
	$('.dept-reg').addClass('disabled-button');
}

// 부서 Tree
var data = [{
	text: '에듀케어',
	value: 'T000'
}];

const tree = new tui.Tree('#dept-tree', {
	data: data,
	nodeDefaultState: 'opened'
	
});

$.ajax({
	type:'get',
	url:'/emp/deptList.ajax',
	data:{},
	dataType:'JSON',
	success:function(data) {
		var rootNode = tree.getRootNodeId();
		var valueToFind = '';
		
		for (var item of data.deptList) {
			valueToFind = item.upper_code;
			var foundNode = findNodeByValue(rootNode, valueToFind);
			
			if (foundNode) {
				tree.add({text: item.team_name, value: item.team_code}, foundNode);
			}
		}
	},
	error:function(error) {
		console.log(error);
	}
});

function findNodeByValue(node, value) {
	
	if (tree.getNodeData(node).value == value) {
		return node;
    }

    var children = tree.getChildIds(node);
    for (var i = 0; i < children.length; i++) {
        var found = findNodeByValue(children[i], value);
        if (found) {
			return found;
		}
    }
    
    return null;
}

var selectedNodeText = '';
var selectedNodeValue = '';

tree
	.enableFeature('Selectable')
	.on('select', function(e) {
		selectedNodeText = '';
		selectedNodeValue = '';
		
		$('.selected-value').removeClass('selected-value');
		
		var childIds = tree.getChildIds(e.nodeId);
		
		// console.log(childIds);
		
		if (childIds == '') {
			selectedNodeText = tree.getNodeData(e.nodeId).text;
			selectedNodeValue = tree.getNodeData(e.nodeId).value;
			
			// console.log('테스트 완료');
			$('.dept-reg').removeClass('disabled-button');
		} else {
			selectedNodeText = '';
			selectedNodeValue = '';
			
			$('.dept-reg').addClass('disabled-button');
		}
		
		// console.log('nodeText : ' + selectedNodeText);
		// console.log('nodeValue : ' + selectedNodeValue);
		
});

$('.dept-reg').click(function() {
	var content = '부서: ' + selectedNodeText;
	
	$('.team-select').html(content);
	$('#team_code').val(selectedNodeValue);
	closeModal();
});





//아이디 중복체크
var overChk = false;
overChk = true;

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

// 등록버튼 (유효성 검사)
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
	var $team_code = $('input[name="team_code"]');
	
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
	}else if($team_code.val()==''){ // 이메일 값이 비었을 경우
		alert('부서를 선택해주세요.');
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
		}else{
			alert("사원 등록에 성공했습니다.");
			$('form').submit();
		}

	}
	
}


// 비밀번호 확인
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

//사원 리스트 이동
$('#no_btn').click(function(){
	window.location.href = '/emp/list.go';
});

</script>
</html>