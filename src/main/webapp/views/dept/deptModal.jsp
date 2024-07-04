<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>부서 모달 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<jsp:include page="/views/common/head.jsp"></jsp:include>
<link rel="stylesheet" href="/resources/dept/tui-tree/css/tree.css">
<!-- js -->
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>
<script src="/resources/dept/js/deptModal_module.js"></script>
<style>
.tui-tree-root {
	height: 450px;
}

</style>
</head>

<body>
	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>부서 모달</h1>
		</div>
		<!-- End Page Title -->
		<button type="button" id="baisc" class="btn btn-primary basic_btn">basic tree</button>
		<button type="button" id="advanced" class="btn btn-primary advanced_btn">advanced tree</button>

	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>
	
	
	<!-- dept Tree Modal -->
	<div class="modal fade" id="deptTree_modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">기본 부서 트리 모달</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div id="modalTree" class="tui-tree-wrap" data-bs-spy="scroll"></div>
				</div>
				<div class="modal-footer">
				</div>
			</div>
		</div>
	</div>
	<!-- End Modal -->
	
	<!-- dept-member Tree Modal -->
	<div class="modal fade" id="deptTree_modal2" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">부서원 포함된 부서 트리 모달</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div id="modalTree2" class="tui-tree-wrap" data-bs-spy="scroll"></div>
				</div>
				<div class="modal-footer">
				</div>
			</div>
		</div>
	</div>
	<!-- End dept-member Tree Modal -->
	
</body>
<script>
	$(document).ready(function() {
		
	});
	
	// module 초기 생성 옵션
	// 부서만 보이는 모달 사용 시
	var option = {	id: 'main'};
	// 부서+부서원 보이는 모달 사용 시
	// 새로운 모달 사용 시, 아래 항목 필수 입력(트리 1개일 경우 nodeId는 생략 가능)
	var option2 = {
			id: 'sub',
			treeId: '#modalTree2',
			nodeId: 'tui-tree-node-3',
			modalId:'deptTree_modal2'
		};

	/* 
	var module = treeModule.init(option);	// tree module
	var tree = module.var tree;				// tree 객체
	var modal = module.var.tree.modal;		// modal 객체	
	var rootId = module1.var.rootId;	// 선택한 트리 rootId
	var selectId = module1.var.selectId;	// 선택한 부서 nodeId
	
	// tree 새로운 이벤트 추가 예시
	tree.enableFeature('Draggable', {
		helperClassName: 'tui-tree-drop',
		lineClassName: 'tui-tree-line',
		isSortable: true
	});
	module.var.tree.enableFeature('Editable', {
		dataKey: 'text'
	});
 */	
	
	var module1 = treeModule.init(option);
	var module2 = treeModule.init(option2);
	var tree = module1.var.tree;
	var modal;
	
	//event
	// 기본 부서 트리 모달
	$('.basic_btn').on('click',function(){
		console.log('::baisc::');
		treeModule.loadTree(module1);
		modal = module1.var.tree.modal;
		modal.show();
	});
	// 부서원 포함된 부서 트리 모달
	$('.advanced_btn').on('click',function(){
		console.log('::advanced::');
		treeModule.loadTree(module2);
		treeModule.loadMember(module2);
		modal = module2.var.tree.modal;
		modal.show();
	});
	
	$('.btn-close').on('click',function(){
		modal.hide();
		modal = null;
	});
	
	// tree select event
	// (2번째 모달 사용 시, module명 변경해서 사용)
	module1.var tree.on('select', function(e){
		var data = tree.getNodeData(e.nodeId);
		module1.var.selectId = e.nodeId;
		module1.var.select_data = data;
		console.log('selected: ',module1.var.selectId);
		console.log('selected: ',module1.var.select_data);
	});

</script>
</html>