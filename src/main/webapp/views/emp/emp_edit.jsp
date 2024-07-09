<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>사원정보수정 - 사원관리 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css" />
<jsp:include page="/views/common/head.jsp"></jsp:include>
<link href="/resources/emp/emp.css" rel="stylesheet">
<!-- js -->
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>
<script src="/resources/dept/js/deptModal_module.js"></script>

<style>
#team_btn{
	margin-left: 50px;
}
.form-select,#photo{
	width: 80%;
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
#empDetail_go{
	margin:0 7px;
}
#pw_reset{
	width:155px;
}
input[readonly] {
    background-color: white; /* 배경색 */
    /* border: none; */ /* 테두리 없앰 */
    outline: none; 
    pointer-events: none;
    font-weight: bold;
}
#status{
	width:40%;
}
#pw_msg{
	font-weight: bold;
	color: red;
}
</style>

</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard"><br/>

		<div class="pagetitle">
			<h1>사원정보 수정</h1>
		</div>
		<!-- End Page Title -->
		
		<form action="/emp/edit.do" method="post" enctype="multipart/form-data">
			<div class="form-row">
                 <div class="form-group">
                     <label for="name">성명:</label>
                     <input type="text" value="${empDto.name}" id="name" name="name" readonly>
                 </div>
                 <div class="form-group">
                     <label for="user_code">사원번호:</label>
                     <input type="text" value="${empDto.user_code}" id="user_code" name="user_code" readonly>
                 </div>                 
             </div>
             <div class="form-row">
                 <div class="form-group">
                     <label for="id">아이디:</label>
                     <input type="text" value="${empDto.id}" id="id" name="id" readonly>
                 </div>
                 <div class="form-group">
                     <label for="birth">생년월일:</label>
                     <input type="date" value="${empDto.birth}" id="birth" name="birth" required>
                 </div>
             </div>
             <div class="form-row">
                 <div class="form-group">
                     <label for="email">이메일:</label>
                     <input type="text" value="${empDto.email}" id="email" name="email" required>
                 </div>
                 <div class="form-group">
                     <label for="phone">연락처:</label>
                     <input type="text" value="${empDto.phone}" id="phone" name="phone" oninput="phoneNumber(this)" placeholder="숫자만 입력하세요">
                 </div>
             </div>
             <div class="form-row">
                 <div class="form-group">
                     <label for="team" class="team-select">부서:${empDto.team_name}</label>
                     <button id="team_btn" class="btn btn-dark" type="button" onclick="openModal()">부서 선택</button>
                     <input type="hidden" id="team_code" name="team_code" value="${empDto.team_code}"/>
                 </div>
                 <div class="form-group">
                     <label for="gender">성별:</label>
                     <div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="gender" id="male" value="남" ${empDto.gender == '남' ? 'checked' : ''}>
					  <label class="form-check-label" for="male">남성</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="gender" id="female" value="여" ${empDto.gender == '여' ? 'checked' : ''}>
					  <label class="form-check-label" for="female">여성</label>
					</div>
                 </div>
             </div>
             <div class="form-row">
            	 <div class="form-group">
                     <label for="reg_date">입사일:</label>
                     <input type="text" value="${empDto.reg_date}" id="reg_date" name="reg_date" readonly>
                 </div>
                 <div class="form-group">
                     <label for="quit_date">퇴사일:</label>
                     <input type="text" value="${empDto.quit_date}" id="quit_date" name="quit_date" readonly>
                 </div>                
             </div>
             <div class="form-row">
                 <div class="form-group">
                     <label for="email">직급:</label>
                     <select id="class_code" name="class_code" class="form-select" aria-label="Default select example">
		                  <option value="C06" ${empDto.class_name == '사원' ? 'selected' : ''}>사원</option>
				          <option value="C05" ${empDto.class_name == '대리' ? 'selected' : ''}>대리</option>
				          <option value="C04" ${empDto.class_name == '과장' ? 'selected' : ''}>과장</option>
				          <option value="C03" ${empDto.class_name == '차장' ? 'selected' : ''}>차장</option>
				          <option value="C02" ${empDto.class_name == '부장' ? 'selected' : ''}>부장</option>
				          <option value="C01" ${empDto.class_name == '대표이사' ? 'selected' : ''}>대표이사</option>
		              </select> 
                 </div>
                 <div class="form-group">
                     <label for="class">회원구분:</label>
                     <select id="classify_code" name="classify_code" class="form-select" aria-label="Default select example">
		                  <option value="U01" ${empDto.classify_name == '정규직' ? 'selected' : ''}>정규직</option>
		                  <option value="U02" ${empDto.classify_name == '계약직' ? 'selected' : ''}>계약직</option>
		              </select> 
                 </div>
             </div>   
             <div class="form-row">
                 <div class="form-group">
                     <label for="status">계정상태:</label>
				     <select id="status" name="status" class="form-select" aria-label="Default select example">
				         <option value="0" ${empDto.status == '0' ? 'selected' : ''}>정상</option>
				         <option value="1" ${empDto.status == '1' ? 'selected' : ''}>중지</option>
				     </select>
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
	            <div class="d-flex justify-content-end">
	            	<span id="pw_msg"></span><br>
	            </div>
	         </div>
	         <div class="row mt-3">
            	<div class="col-md-6"></div>
	            <div class="d-flex justify-content-end">
	                <button id="pw_reset" class="btn btn-outline-danger" type="button" onclick="reset()">비밀번호 초기화</button>
	            	<input type="hidden" id="pw" name="pw" value="${empDto.pw}"/>
	            </div>
	         </div>
	         <div class="row mt-3">
            	<div class="col-md-6"></div>
	            <div class="col-md-6 d-flex justify-content-end">
	           		<button id="empDetail_go" class="btn btn-dark" type="button" onclick="detail('${empDto.user_code}')">취소</button>
	            	<button id="empDetail_fn" class="btn btn-dark" type="button" onclick="edit()">수정완료</button>
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
	        		<button class="btn btn-primary btn-sm dept-reg">추가</button>
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
var option = {
	id: 'dept',
	treeId: '#dept-tree',
	data: [{text: '에듀케어',
		team_code: 'T000',
		team_name: '에듀케어',
		upper_code: 'T000',
		reg_date: '2002-02-02'
	}],
	modalId: 'dept-modal'
};

var treeObj = treeModule.init(option);
var deptTree = treeObj.var.tree;
treeModule.loadTree(treeObj);

/*
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
*/

var selectedNodeText = '';
var selectedNodeValue = '';

deptTree.on('select', function(e) {
		selectedNodeText = '';
		selectedNodeValue = '';
		
		$('.selected-value').removeClass('selected-value');
		
		var childIds = deptTree.getChildIds(e.nodeId);
		
		// console.log(childIds);
		
		if (childIds == '') {
			selectedNodeText = deptTree.getNodeData(e.nodeId).text;
			selectedNodeValue = deptTree.getNodeData(e.nodeId).team_code;
			
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



// 수정버튼 (유효성 검사)
var overChk = false;

function edit(){
	var $email = $('input[name="email"]');
	var $phone = $('input[name="phone"]');
	var $birth = $('input[name="birth"]');
	var $team_code = $('input[name="team_code"]');
	
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
		
		//핸드폰번호 유효성검사
		var regphone = /^(010)-?[0-9]{4}-?[0-9]{4}$/;
		if(!regphone.test($phone.val())){
			alert("핸드폰번호를 확인해주세요.");
			$phone.focus();
			return false;
		}else{
			alert("정보수정에 성공했습니다.");
			$('form').submit();
		}
	
	}
	
}

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

function detail(user_code){
	window.location.href = '/emp/detail.go?user_code='+user_code;
}

// 비밀번호 초기화
$('#pw_reset').on('click',function(){
	$('#pw').val('00000000'); // 비밀번호를 '00000000'으로 설정
	$('#pw_msg').html("수정완료 버튼을 누르면 비밀번호 00000000 으로 초기화 됩니다.")
});


</script>
</html>