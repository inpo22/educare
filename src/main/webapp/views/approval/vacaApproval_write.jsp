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
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css"/>
<link href="/resources/approval/style.css" rel="stylesheet">
<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>
<script src="/resources/dept/js/deptModal_module.js"></script>

<style>
	.first-col {
		width: 13%;
	}
	.second-col {
		width: 86%;
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
								<th class="table-active order-first-col vertical-align-middle" rowspan="3">신<br/><br/>청</th>
								<td class="text-align-center order-second-col">${sessionScope.class_name}</td>
							</tr>
							<tr>
								<td class="text-align-center vertical-align-bottom">${sessionScope.user_name}</td>
							</tr>
							<tr>
								<td class="order-third-row"></td>
							</tr>
						</table>
						<div id="order-list-div"></div>
					</div>
					<table class="table table-bordered">
						<tr>
							<th class="table-active first-col">휴가 종류</th>
							<td class="second-col">
								<select name="va_type" id="va_type" class="form-select">
									<option value="0">연차</option>
									<option value="1">오전 반차</option>
									<option value="2">오후 반차</option>
									<option value="3">경조사</option>
									<option value="4">공가</option>
									<option value="5">병가</option>
									<option value="6">대체 휴가</option>
								</select>
							</td>
						</tr>
						<tr>
							<th class="table-active">휴가 기간</th>
							<td>
								<input type="date" name="start_date" id="start_date" class="form-control datepicker"/>
								<span class="is-half">&nbsp;&nbsp;~&nbsp;&nbsp;</span>
								<input type="date" name="end_date" id="end_date" class="form-control is-half datepicker"/>
							</td>
						</tr>
						<tr>
							<th class="table-active">제목</th>
							<td>
								<input type="text" name="subject" id="subject" class="form-control"/>
							</td>
						</tr>
						<tr>
							<th class="table-active vertical-align-middle">내용</th>
							<td>
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
						<button class="btn btn-primary btn-sm" onclick="approvalSubmit()" type="button">상신</button>
						&nbsp;&nbsp;
						<button class="btn btn-secondary btn-sm" onclick="approvalList()" type="button">취소</button>
					</div>
				</form>
			</div>
		</div>
	</main>
	<!-- End #main -->
	
	<!-- 부서 모달 -->
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
	        		<button class="btn btn-primary btn-sm send-list disabled-button">추가</button>
	        	</div>
			</div>
	    </div>
	</div>
	
	<jsp:include page="/views/common/footer.jsp"></jsp:include>
	<jsp:include page="/views/approval/newApproval_modal.jsp"></jsp:include>
	
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
		$('.send-list').addClass('disabled-button');
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
	*/
	var orderTextList = [];
	var orderValueList = [];
	var selectedNodeText = '';
	var selectedNodeValue = '';
	var removeTag = '';
	var removeNodeText = '';
	var removeNodeValue = '';
	
	var deptTree = treeObj.var.tree;
	deptTree.on('select', function(e) {
			selectedNodeText = '';
			selectedNodeValue = '';
			$('.list-add-button').addClass('disabled-button');
			$('.list-remove-button').addClass('disabled-button');
			
			$('.selected-value').removeClass('selected-value');
			
			if (deptTree.getChildIds(e.nodeId) == '' && deptTree.getNodeData(e.nodeId).value != '${sessionScope.user_code}') {
				selectedNodeText = deptTree.getNodeData(e.nodeId).text;
				selectedNodeValue = deptTree.getNodeData(e.nodeId).user_code;
				// console.log(selectedNodeValue);
				if (selectedNodeValue != undefined) {
					$('.list-add-button').removeClass('disabled-button');
				}
			}
			// console.log('nodeText : ' + selectedNodeText);
			// console.log('nodeValue : ' + selectedNodeValue);
			
	});
	
	$('.list-add-button').click(function() {
		var content = '<li class="value-' + selectedNodeValue + '">' + selectedNodeText + '</li>';
		
		if (!orderValueList.includes(selectedNodeValue)) {
			orderTextList.push(selectedNodeText);
			orderValueList.push(selectedNodeValue);
			$('.add-list').append(content);
		}
		
		$('.list-add-button').addClass('disabled-button');
		$('.tui-tree-selected').removeClass('tui-tree-selected');
		selectedNodeText = '';
		selectedNodeValue = '';
		
		if (orderValueList != '') {
			$('.send-list').removeClass('disabled-button');
		} else {
			$('.send-list').addClass('disabled-button');
		}
	});
	
	$('.add-list').on('click', 'li', function(e) {
		removeNodeText = '';
		removeTag = '';
		removeNodeValue = '';
		
		$('.list-add-button').addClass('disabled-button');
		$('.list-remove-button').addClass('disabled-button');
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
		
		if (orderValueList != '') {
			$('.send-list').removeClass('disabled-button');
		} else {
			$('.send-list').addClass('disabled-button');
		}
	});
	
	$('.send-list').click(function() {
		var index = -1;
		var content = '';
		
		if (orderTextList.length > 6) {
			alert('결재선은 6명까지 지정 가능합니다.');
			
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
			$('#order-list-div').empty();
		} else {
			content += '<table class="table table-bordered display-inline text-align-right order-table">';
			content += '<tr>';
			content += '<th class="table-active order-first-col vertical-align-middle" rowspan="3">결<br/><br/>재</th>';
			for (var orderText of orderTextList) {
				index = orderText.indexOf(' ');
				// console.log(orderText.substring(index + 1, orderText.length));
				content += '<td class="text-align-center order-second-col">' + orderText.substring(index + 1, orderText.length) + '</td>';
			}
			content += '</tr>';
			content += '<tr>';
			for (var orderText of orderTextList) {
				index = orderText.indexOf(' ');
				content += '<td class="text-align-center vertical-align-bottom">' + orderText.substring(0, index) + '</td>';
			}
			content += '</tr>';
			content += '<tr>';
			for (var i = 0; i < orderTextList.length; i++) {
				content += '<td class="order-third-row"></td>';
			}
			content += '</tr>';
			content += '</table>';
			
			$('#order-list-div').html(content);
			
			$('#orderList').val(orderValueList.toString());
			closeModal();
		}
	});
	
	$('#va_type').change(function() {
		var selectedVal = $('#va_type').val();
		
		if (selectedVal == 1 || selectedVal == 2) {
			$('.is-half').css('display', 'none');
		}else {
			$('.is-half').css('display', 'inline');
		}
	});
	
	function approvalSubmit() {
		var editorContent = editor.getHTML();
		$('#content').val(editorContent);
		
		var $subject = $('#subject');
		var $orderList = $('#orderList');
		var $va_type = $('#va_type');
		var $start_date = $('#start_date');
		var $end_date = $('#end_date');
		
		// console.log($start_date.val());
		// console.log($end_date.val());
		// console.log($end_date.val() < $start_date.val());
		
		if ($start_date.val() == '') {
			alert('휴가 시작일을 입력해주세요.');
			$start_date.focus();
		} else if (!($va_type.val() == 1 || $va_type.val() == 2) && $end_date.val() == '') {
			alert('휴가 종료일을 입력해주세요.');
			$end_date.focus();
		} else if (!($va_type.val() == 1 || $va_type.val() == 2) && $end_date.val() < $start_date.val()) {
			alert('잘못된 휴가 일정입니다. 다시 입력해주세요.');
			$end_date.focus();
		} else if ($subject.val() == '') {
			alert('제목을 입력해주세요.');
			$subject.focus();
		} else if (editor.getMarkdown() == '') {
			alert('내용을 입력해주세요.');
			$('#editor').focus();
		} else if ($orderList.val() == '') {
			alert('결재선을 입력해주세요.');
		} else {
			var result = confirm('상신하시겠습니까?');
			if (result) {
				alert('상신이 완료되었습니다.');
				$('form').submit();
			}
		}
	}
	
	function approvalList() {
		location.href = '/getApproval/list.go';
	}
</script>
</html>