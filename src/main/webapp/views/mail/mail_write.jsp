<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>신규 메일 작성 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- css -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css"/>
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css"/>
<link href="/resources/mail/style.css" rel="stylesheet">
<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>
<script src="/resources/dept/js/deptModal_module.js"></script>

<style>
	.first-col {
		width: 15%;
	}
	.second-col {
		width: 74%;
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
					<h1><a href="/receivedMail/list.go">메일</a></h1>
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
									<div class="table-left-section receiver-visual">
										<c:if test="${receiverList.size() > 0}">
											<c:forEach items="${receiverList}" var="receiver">
												<span class="badge bg-primary receiver-${receiver.receive_user_code}">
													${receiver.receiver_name}&nbsp;${receiver.class_name}
												</span>
												&nbsp;&nbsp;
											</c:forEach>
										</c:if>
									</div>
									<div class="table-right-section"><button class="btn btn-secondary btn-sm" type="button" onclick="openReceiverModal()">+</button></div>
								</div>
							</td>
						</tr>
						<tr>
							<th class="table-active">참조</th>
							<td>
								<div class="display-flex">
									<div class="table-left-section cc-visual">
										<c:if test="${ccList.size() > 0}">
											<c:forEach items="${ccList}" var="cc">
												<span class="badge bg-primary cc-${cc.receive_user_code}">
													${cc.cc_name}&nbsp;${cc.class_name}
												</span>
												&nbsp;&nbsp;
											</c:forEach>
										</c:if>
									</div>
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
								<ul id="fileList">
									<c:if test="${attachFileList.size() > 0}">
										<c:forEach items="${attachFileList}" var="attachFile">
											<li class="loadFiles no-${attachFile.file_no}">
												${attachFile.ori_filename}
												&nbsp;&nbsp;&nbsp;
												<span class="load-remove-x">X</span>
											</li>
										</c:forEach>
									</c:if>
								</ul>
							</td>
						</tr>
					</table>
					<input type="file" name="attachFile" id="attachFile" multiple="multiple"/>
					<input type="hidden" name="receiverList" id="receiverList"/>
					<input type="hidden" name="ccList" id="ccList"/>
					<input type="hidden" name="loadFileList" id="loadFileList"/>
					<input type="hidden" name="content" id="content"/>
					<br/>
					<div class="text-align-right">
						<button class="btn btn-primary btn-sm" onclick="mailSubmit()" type="button">발송</button>
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
				<span class="modal-title"></span>
	        	<span class="close" onclick="closeModal()">&times;</span>
	        	<br/><br/>
	        	<div class="display-flex">
	        		<div id="dept-tree" class="tui-tree-wrap"></div>
		        	<div class="modal-inner-button">
		        		<div class="modal-inner-button-child">
		        			<button class="btn btn-secondary btn-sm receiver-add-button disabled-button">&rsaquo;</button>
		        			<br/>
		        			<button class="btn btn-secondary btn-sm receiver-remove-button disabled-button">&lsaquo;</button>
		        		</div>
		        	</div>
		        	<div class="modal-add-list">
		        		<ul class="add-list"></ul>
		        	</div>
	        	</div>
	        	<br/>
	        	<div class="text-align-right right-padding">
	        		<button class="btn btn-primary btn-sm send-receiver-list">추가</button>
	        	</div>
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
	var loadFileList = [];
	
	$('#fileInputButton').click(function() {
		$('#attachFile').click();
	});
	
	$('#attachFile').change(function() {
		var inputFiles = $("#attachFile")[0].files;
		// console.log(inputFiles);
		
		for (var item of inputFiles) {
			var fileSize = item.size;//업로드한 파일용량
			// console.log(fileSize);
			if (fileSize > maxSize) {
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
		var startRemove = $('.loadFiles').length;
		
		var childElems = $('#fileList').children('li');
		
		for (var i = startRemove; i < childElems.length; i++) {
			childElems[i].remove();
		}
		
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
	
	$('.load-remove-x').click(function() {
		// console.log($(this).parents('li'));
		
		var file_no = $(this).parent().attr('class').split(' ')[1].substring(3);
		loadFileList.splice(loadFileList.indexOf(file_no), 1);
		$('#loadFileList').val(loadFileList.toString());
		$(this).parent().remove();
	});
	
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
	    receiverTextList = [];
	    receiverValueList = [];
		selectedNodeText = '';
		selectedNodeValue = '';
		removeTag = '';
		removeNodeValue = '';
		removeNodeText = '';
		$('.receiver-add-button').addClass('disabled-button');
		$('.receiver-remove-button').addClass('disabled-button');
		$('.tui-tree-selected').removeClass('tui-tree-selected');
		$('.add-list').empty();
	}
	
	// 부서 Tree
	var option = {
		id: 'dept',
		treeId: '#dept-tree',
		data: [{
			text: '에듀케어',
			team_code: 'T000',
			team_name: '에듀케어',
			upper_code: 'T000',
			reg_date: '2002-02-02'
		}],
		modalId: 'emp-modal'
	};
	
	var treeObj = treeModule.init(option);
	treeModule.loadTree(treeObj);
	treeModule.loadMember(treeObj);
	
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
		url:'/mail/deptList.ajax',
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
	*/
	
	var receiverTextList = [];
	var receiverValueList = [];
	var selectedNodeText = '';
	var selectedNodeValue = '';
	var removeTag = '';
	var removeNodeText = '';
	var removeNodeValue = '';
	
	var deptTree = treeObj.var.tree;
	deptTree.on('select', function(e) {
			selectedNodeText = '';
			selectedNodeValue = '';
			$('.receiver-add-button').addClass('disabled-button');
			$('.receiver-remove-button').addClass('disabled-button');
			
			$('.selected-value').removeClass('selected-value');
			
			if (deptTree.getChildIds(e.nodeId) == '' && deptTree.getNodeData(e.nodeId).user_code != '${sessionScope.user_code}') {
				selectedNodeText = deptTree.getNodeData(e.nodeId).text;
				selectedNodeValue = deptTree.getNodeData(e.nodeId).user_code;
				// console.log(selectedNodeValue);
				if (selectedNodeValue != undefined) {
					$('.receiver-add-button').removeClass('disabled-button');
				}
			}
			// console.log('nodeText : ' + selectedNodeText);
			// console.log('nodeValue : ' + selectedNodeValue);
			
	});
	
	$('.receiver-add-button').click(function() {
		
		var content = '<li class="value-' + selectedNodeValue + '">' + selectedNodeText + '</li>';
		
		if (!receiverValueList.includes(selectedNodeValue)) {
			receiverTextList.push(selectedNodeText);
			receiverValueList.push(selectedNodeValue);
			$('.add-list').append(content);
		}
		
		$('.receiver-add-button').addClass('disabled-button');
		$('.tui-tree-selected').removeClass('tui-tree-selected');
		selectedNodeText = '';
		selectedNodeValue = '';
		
		console.log(receiverValueList);
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
		$('.receiver-remove-button').removeClass('disabled-button');
	});
	
	$('.receiver-remove-button').click(function() {
		var index = receiverValueList.indexOf(removeNodeValue);
		receiverValueList.splice(index, 1);
		
		index = receiverTextList.indexOf(removeNodeText);
		receiverTextList.splice(index, 1);
		
		removeTag.remove();
		
		removeNodeText = '';
		removeTag = '';
		removeNodeValue = '';
		$('.selected-value').removeClass('selected-value');
		$('.receiver-remove-button').addClass('disabled-button');
		console.log(receiverValueList);
	});
	
	$('.send-receiver-list').click(function() {
		if ($('.modal-title').html() == '받는 사람 추가') {
			var content = '';
			for (var item of receiverTextList) {
				content += '<span class="badge bg-primary">' + item + '</span>&nbsp;&nbsp;';
			}
			$('.receiver-visual').html(content);

			console.log(receiverValueList.toString());
			$('#receiverList').val(receiverValueList.toString());
			closeModal();
		} else if ($('.modal-title').html() == '참조 추가') {
			var content = '';
			for (var item of receiverTextList) {
				content += '<span class="badge bg-primary">' + item + '</span>&nbsp;&nbsp;';
			}
			$('.cc-visual').html(content);
			
			$('#ccList').val(receiverValueList.toString());
			closeModal();
		}
	});
	
	var writeType = '${writeType}';
	
	// console.log(writeType);
	
	if (writeType == 1) {
		$('#subject').val('RE: ');
		editor.setHTML('${original_message}');
		
		$('.cc-visual span').each(function() {
			var user_code = $(this).attr('class').split(' ')[2].substring(3);
			// console.log($(this).attr('class'));
			// console.log(user_code);
			receiverValueList.push(user_code);
		});
		$('#ccList').val(receiverValueList.toString());
		receiverValueList = [];
		
		$('.receiver-visual span').each(function() {
			var user_code = $(this).attr('class').split(' ')[2].substring(9);
			// console.log($(this).attr('class'));
			// console.log(user_code);
			receiverValueList.push(user_code);
		});
		$('#receiverList').val(receiverValueList.toString());
		receiverValueList = [];
		
		// console.log($('#ccList').val());
		// console.log($('#receiverList').val());
	}
	
	if (writeType == 2) {
		$('#subject').val('FW: ');
		editor.setHTML('${original_message}');
		
		$('.loadFiles').each(function() {
			var file_no = $(this).attr('class').split(' ')[1].substring(3);
			console.log($(this).attr('class'));
			console.log(file_no);
			loadFileList.push(file_no);
		});
		$('#loadFileList').val(loadFileList.toString());
	}
	
	function mailSubmit() {
		var editorContent = editor.getHTML();
		$('#content').val(editorContent);
		
		var $subject = $('#subject')
		var $receiverList = $('#receiverList');
		
		if ($subject.val() == '') {
			alert('제목을 입력해주세요.');
			$subject.focus();
		} else if (editor.getMarkdown() == '') {
			alert('내용을 입력해주세요.');
			$('#editor').focus();
		} else if ($receiverList.val() == '') {
			alert('받는 사람을 입력해주세요.');
			$('.receiver-visual').focus();
		} else {
			var result = confirm('발송하시겠습니까?');
			if (result) {
				alert('메일 발송이 완료되었습니다.');
				$('form').submit();
			}
		}
	}
	
	function mailList() {
		location.href = '/receivedMail/list.go';
	}
	
	$('.btn-newMail').click(function() {
		location.href = '/mail/write.go';
	});
</script>
</html>