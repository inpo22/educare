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

<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- css -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css"/>
<link rel="stylesheet" href="/resources/board/board.css">
<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<style>
#courseBtn{
	display: inline-block;
    margin-right: 10px;
    float: right;
}

#writeForm {
	margin-top: 30px;
	font-size: 15px;
	font-weight: bold;
}

.writeLabel{
	margin-left: 20px;
}
.buttonCon{
	display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 20px;
}

#cancleBtn {
	background-color: gray;
	border-color: gray;
}

#attachFile {
		display: none;
}
#fileList {
	border: solid 1px lightgray;
	border-radius: 5px;
	min-height: 37px;
	height: auto;
}
#fileList li {
	list-style-type: none;
}

.writeWrap{
	display: flex;
    justify-content: space-between;
}
.fileBtnWrap{
	width: 100%;
    float: right;
}
.first-col {
	width:15%;
}
.second-col {
	width:84%;
}
#editor {
	min-height: 500px;
}

.remove-x {
	cursor: pointer;
}

#courseName{
	margin-right: 5px;
	font-size: 15px;
}

.modal-body{
	max-height: 200px; 
	overflow-y: auto;
}

#selected-course {
    width: 100%;
    border: none;
    background: none;
    outline: none;
    resize: none;
    overflow: hidden;
    text-align: center;
    margin-top: 20px;
}

.selected-course-wrapper {
    width: 100%;
    text-align: center;
    margin-bottom: 10px;
}
.modal-footer button {
    margin-left: auto;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>

	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<div class="pagetitle">
				<h1 id="BoardTitle">자료글 작성</h1>
			</div>
			<br/>
			<form action="/dataBoard/write.do" method="post" id="writeForm" enctype="multipart/form-data">
				<div id="courseBtn">
					<span id="courseName"></span>
					<input type="button" id="courseSelect" value="강의선택" class="btn btn-primary" onclick="openModal()"/>
				</div>
				<br/>
				<table class="table table-borderless">
					<tr>
						<th class="first-col">제목</th>
						<td class="second-col"><input type="text" id="titleText" name="title" class="form-control"/></td>
					</tr>
					<tr>
						<th>
							<button type="button" id="fileInputButton" class="btn btn-secondary btn-sm">파일 선택</button>
							<input type="file" name="attachFile" id="attachFile" multiple="multiple"/>
						</th>
						<td><ul id="fileList" ></ul></td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="editor"></div>
						</td>
					</tr>
				</table>
				<div class="buttonCon">
					<input type="button" id="cancleBtn" value="작성취소" class="btn btn-primary" onclick="writeCancle()"/>
					<input type="button" id="finishBtn" value="작성완료" class="btn btn-primary" onclick="writeSubmit()"/>
				</div>
				<input type="hidden" name="contents" id="content"/>
				<input type="hidden" name="fixed_yn" id="checkBox"/>
			</form>
		</div>
		<!-- End Page Title -->
	</main>
	<!-- End #main -->
	
<!-- 강의 등록 모달 -->
	<div class="modal" id="course-modal">
		<div class="modal-dialog modal-m">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title">강의선택</h3>
					<button type="button" class="btn-close" data-bs-dismiss=".modal" onclick="CloseModal()"></button>					
				</div>
				<div class="modal-body">
				    <table class="table">
				        <thead>
				        	<tr>
						      <th scope="col">강의명</th>
						      <th scope="col">강사명</th>
						      <th scope="col">강의실</th>
						    </tr>
				        </thead>
				        <tbody id="course-sel"></tbody>
				    </table>
				</div>
				<div class="modal-footer">
					<div class="selected-course-wrapper">
	                    <span><strong>선택한 강의: </strong></span>
	                    <textarea id="selected-course" readonly></textarea>
	                </div>
	                	<input type="hidden" id="post_no" name="post_no" value="${dto.post_no}"/>
						<input type="hidden" id="course_name" name="course_name"/>					
						<button id="course_reg" class="btn btn-dark">선택하기</button>
				</div>
			</div>			
		</div>
	</div>
	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
const MAX_CONTENT_SIZE = 5 * 1024 * 1024; // 5MB를 바이트로 변환

const editor = new toastui.Editor({
	   el: document.querySelector('#editor'),
	   height: '300px',
	   initialEditType: 'wysiwyg',
	   hideModeSwitch: true
	});
	editor.removeToolbarItem('code');
	editor.removeToolbarItem('codeblock');

	var fileList = [];

	$('#fileInputButton').click(function() {
		$('#attachFile').click();
	});

	$('#attachFile').change(function() {
		var files = this.files;
		for (var file of files) {
			fileList.push(file);
		}
		updateFileList();
		updateAttachFile();
	});

	function updateFileList() {
		$('#fileList').empty();
		fileList.forEach((file, index) => {
	        var li = $('<li></li>').text(file.name);
	        li.append('&nbsp;&nbsp;&nbsp;');
	        var removeBtn = $('<span></span>')
	            .html('X')
	            .addClass('remove-x')
	            .on('click', function() {
	            	fileList.splice(index, 1);
	                updateFileList();
	                updateAttachFile();
	            });
	        li.append(removeBtn);
	        $('#fileList').append(li);
	    });
	}

	function updateAttachFile() {
	    var dataTransfer = new DataTransfer();
	    fileList.forEach(file => {
	        dataTransfer.items.add(file);
	    });
	    $('#attachFile')[0].files = dataTransfer.files;
	}

	// 작성취소
	function writeCancle(){
		location.href = '/dataBoard/list.go';
	}

	// 작성완료
	function writeSubmit() {
    var editContent = editor.getHTML();
    $('#content').val(editContent);
    console.log(editor.getMarkdown());
    
    var isChecked = $('#flexSwitchCheckChecked').prop('checked');
    console.log(isChecked);
    $('#checkBox').val(isChecked ? 1 : 0);
    
    var $title = $('#titleText');
    var $content = $('#content');
    
    if ($title.val() === '') {
        alert('제목을 입력해 주세요.');
        $title.focus();
    } else if (editor.getMarkdown() === '') {
        alert('내용을 입력해 주세요.');
        editor.focus();
    } else if (new Blob([editContent]).size > MAX_CONTENT_SIZE) {
        alert('내용의 용량이 초과되었습니다. 이미지의 크기나 갯수를 줄여 주세요.');
    } else {
        var result = confirm('작성 하시겠습니까?');
        if (result) {
            alert('작성이 완료되었습니다.');
            $('form').submit();
        }
    }
}

	/* !모든 강의선택 모달 스크립트 시작! */

	function select(row) {
	    // 기존 선택된 행을 초기화
	    var rows = document.querySelectorAll('#course-sel tr');
	    rows.forEach(function(r) {
	        r.classList.remove('selected');
	    });
	    // 선택된 행에 클래스 추가
	    row.classList.add('selected');
	    
	 	// 선택된 행의 값 출력
	    var selectedCourse = {
	        course_name: row.cells[0].textContent,
	        name: row.cells[1].textContent,
	        course_space: row.cells[2].textContent
	    };
	    console.log('선택된 강의:', selectedCourse);
	    
	 // 선택된 행의 값을 텍스트 박스에 출력
	    var selectedCourse = row.cells[0].textContent + ' - ' + row.cells[1].textContent + ' - ' + row.cells[2].textContent;
	    var selectedCourseInput = document.getElementById('selected-course');
	    selectedCourseInput.value = selectedCourse;
	    
	    // 강의 명 추출 후 텍스트 박스에 입력
	    var course_name = document.getElementById('course_name');
	    course_name.value = row.cells[0].textContent;
	    
	    // 텍스트 박스 크기 조절
	    resizeTextarea(selectedCourseInput);
	}

	function resizeTextarea(textarea) {
	    textarea.style.height = 'auto';
	    textarea.style.height = textarea.scrollHeight + 'px';
	}

	// 선택하기 버튼
	$('#course_reg').click(function(){
		course_name = $('#course_name').val();
		if(course_name == ''){
			alert("강의를 선택해주세요.");
			event.preventDefault();
		}
	});

	// 강의 선택 모달 리스트 뿌리기
	function CourseSelectModal(){
		$.ajax({
			type:'post',
			url:'/board/course_modal.ajax',
			data:{
				
			},
			dataType:'json',
			success:function(data){
				console.log(data);
				drawCourseModal(data.courseList);
			},
			error:function(error){
				console.log(error);
			}
		});
	}


	//강의 선택 모달 리스트 그리기
	function drawCourseModal(CourseSelectModal){
		var content='';
		console.log(CourseSelectModal);
		
		for(data of CourseSelectModal){
			content += '<tr onclick="select(this)">';
			content += '<td>' + data.course_name + '</td>';
			content += '<td>' + data.name + '</td>';
			content += '<td>' + data.course_space + '</td>';
			content += '</tr>';
		}
		$('#course-sel').html(content);
	}

	function openModal() {
	    $('#course-modal').css('display', 'block');
	    var post_no = document.getElementById('post_no').value; 
	    CourseSelectModal(); 
	} 

	function CloseModal() {
	    $('#course-modal').css('display', 'none');
	    
	} 

	/* !모든 강의선택 모달 스크립트 끝! */
</script>
</html>















