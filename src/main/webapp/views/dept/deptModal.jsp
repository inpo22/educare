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
	
</body>
<script>
	$(document).ready(function() {
		
	});
	
	var option1 = {	id: 'main'};

	var option2 = {
			id: 'sub',
			treeId: '#modalTree2',
			nodeId: 'tui-tree-node-3',
			modalId:'deptTree_modal2'
		};

	var module1 = treeModule.init(option1);
	var module2 = treeModule.init(option2);
	var modal;
	//console.log(module)
	
	//event
	$('.basic_btn').on('click',function(){
		console.log('::baisc::');
		treeModule.loadTree(module1);
		modal = module1.var.tree.modal;
		modal.show();
	});
	
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
	
	

</script>
</html>