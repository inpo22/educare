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
          <!-- CreateDept Form -->
          <form class="row g-3" action="/dept/register" method="post">        
          <div class="modal-header">
            <h5 class="modal-title">부서 추가</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
                <div class="col-12">
                  <label for="addName_input" class="form-label">부서명</label>
                  <input type="text" class="form-control" id="addName_input">
                </div>
                <div class="col-12">
                  <label for="addCode_input" class="form-label">부서 코드</label>
                  <input type="text" class="form-control" id="addCode_input">
                </div>
                <div class="col-12">
                  <label for="addUpperCode_input" class="form-label">상위 부서</label>
                  <input type="text" class="form-control" id="addUpperCode_input">
                </div>
          </div>
          <div class="modal-footer">
            <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            <button type="submit" class="btn btn-primary">추가</button>
          </div>              
          </form><!-- CreateDept Form -->
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
 		var node = Number(e.nodeId.substring(14));
		selected_nodeId = e.nodeId;
		console.log('selected node number: '+node);
		console.log('selected node: '+selected_nodeId);
		console.log('selected node name: '+nodeData.text);
	});
	
	// tree-edit event
	tree.on('beforeEditNode', function(event) {
	       if (event.cause === 'blur') {
	           tree.finishEditing();
	           return false;
	       }
	       return confirm('부서명을 수정하시겠습니까?');
	   });

	// tree-move event
	tree.on('beforeMove', function() {
		console.log('before move');
	});
	
	tree.on('move', function(e){
		var msg;
		
		msg = 'nodeId: '+e.nodeId+'\n';
		msg += 'newPId: '+e.newParentId+'\n';
		msg += 'idx: '+e.index+'\n';
		
		console.log('move event: ',msg);
	});

	/* menu.register('#target', onclick, [
		{title: '부서 추가', command: 'create'}
	]);
	 */
	// basic event
	// create Dept
	$('#createDept_btn').on('click', function(){
		var upper_id = tree.getParentId(selected_nodeId);
		var upper_name = tree.getNodeData(upper_id);
		console.log('create Dept: ', selected_nodeId);
		console.log('upper_id: ',upper_id,'/ upper_name: ',upper_name);
		
		$('#addUpperCode_input').val(upper_name.text);
		createDeptModal.show();
		//tree.createChildNode(selected_nodeId);
	});
	
	// remove Dept
	$('#removeDept_btn').on('click', function(){
		console.log('remove Dept');
		tree.remove(selected_nodeId);
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
			//treeData[idx] = {id: data.team_code, parent: data.upper_code, text: data.team_name}
			var upper_code = 1+Number(data.upper_code.substring(1));
			console.log(idx,'team_code:', data.team_code,'- upper:', upper_code);
			if(data.upper_code == 'T00'){
				tree.add({text:data.team_name}, 'tui-tree-node-1');
				console.log('상위 부서 data: ',data);
			}else{
				console.log('하위 부서 data: ',data);	
				tree.add({text:data.team_name}, 'tui-tree-node-'+upper_code);
			}
			
		});
	}
	

	
	// methodEnd

	



</script>
</html>