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
	.second-sidebar td {
		padding: 5px 0;
	}
	a {
		color: black;
	}
	.blue-color {
		color: rgb(88, 88, 255);
		cursor: pointer;
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
	.display-grid {
		display: grid;
		grid-auto-flow: column;
		grid-template-columns: 1fr;
	}
	.display-inline {
		display: inline;
	}
	.vertical-align-bottom {
		vertical-align: bottom;
		height: 78px;
	}
	.top-table-first-col {
		width: 100px;
	}
	.top-table-second-col {
		width: 200px;
	}
	.order-first-col {
		width: 30px;
		vertical-align: middle;
	}
	.order-second-col {
		width: 120px;
	}
	.order-third-row {
		height: 39px;
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
	.tui-tree-wrap, .modal-add-list, .approval-type-list {
		height: 400px;
		width: 360px;
		overflow-y: auto;
	}
	.modal-add-list, .approval-type-list {
		background-color: #f9f9f9;
		padding: 20px;
	}
	.modal-inner-button {
		height: 400px;
		width: 100px;
		display: flex;
		align-items: center;
		justify-content: center;
		white-space: pre-line;
	}
	.modal-inner-button-child {
		display: block;
	}
	.list-add-button, .list-remove-button {
		width: 30px;
	}
	.disabled-button {
		pointer-events: none;
      	opacity: 0.5;
      	cursor: not-allowed; 
	}
	.add-list, .approval-type-list ul {
		list-style-type: none;
	}
	.add-list li, .approval-type-list li {
		cursor: pointer;
		padding-left: 10px;
	}
	.add-list li:hover, .approval-type-list li:hover {
		background-color: rgba(75, 150, 230, 0.1);
		background: #e7eff7;
	}
	.selected-value {
		background-color: rgba(75, 150, 230, 0.1);
		background: #e7eff7;
		color: #4b96e6;
	}
	.right-padding {
		padding-right: 40px;
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
					<h1>전자 결재</h1>
				</div>
				<button class="btn btn-primary btn-newApproval">새 결재 작성</button>
				<br/><br/><br/>
				<table class="second-sidebar">
					<tr>
						<td><b>결재하기</b></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/getApproval/list.go">결재 요청 받은 문서</a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/compApproval/list.go">결재 완료한 문서</a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/viewApproval/list.go">열람 가능한 문서</a></td>
					</tr>
				</table>
				<br/>
				<table class="second-sidebar">
					<tr>
						<td><b>상신한 결재</b></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/requestApproval/list.go">결재 요청한 문서</a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/finishApproval/list.go">결재 완료된 문서</a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/rejectedApproval/list.go">반려된 문서</a></td>
					</tr>
				</table>
			</div>
			<div id="right-section">
				<div class="pagetitle text-align-center">
					<h1>휴가 신청서</h1>
				</div>
				<br/>
				<div class="text-align-right"><span class="blue-color" onclick="openModal()"><b>+ 결재선 추가</b></span></div>
				<form action="/vacaApproval/write.do" method="post" enctype="multipart/form-data">
					<div class="display-grid">
						<table class="table table-bordered display-inline">
							<tr>
								<th class="table-active top-table-first-col">기안자</th>
								<td class="text-align-center top-table-second-col">${sessionScope.user_name}&nbsp;${sessionScope.class_name}</td>
							</tr>
							<tr>
								<th class="table-active">부서</th>
								<td class="text-align-center">${sessionScope.team_name}</td>
							</tr>
							<tr>
								<th class="table-active">기안일</th>
								<td></td>
							</tr>
							<tr>
								<th class="table-active">문서 번호</th>
								<td></td>
							</tr>
						</table>
						<table class="table table-bordered display-inline text-align-right">
							<tr>
								<th class="table-active order-first-col" rowspan="3">신<br/><br/>청</th>
								<td class="text-align-center order-second-col">${sessionScope.class_name}</td>
							</tr>
							<tr>
								<td class="text-align-center vertical-align-bottom">${sessionScope.user_name}</td>
							</tr>
							<tr>
								<td class="order-third-row"></td>
							</tr>
						</table>
					</div>
					<table class="table table-bordered">
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
					<input type="hidden" name="orderList" id="orderList"/>
					<input type="hidden" name="content" id="content"/>
					<br/>
					<div class="text-align-right">
						<button class="btn btn-primary btn-sm" onclick="approvalSubmit()" type="button">발송</button>
						&nbsp;&nbsp;
						<button class="btn btn-secondary btn-sm" onclick="approvalList()" type="button">취소</button>
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
				<span class="modal-title">결재선 추가</span>
	        	<span class="close" onclick="closeModal()">&times;</span>
	        	<br/><br/>
	        	<div class="display-flex">
	        		<div id="dept-tree" class="tui-tree-wrap"></div>
		        	<div class="modal-inner-button">
		        		<div class="modal-inner-button-child">
		        			<button class="btn btn-secondary btn-sm list-add-button disabled-button">&rsaquo;</button>
		        			<br/>
		        			<button class="btn btn-secondary btn-sm list-remove-button disabled-button">&lsaquo;</button>
		        		</div>
		        	</div>
		        	<div class="modal-add-list">
		        		<ul class="add-list"></ul>
		        	</div>
	        	</div>
	        	<br/>
	        	<div class="text-align-right right-padding">
	        		<button class="btn btn-primary btn-sm send-list">추가</button>
	        	</div>
			</div>
	    </div>
	</div>
	
	<jsp:include page="/views/common/footer.jsp"></jsp:include>
	<jsp:include page="/views/common/newApproval_modal.jsp"></jsp:include>
	
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
	
	// 결재선 모달 창 열기
	function openModal() {
	    $('#emp-modal').css('display', 'block');
	    $('.modal-content').css('width', '900px');
	}
	
	// 모달 창 닫기
	function closeModal() {
	    $('.modal').css('display', 'none');
	    orderTextList = [];
	    orderValueList = [];
		selectedNodeText = '';
		selectedNodeValue = '';
		removeTag = '';
		removeNodeValue = '';
		removeNodeText = '';
		$('.list-add-button').addClass('disabled-button');
		$('.list-remove-button').addClass('disabled-button');
		$('.tui-tree-selected').removeClass('tui-tree-selected');
		$('.add-list').empty();
		$('.modal-content').css('width', '400px');
	}
	
	// 부서 Tree
	var data = [{
		text: '에듀케어',
		value: 'T00'
	}];
	
	const tree = new tui.Tree('#dept-tree', {
		data: data,
		nodeDefaultState: 'opened'
	});
	
	$.ajax({
		type:'get',
		url:'/approval/deptList.ajax',
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
			
			for (var item of data.empList) {
				valueToFind = item.team_code;
				var foundNode = findNodeByValue(rootNode, valueToFind);
				
				if (foundNode) {
					tree.add({text: item.user_name + ' ' + item.class_name, value: item.user_code}, foundNode);
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
	
	var orderTextList = [];
	var orderValueList = [];
	var selectedNodeText = '';
	var selectedNodeValue = '';
	var removeTag = '';
	var removeNodeText = '';
	var removeNodeValue = '';
	
	tree
		.enableFeature('Selectable')
		.on('select', function(e) {
			selectedNodeText = '';
			selectedNodeValue = '';
			
			$('.selected-value').removeClass('selected-value');
			
			if (tree.getChildIds(e.nodeId) == '') {
				selectedNodeText = tree.getNodeData(e.nodeId).text;
				selectedNodeValue = tree.getNodeData(e.nodeId).value;
				$('.receiver-add-button').removeClass('disabled-button');
			}
			// console.log('nodeText : ' + selectedNodeText);
			// console.log('nodeValue : ' + selectedNodeValue);
			
	});
	
	$('.list-add-button').click(function() {
		
		var content = '<li class="value-' + selectedNodeValue + '">' + selectedNodeText + '</li>';
		
		if (!receiverValueList.includes(selectedNodeValue)) {
			orderTextList.push(selectedNodeText);
			orderValueList.push(selectedNodeValue);
			$('.add-list').append(content);
		}
		
		$('.list-add-button').addClass('disabled-button');
		$('.tui-tree-selected').removeClass('tui-tree-selected');
		selectedNodeText = '';
		selectedNodeValue = '';
	});
	
	$('.add-list').on('click', 'li', function(e) {
		removeNodeText = '';
		removeTag = '';
		removeNodeValue = '';
		
		$('.tui-tree-selected').removeClass('tui-tree-selected');
		$('.selected-value').removeClass('selected-value');
		removeTag = $(this);
		// console.log(e);
		removeNodeText = $(this).html();
		removeNodeValue = e.target.className.substring(6);
		// console.log(removeNodeValue);
		$(this).addClass('selected-value');
		$('.list-remove-button').removeClass('disabled-button');
	});
	
	$('.list-remove-button').click(function() {
		var index = orderValueList.indexOf(removeNodeValue);
		orderValueList.splice(index, 1);
		
		index = orderTextList.indexOf(removeNodeText);
		orderTextList.splice(index, 1);
		
		removeTag.remove();
		
		removeNodeText = '';
		removeTag = '';
		removeNodeValue = '';
		$('.selected-value').removeClass('selected-value');
		$('.list-remove-button').addClass('disabled-button');
	});
	
	$('.send-list').click(function() {
		var content = '';
		for (var item of orderTextList) {
			content += '<span class="badge bg-primary">' + item + '</span>&nbsp;&nbsp;';
		}
		$('.receiver-visual').html(content);
		
		$('#orderList').val(orderValueList.toString());
		closeModal();
	});
	
	function approvalSubmit() {
		var editorContent = editor.getHTML();
		$('#content').val(editorContent);
		
		var $subject = $('#subject');
		var $content = $('#content');
		var $orderList = $('#orderList');
		
		if ($subject.val() == '') {
			alert('제목을 입력해주세요.');
			$subject.focus();
		} else if ($content.val() == '') {
			alert('내용을 입력해주세요.');
			$('#editor').focus();
		} else if ($orderList.val() == '') {
			alert('결재선을 입력해주세요.');
			$('.receiver-visual').focus();
		} else {
			var result = confirm('발송하시겠습니까?');
			if (result) {
				alert('메일 발송이 완료되었습니다.');
				$('form').submit();
			}
		}
	}
	
	function approvalList() {
		location.href = '/getApproval/list.go';
	}
	
	('.btn-newApproval').click(function() {
		
	});
	
</script>
</html>