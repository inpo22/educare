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
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css" />
<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>

<style>
	.display-flex {
		display: flex;
	}
	#left-section {
		width: 15%;
		height: 100%;
	}
	#right-section {
		width: 84%;
		height: 100%;
		background-color: white;
		padding: 30px;
	}
	a {
		color: black;
	}
	.table-left-section {
		width: 96%;
		height: 100%;
	}
	.table-right-section {
		width: 3%;
		height: 100%;
	}
	#second-sidebar td {
		padding: 5px 0;
	}
	.first-col {
		width: 15%;
	}
	.second-col {
		width: 74%;
	}
	.table-bordered th {
		text-align: center;	
	}
	.text-align-center {
		text-align: center;
	}
	.text-align-right {
		text-align: right;
	}
	#subject {
		width: 100%;
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
	.remove-x {
		color: gray;
		cursor: pointer;
	}
	.remove-x:hover {
		color: black;
	}
	.modal {
	    display: none;
	    position: fixed;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    overflow: auto;
	    background-color: rgba(0,0,0,0.4);
	}
	.modal-content {
	    margin: 0 auto;
	    padding: 20px;
	    height: 600px;
	    width: 900px;
	    top: 150px;
	    background-color: white;
	}
	.close {
	    color: #aaa;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	}
	.close:hover {
	    color: black;
	    text-decoration: none;
	    cursor: pointer;
	}
	.modal-title {
		font-weight: bold;
		font-size: 25px;
	}
	.tui-tree-wrap {
		height: 450px;
		overflow-y: auto;
	}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div class="display-flex">
			<div id="left-section">
				<div class="pagetitle">
					<h1>메일</h1>
				</div>
				<button class="btn btn-primary btn-newMail">메일 작성</button>
				<br/><br/><br/>
				<table id="second-sidebar">
					<tr>
						<td><a href="/receivedMail/list.go">받은 메일함</a></td>
					</tr>
					<tr>
						<td><a href="/writtenMail/list.go">보낸 메일함</a></td>
					</tr>
				</table>
			</div>
			<div id="right-section">
				<div class="pagetitle text-align-center">
					<h1>메일 작성</h1>
				</div>
				<br/><br/><br/><br/>
				<form action="/mail/write.do" method="post" enctype="multipart/form-data">
					<table class="table table-bordered">
						<tr>
							<th class="table-active first-col">받는 사람</th>
							<td class="second-col">
								<div class="display-flex">
									<div class="table-left-section"></div>
									<div class="table-right-section"><button class="btn btn-secondary btn-sm" type="button" onclick="openReceiverModal()">+</button></div>
								</div>
							</td>
						</tr>
						<tr>
							<th class="table-active">참조</th>
							<td>
								<div class="display-flex">
									<div class="table-left-section"></div>
									<div class="table-right-section"><button class="btn btn-secondary btn-sm" type="button" onclick="openCcModal()">+</button></div>
								</div>
							</td>
						</tr>
						<tr>
							<th class="table-active">제목</th>
							<td>
								<input type="text" name="subject" id="subject"/>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div id="editor"></div>
							</td>
						</tr>
					</table>
					<table class="table table-borderless">
						<tr>
							<th class="first-col text-align-center">
								<button type="button" id="fileInputButton" class="btn btn-secondary btn-sm">파일 첨부</button>
							</th>
							<td class="second-col">
								<ul id="fileList"></ul>
							</td>
						</tr>
					</table>
					<input type="file" name="attachFile" id="attachFile" multiple="multiple"/>
					<input type="hidden" name="receiverList" id="receiverList"/>
					<input type="hidden" name="ccList" id="ccList"/>
					<input type="hidden" name="content" id="content"/>
					<br/>
					<div class="text-align-right">
						<button class="btn btn-primary btn-sm" onclick="submut()" type="button">발송</button>
						&nbsp;&nbsp;
						<button class="btn btn-secondary btn-sm" onclick="mailList()" type="button">취소</button>
					</div>
				</form>
				
				
			</div>
		</div>
	</main>
	<!-- End #main -->
	
	<!-- 받는 사람 모달 -->
	<div id="emp-modal" class="modal" onclick="closeModal()">
		<div class="modal-content" onclick="event.stopPropagation()">
			<div>
				<span class="modal-title">받는 사람 추가</span>
	        	<span class="close" onclick="closeModal()">&times;</span>
	        	<br/><br/>
	        	<div id="dept-tree" class="tui-tree-wrap"></div>
			</div>
	    </div>
	</div>
	
	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
	const editor = new toastui.Editor({
		el: document.querySelector('#editor'),
		height: '500px',
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
	
	// 받는 사람 모달 창 열기
	function openReceiverModal() {
	    $('#emp-modal').css('display', 'block');
	    $('.modal-title').html('받는 사람 추가');
	}
	
	// 참조 모달 창 열기
	function openCcModal() {
	    $('#emp-modal').css('display', 'block');
	    $('.modal-title').html('참조 추가');
	}
	
	// 모달 창 닫기
	function closeModal() {
	    $('.modal').css('display', 'none');
	}
	
	// 부서 Tree
	var data = [{
		text: '에듀케어',
		value: 'T00'
	}];
	
	const tree = new tui.Tree('#dept-tree', {
		data: data,
		nodeDefaultState: 'opened',
	});
	
	$.ajax({
		type:'get',
		url:'/mail/deptList.ajax',
		data:{},
		dataType:'JSON',
		success:function(data) {
			var rootNode = tree.getRootNodeId();
			
			for (var item of data.deptList) {
				var valueToFind = item.upper_code;
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
	
	function submit() {
		var editorContent = editor.getHTML();
		$('#content').val(editorContent);
	}
	
	function mailList() {
		location.href = '/receivedMail/list.go';
	}
	
	


</script>
</html>