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
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css"/>
<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<style>
#backBoard{
	background-color: white;
	width: 60%;
	border-radius: 20px;
	padding: 20px 0;
}

#allBoardTitle{
	margin-left: 20px;
}

#fixedYn {
	float: right;
	margin-right: 30px;
	font-weight: bold;
}

#writeForm {
	margin-top: 30px;
	font-size: 15px;
	font-weight: bold;
}

.writeLabel{
	margin-left: 20px;
}

input[type=text] {
	float:right;
	margin-right: 30px;	
	width: 50%;
}



#fileList {
	float:right;
	margin-right: 30px;	
	width: 50%;
}

#fileInputButton {
	float:right;
	margin-right: 30px;
	margin-top: 10px;
}

#editor {
	margin-left: 20px;
	margin-right: 30px;
	margin-top: 10px;
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
	border: solid 1px gray;
	border-radius: 5px;
	min-height: 28px;
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
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>

	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<div class="pagetitle">
				<h1 id="allBoardTitle">전사 공지글 작성</h1>
			</div>
			<br/>
			<div class="form-check form-switch" id="fixedYn">
				<input class="form-check-input" type="checkbox" id="flexSwitchCheckChecked"/>
				<label class="form-check-label" for="flexSwitchCheckChecked">상단 고정 여부</label>
			</div>
			<br/>
			<form action="/allBoard/write.do" method="post" id="writeForm" enctype="multipart/form-data">
				<div>
					<label class="writeLabel">제목</label>
					<input type="text" id="titleText" name="title" maxlength="30"/>
				</div>	
				<br/><br/>
				<div class="writeWrap">
					<label class="writeLabel">파일 첨부</label>
					<ul id="fileList"></ul>
				</div>
				<div class="fileBtnWrap">
					<button type="button" id="fileInputButton" class="btn btn-secondary btn-sm">파일 선택</button>
				</div>
				<input type="file" name="attachFile" id="attachFile" multiple="multiple"/>
				<br/><br/><br/>
				<div id="editor"></div>
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

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
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
		location.href = '/allBoard/list.go';
	}

	// 작성완료
	function writeSubmit(){
		var editContent = editor.getHTML()+'';
		$('#content').val(editContent);
		console.log(editor.getMarkdown());
		var isChecked = $('#flexSwitchCheckChecked').prop('checked');
		console.log(isChecked);
		if(isChecked == true){
			$('#checkBox').val(1);		
		}else{
			$('#checkBox').val(0);
		}
		var $title = $('#titleText');
		var $content = $('#content');
		if($title.val() == ''){
			alert('제목을 입력해 주세요.');
			$title.focus();
		}else if(editor.getMarkdown() == ''){
			alert('내용을 입력해 주세요.');
			editor.focus();
		}else{
			var result = confirm('작성 하시겠습니까?');
			if (result) {
				alert('작성이 완료되었습니다.');
				$('form').submit();
			}
		}
	}
</script>
</html>















