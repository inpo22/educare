<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>부서 관리</title>
<meta content="" name="description">
<meta content="" name="keywords">

<jsp:include page="/views/common/head.jsp"></jsp:include>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<style>
.invalidation {
	color: red;
	display: none;
}
</style>
<!-- tree css -->
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.context-menu/latest/tui-context-menu.css"/>
<!-- tree js -->
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>
<script src="https://uicdn.toast.com/tui.context-menu/latest/tui-context-menu.js"></script>	
</head>
<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">

		<div class="pagetitle">
		<h1>부서 관리</h1>
		</div>
		<!-- End Page Title -->
		
		<div class="content">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-3">
						<!-- 조직도 card -->
						<div class="card">
							<div class="card-header border-0">
								<div class="d-flex justify-content-between">
									<h3 class="card-title">조직도</h3>
								</div>
								<div>
									<button id="createDept_btn" type="button" class="btn btn-outline-success">
										<i class="bi bi-folder-plus"></i>
									</button>
									<button id="removeDept_btn" type="button" class="btn btn-outline-danger">
										<i class="bi bi-folder-minus"></i>
									</button>
								</div>
							</div>
							<!-- card-header End -->
							<div class="card-body">
								<div id="deptTree" class="tui-tree-wrap"></div>
							</div>
							<!-- care-body End -->
						</div>
						<!-- card End -->
					</div>
					<!-- 조직도 End -->
					<div class="col-md-auto"></div>
					<!-- 부서 card -->
					<div class="col-lg-6">
						<div class="card">
							<div class="card-header border-0">
								<div class="d-flex justify-content-between">
									<h3 class="card-title">부서 관리</h3>
								</div>
							</div>
							<!-- care-header End -->
							<div class="card-body"></div>
							<!-- care-body End -->
						</div>
						<!-- card End -->

					</div>
					<!-- col-lg-4 End -->



				</div>
				<!-- /.row -->
			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /.content -->

	</main>
	<!-- End #main -->
	<!-- CreateDept Modal -->
	<div class="modal fade" id="createDeptModal" tabindex="-1">
	<div class="modal-dialog modal-sm">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title">부서 추가</h5>
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		</div>
			<div class="modal-body">
			<div class="col-12">
				<label for="add_name_input" class="form-label">부서명</label>
				<input type="text" class="form-control" id="add_name_input">
				<span class="invalidation" id="invalid_name">부서명을 입력 해주세요.</span>
			</div>
			<div class="col-12">
				<label for="add_code_input" class="form-label">부서 코드</label>
				<input type="text" class="form-control" id="add_code_input">
				<span class="invalidation" id="invalid_code">부서 코드를 입력 해주세요.</span>
			</div>
			<div class="col-12">
			<label for="add_upper_input" class="form-label">상위 부서</label>
			<input type="text" class="form-control" id="add_upper_input">
			</div>
		</div>
		<div class="modal-footer">
			<button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			<button type="button" class="btn btn-primary" id="createDept_modal_btn">추가</button>
		</div>
	</div>
	</div>
	</div>
	<!-- End CreateDept Modal -->
	
	<jsp:include page="/views/common/footer.jsp"></jsp:include>
</body>
<script>
	$(document).ready(function() {
		getDept_ajax();
	});
	
	// 변수
	var selected_nodeId;

	// 부서 트리 객체 생성
	var tree = new tui.Tree('#deptTree', {
		data: [{id: 'T00', text: '에듀케어'}],
		nodeDefaultState: 'opened'
	});
	
	//var menu = new tui.contextMenu(document.querySelector('#deptTree'));
	
	var createDeptModal = new bootstrap.Modal(
			document.getElementById('createDeptModal'), { keyboard: false });
	
	//event
	// tree event
	tree.enableFeature('Selectable', {
		selectedClassName: 'tui-tree-selected',
	}).enableFeature('Draggable', {
		helperClassName: 'tui-tree-drop',
		lineClassName: 'tui-tree-line',
		isSortable: true
	}).enableFeature('Editable', {
		dataKey: 'text',
		defaultvalue: 'new node',
		inputClassNmae: 'tui-tree-edit'
	});
	
	
	// tree-select event
	tree.on('select', function(e){
 		var nodeData = tree.getNodeData(e.nodeId);
		selected_nodeId = e.nodeId;
		console.log('selected node: '+selected_nodeId);
		//console.log('selected node name: '+nodeData.text);
		console.log('selected node data: '+nodeData.team_code,'/'+nodeData.team_name,'/'+nodeData.upper_code);
	});
	
	// tree-edit event
	tree.on('beforeEditNode', function(e) {
		// 수정중222222
		console.log('edit: ',e.nodeId, '/',e.value, '/',e.cause);
		var edit_name = e.value;
		var data = tree.getNodeData(e.nodeId);

		if (e.cause === 'blur') {
			tree.finishEditing();
			return false;
		}else{
			var result = confirm('부서명을 수정하시겠습니까?');
			if(result){
				console.log('edit Dept: ',data.team_name,'->',edit_name)
				var edit_param = {
					'team_code'	: data.team_code,
					'team_name'	: edit_name,
					'edit_type'	: 'name'
				}
				tree.setNodeData(e.nodeId, {team_name: edit_name});	// update node data
				updateDept_ajax(edit_param);	// update DB
			}
		}
	});

	// tree-move event
	tree.on('beforeMove', function(e) {
		console.log('::before move::');
		/* 
		console.log('dragging node: ' + e.nodeId);
		console.log('new parent node: ' + e.newParentId);
		console.log('original parent node: ' + tree.getParentId(e.nodeId));
 		*/
		var edit_data = tree.getNodeData(e.nodeId);
		var og_upper = tree.getNodeData(tree.getParentId(e.nodeId));
		var new_upper = tree.getNodeData(e.newParentId);
		console.log('move Dept: ',edit_data.team_name);
		console.log(og_upper.team_name,'->',new_upper.team_name);
		
		var edit_param = {
			'team_code'	: edit_data.team_code,
			'upper_code': new_upper.team_code,
			'edit_type'	: 'code'
		}
		tree.setNodeData(e.nodeId, {upper_code: new_upper.team_code});	// update node data
		updateDept_ajax(edit_param);	// update DB
	});
	
 	tree.on('move', function(e){
		var msg = 'nodeId: '+e.nodeId+'\n';
		msg += 'newPId: '+e.newParentId+'\n';
		msg += 'idx: '+e.index+'\n';
		console.log('::after move::');
		//console.log(msg);
		console.log('data: ',tree.getNodeData(e.nodeId));
		
		
	});

	/* menu.register('#target', onclick, [
		{title: '부서 추가', command: 'create'}
	]);
	 */
	// basic event
	// create Dept
	// open modal createDept 
	$('#createDept_btn').on('click', function(){
		if(selected_nodeId != null){
			var data = tree.getNodeData(selected_nodeId);
			console.log('create Dept: ', data.team_name);
			
			$('#add_code_input').val('');
			$('#add_name_input').val('');
			$('#add_upper_input').val(data.team_name);
			$('#add_upper_input').attr('name', data.team_code);
			createDeptModal.show();	
		}else{
			alert('추가할 부서를 선택해 주세요.');
		}
	});
	// createDept to DB
	$('#createDept_modal_btn').on('click', function(){
		// 수정중(부서 등록 유효성 미완성)
		if($('#add_code_input').val() == ''){
			$('#invalid_code').attr('style','display:block;');
		} else if($('#add_name_input').val() == ''){
			$('#invalid_name').attr('style','display:block;');
		} else{
			var now = new Date();
			var add_param = {
				'team_code' : $('#add_code_input').val(),
				'team_name' : $('#add_name_input').val(),
				'upper_code': $('#add_upper_input').attr('name'),
				'reg_date'	: now
			}
			createDeptModal.hide();
			createDept_ajax(add_param);
		}
	});
	// remove Dept
	$('#removeDept_btn').on('click', function(){
 		var data = tree.getNodeData(selected_nodeId);
		console.log('remove Dept: ', data.team_name);

		var result = confirm('해당 부서를 삭제 하시겠습니까?');
		if(result){
			removeDept_ajax(data.team_code);
		}
	});
	

	 //eventEnd
	
	
	
	//ajax
	function getDept_ajax(){
		$.ajax({
			type	: 'get',
			url		: '/dept/list.ajax',
			dataType: 'json',
			success	: function(result){
				console.log('deptList: ',result.deptList);			
	 			if(result.deptList.length > 0){
	 				createTree(result.deptList);
					
				}else{
					console.log('부서 읎다');
				}
	 		},
			error	:	function(error){
				console.log(error);
			}
		});
	 }
		
	function createDept_ajax(param){
		$.ajax({
			type	: 'post',
			url		: '/dept/register.ajax',
			data	: param,
			dataType: 'json',
			success	: function(result){
				console.log('createDept_ajax: ',result.msg);
				if(result.msg == 'success'){
					addNode(param);
					alert('해당 부서가 등록되었습니다.');
				}
	 		},
			error	:	function(error){
				console.log(error);
			}
		});
	}
	
	function removeDept_ajax(code){
		$.ajax({
			type	: 'get',
			url		: '/dept/delete.ajax',
			data	: {
				'team_code': code
			},
			dataType: 'json',
			success	: function(result){
				console.log('removeDept_ajax: ',result.msg);
				if(result.msg == 'success'){
					alert('해당 부서가 삭제되었습니다.');
					tree.remove(selected_nodeId);
				}
	 		},
			error	:	function(error){
				console.log(error);
			}
		});
	}	

	function updateDept_ajax(param){
		$.ajax({
			type	: 'post',
			url		: '/dept/update.ajax',
			data	: param,
			dataType: 'json',
			success	: function(result){
				console.log('updateDept_ajax: ',result.msg);
				if(result.msg == 'success'){
					alert('해당 부서가 수정되었습니다.');
				}
	 		},
			error	:	function(error){
				console.log(error);
			}
		});
	}	
	//ajaxEnd
	
	
	// method
	// 트리 생성
	function createTree(list){
		// 부서코드 순으로 리스트 정렬
		list.sort(function(a, b){
			let tcA = Number(a.team_code.substring(1));
			let tcB = Number(b.team_code.substring(1));
			return tcA - tcB;
		});
		
		// 정렬한 리스트 순서대로 조직화
		list.forEach(function (data, idx){
			console.log(idx,'team_code:', data.team_code);
			addNode(data);
			console.log('=====================================');
			
		});
	}
	
	function addNode(data){
		var added_nodeId;
		var upper_code = 1+Number(data.upper_code.substring(1));
		if(data.upper_code == 'T00'){
			console.log('상위 부서 data: ',data);
			added_nodeId = tree.add({text:data.team_name}, 'tui-tree-node-1');
		}else{
			console.log('하위 부서 data: ',data);	
			added_nodeId = tree.add({text:data.team_name}, 'tui-tree-node-'+upper_code);
		}
		console.log('생성된 nodeId: ',added_nodeId);
		tree.setNodeData(added_nodeId, {
			team_code: data.team_code,
			team_name: data.team_name,
			upper_code: data.upper_code,
			reg_date: data.reg_date
		});
		
	}

	
	// methodEnd

	



</script>
</html>