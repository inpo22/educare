<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>학생 자료실 작성</title>
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

#course-sel tr:hover{
	cursor:pointer;
}

.selected-row {
    background-color: #cce5ff !important; /* 선택된 행의 배경색 */
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
				<br/>
				<table class="table table-borderless">
					<tr>
						<th class="first-col">제목</th>
						<td class="second-col"><input type="text" id="titleText" name="title" class="form-control" maxlength="30"/></td>
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
			</form>
		</div>
		<!-- End Page Title -->
	</main>
	<!-- End #main -->
	
	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
const MAX_CONTENT_SIZE = 5 * 1024 * 1024; // 5MB를 바이트로 변환
const editorSize = 1 * 1024 * 1024;

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
	      var inputFiles = $("#attachFile")[0].files;
	      // console.log(inputFiles);
	      
	      for (var item of inputFiles) {
	         var fileSize = item.size;//업로드한 파일용량
	         // console.log(fileSize);
	         if (fileSize > MAX_CONTENT_SIZE) {
	            alert("파일은 5MB 이하의 파일만 첨부할 수 있습니다.");
	            return false;
	         }
	      }
	      
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
		var result = confirm('작성을 취소하시겠습니까?');
		if(result){
			location.href = '/dataBoard/list.go';	
		}
	}

// 작성완료
function writeSubmit() {
    var editContent = editor.getHTML();
    $('#content').val(editContent);
    console.log(editor.getMarkdown());
    
    var $title = $('#titleText');
    var $content = $('#content');
    
    if ($title.val() === '') {
        alert('제목을 입력해 주세요.');
        $title.focus();
    } else if (editor.getMarkdown() === '') {
        alert('내용을 입력해 주세요.');
        editor.focus();
    } else if (new Blob([editContent]).size > editorSize) {
        alert('내용의 용량이 초과되었습니다. 이미지의 크기나 갯수를 줄여 주세요.');
    } else {
        var result = confirm('작성 하시겠습니까?');
        if (result) {
            alert('작성이 완료되었습니다.');
            $('form').submit();
        }
    }
}
</script>
</html>















