<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>학생 공지사항 작성 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- css -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css"/>
<link rel="stylesheet" href="/resources/board/board.css">
<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<style>
#fixedYn {
	float: right;
	margin-right: 30px;
	font-weight: bold;
}

#fixedYn, #flexSwitchCheckChecked, #fixedText:hover{
	cursor: pointer;
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
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>

	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<div class="pagetitle">
				<h1 id="BoardTitle">학생 공지글 작성</h1>
			</div>
			<br/>
			<div class="form-check form-switch" id="fixedYn">
				<input class="form-check-input" type="checkbox" id="flexSwitchCheckChecked"/>
				<label class="form-check-label" for="flexSwitchCheckChecked" id="fixedText">상단 고정 여부</label>
			</div>
			<br/>
			<form action="/stdBoard/write.do" method="post" id="writeForm" enctype="multipart/form-data">
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
		location.href = '/stdBoard/list.go';
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

// 	$('#flexSwitchCheckChecked').on('click',function(){
// 		var fixedCheck = $(this);
// 		if(fixedCheck.prop('checked')){
// 			$.ajax({
// 				url:'/fixedCheck'
// 				,type:'get'
// 				,data:{
// 					"board_no":3
// 				}
// 				,dataType:'json'
// 				,success:function(data){
// 					console.log(data);
// 					if(data.result){
// 						alert("이미 5개 이상의 상단고정 게시글이 존재합니다.");
// 						fixedCheck.prop('checked',false);
// 					}
// 				}
// 				,error:function(error){
// 					console.log(error);
// 				}
// 			});
// 		}
// 	});
</script>
</html>















