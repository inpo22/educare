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
<!-- tree css -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.context-menu/latest/tui-context-menu.css"/>
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css" />
<!-- tree js -->
<script src="https://uicdn.toast.com/tui.context-menu/latest/tui-context-menu.js"></script>	
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>
<style>
.invalidation {
	color: red;
	display: none;
}
#deptInfo_table_sample{
	display: none;
}
#deptUser_list_sample{
	display: none;
}
.tui-tree-wrap{
      width: auto;
   }
</style>
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
								
								<!-- Tabs -->
								<ul class="nav nav-tabs nav-tabs-bordered d-flex" id="tabList" role="tablist">
									<li class="nav-item flex-fill" role="presentation">
										<button class="nav-link w-100 active" id="deptInfo_tab" onclick="clickTab('deptInfo')" data-bs-toggle="tab" data-bs-target="#deptInfo_tab_content" type="button" role="tab" 
										aria-controls="deptInfo" aria-selected="true">부서 정보</button>
									</li>
									<li class="nav-item flex-fill" role="presentation">
										<button class="nav-link w-100" id="deptUser_tab" onclick="clickTab('deptUser')" data-bs-toggle="tab" data-bs-target="#deptUser_tab_content" type="button" role="tab" 
										aria-controls="deptUser" aria-selected="false">부서원 리스트</button>
									</li>
								</ul>
 								<!-- TabsEnd -->
								
							</div>
							<!-- care-header End -->
							<div id="card-body-list" class="card-body">
								<!-- 부서 card body 내용 -->
								<div class="tab-content pt-2" id="tabContent">
									<div class="tab-pane fade show active" id="deptInfo_tab_content" role="tabpanel" aria-labelledby="deptInfo_tab">
										<table id="deptInfo_table" class="table table-borderless">
										</table>
									</div>
									<div class="tab-pane fade" id="deptUser_tab_content" role="tabpanel" aria-labelledby="deptUser_tab">
										<input class="form-check-input all" type="checkbox">
										<button type="button" class="btn btn-outline-primary btn-sm">부서장 위임</button>
										<button type="button" class="btn btn-outline-primary btn-sm">부서 이동</button>
										<br/><br/>
										<ul id="deptUser_list" class="list-group">
										</ul>
									</div>
								</div>
							</div>
							<!-- care-body End -->
						</div>
						<!-- 부서 card End -->
					</div>
					<!-- col-lg-6 End -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /.content -->
	</main>
	<!-- End #main -->
	<!-- deptInfo Table -->
	<table id="deptInfo_table_sample" class="table table-borderless">
		<tbody>
			<tr>
				<th>부서명(한글)</th>
				<td></td>
			</tr>
			<tr>
				<th>부서 코드</th>
				<td></td>
			</tr>
			<tr>
				<th>부서 생성일</th>
				<td></td>
			</tr>
			<tr>
				<th>상위 부서</th>
				<td>upper</td>
			</tr>
			<tr>
				<th>하위 부서</th>
				<td>lower</td>
			</tr>
		</tbody>
	</table>
	<!-- deptInfo Tables End -->

	<!-- deptUser List -->
	<ul id="deptUser_list_sample" class="list-group">
		<li class="list-group-item">
			<input class="form-check-input" type="checkbox">
			<i class="ri-account-circle-fill"></i>
			<span>name</span>
		</li>
	</ul>
	<!-- deptUser List End -->

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
		console.log('select:',selected_nodeId);
	});
	
	// 변수
	var selected_nodeId = 'tui-tree-node-1';
	var selected_tab = 'deptInfo';

	// 부서 트리 객체 생성
	var tree = new tui.Tree('#deptTree', {
		data: [{id: 'T00', text: '에듀케어'}],
		nodeDefaultState: 'opened'
	});
	
	// modal 객체
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
		dataKey: 'text'
	}).enableFeature('ContextMenu', {
		menuData: [
			{title: 'menu1'},
			{title: 'menu2', disable: true}
		]
	});
	
	// root node data	
	tree.setNodeData('tui-tree-node-1', {
		team_code: 'T00',
		team_name: '에듀케어',
		upper_code: 'T00',
		reg_date: '2002-02-02',
	});

	// tree-select event
	tree.on('select', function(e){
		selected_nodeId = e.nodeId;
		console.log('selected node id: '+e.nodeId);
		//console.log('selected node data: '+nodeData.team_code,'/'+nodeData.team_name,'/'+nodeData.upper_code);
		loadContent(selected_tab,e.nodeId);
	});
	
	// tree-edit event
	tree.on('beforeEditNode', function(e) {
		//console.log('edit: ',e.nodeId, '/',e.'e.nodeId, '/',e.value, '/',e.cause'e = e.value);
		var data = tree.getNodeData(e.nodeId);
		var edit_name = e.value
		if (e.cause === 'blur') {
			tree.finishEditing();
			return false;
		}else{
			var result = confirm('부서명을 수정하시겠습니까?');
			if(result){
				console.log("::edit Dept::");
				console.log(data.team_code,':',data.team_name,'->',edit_name);
				if(edit_name != null){
					var edit_param = {
							'nodeId'	: e.nodeId,
							'team_code'	: data.team_code,
							'team_name'	: edit_name,
							'type'	: 'name'
						}
						updateDept_ajax(edit_param);	// update DB
					
				}else{
					console.log('update fail');
				}
			}
		}
	});

	// tree-move event
	tree.on('beforeMove', function(e) {
		var edit_data = tree.getNodeData(e.nodeId);
		var og_upper = tree.getNodeData(tree.getParentId(e.nodeId));
		var new_upper = tree.getNodeData(e.newParentId);
		console.log('::move Dept::');
		console.log(edit_data.team_code,':',og_upper.team_name,'->',new_upper.team_name);
		
		if(new_upper.team_name != null){
			var move_param = {
				'nodeId'	: e.nodeId,
				'team_code'	: edit_data.team_code,
				'upper_code': new_upper.team_code,
				'type'	: 'code'
			}
			//tree.setNodeData(e.nodeId, {upper_code: new_upper.team_code});	// update node data
			updateDept_ajax(move_param);	// update DB
		}else{
			console.log('update fail');
		}
	});

	// basic event
	// create Dept
	// open modal createDept 
	$('#createDept_btn').on('click', function(){
		if(selected_nodeId != null){
			var data = tree.getNodeData(selected_nodeId);
			//console.log('open createDept modal', data.team_name);
			$('#add_code_input').val('');
			$('#add_name_input').val('');
			$('#add_upper_input').val(data.team_name);
			$('#add_upper_input').attr('name', data.team_code);
			$('.invalidation').attr('style','display:none;');
			createDeptModal.show();	
		}else{
			alert('추가할 부서의 위치를 선택해 주세요.');
		}
	});
	// createDept to DB
	$('#createDept_modal_btn').on('click', function(){
		// 수정중(부서 등록 유효성 미완성)
		var code_input = $('#add_code_input').val();
		var name_input = $('#add_name_input').val();
		if(code_input == '' || name_input == ''){
			alert('빈칸에 값을 입력해주세요.');
		} else if(checkOverlap(code_input)){
			alert('이미 존재하는 부서 코드 입니다. 다시 입력해 주세요.');
			var code_input = $('#add_code_input').val('');
			var name_input = $('#add_name_input').val('');
		} else{
			var now = new Date();
			var add_param = {
				'team_code' : $('#add_code_input').val(),
				'team_name' : $('#add_name_input').val(),
				'upper_code': $('#add_upper_input').attr('name'),
				'reg_date'	: now
			}
			console.log(':: create Dept -', add_param);
			createDeptModal.hide();
			createDept_ajax(add_param);
		}
	});
	// remove Dept
	$('#removeDept_btn').on('click', function(){
 		var data = tree.getNodeData(selected_nodeId);
		var result = confirm('해당 부서를 삭제 하시겠습니까?');
		if(result){
			console.log(':: remove Dept -', data.team_name);
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
		 			loadContent('deptInfo', selected_nodeId);
				}else{
					console.log('data empty');
				}
	 		},
			error	: function(error){
				console.log(error);
			}
		});
	 }
	function getUser_ajax(code){
		var result_data;
		$.ajax({
			type	: 'get',
			url		: '/dept/user/list.ajax',
			data	:	{
				'team_code'	: code
			},
			dataType: 'json',
			async	: false,
			success	: function(result){
				//console.log('userList: ',result.userList);
	 			if(result.userList != null){
	 				result_data = result.userList;
	 				var emp_cnt = result.userList.length;
					console.log('부서 인원수: ', emp_cnt);
					tree.setNodeData(selected_nodeId, {
						emp_cnt: emp_cnt
					});
				}else{
					console.log('data empty');
				}
	 		},
			error	: function(error){
				console.log(error);
			}
		});
		return result_data;
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
					alert('해당 부서가 등록되었습니다.');
					addNode(param);
					loadContent(selected_tab, selected_nodeId);
					console.log('selected_nodeId: ', selected_nodeId);
				}
	 		},
			error	: function(error){
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
					var remove_nodeId = selected_nodeId;
					selected_nodeId = tree.getParentId(selected_nodeId);
					loadContent(selected_tab, selected_nodeId);
					tree.select(selected_nodeId);
					tree.remove(remove_nodeId);
				}
	 		},
			error	: function(error){
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
				console.log('updateDept_ajax:',result.msg);
				if(result.msg == 'success'){
					if(param.type == 'code'){
					 	tree.on('move', function(e){
							/* var msg = 'nodeId: '+e.nodeId+'\n';
							msg += 'newPId: '+e.newParentId+'\n';
							msg += 'idx: '+e.index+'\n';
							console.log(msg);
							 */
							tree.setNodeData(e.nodeId, {upper_code: param.team_code});	// update node data
							selected_nodeId = e.nodeId;
							console.log('updated node data: ',tree.getNodeData(e.nodeId));
					 	});
						
					}else if(param.type == 'name'){
						tree.finishEditing();
						tree.setNodeData(param.nodeId, {team_name: param.team_name});	// update node data
						selected_nodeId = param.nodeId;
						console.log('updated node data: ', tree.getNodeData(param.nodeId))
					}
					tree.select(selected_nodeId);
					loadContent(selected_tab, selected_nodeId);
				}else{
					alert('해당 부서 수정을 실패했습니다.');
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
		list.forEach(function (data, idx){
			console.log(idx,'data:', data);
			//var code = 1+Number(data.team_code.substring(1));
			addNode(data)
			
			console.log('====================================================')
		});
		selected_nodeId = 'tui-tree-node-1';
		tree.select(selected_nodeId);
	}
	// 노드 추가
	function addNode(data){
		for(var i=1; i<=100; i++){
			var nodeId = 'tui-tree-node-'+i;
			var nodeData = tree.getNodeData(nodeId);
			if(nodeData == null){
				continue;
			}else if(nodeData.team_code == data.upper_code){
				var addedNodeId = tree.add({text:data.team_name}, nodeId);
				tree.setNodeData(addedNodeId, {
					team_code: data.team_code,
					team_name: data.team_name,
					upper_code: data.upper_code,
					reg_date: data.reg_date
				});
				console.log('added node Id:',addedNodeId);
				console.log('added node data: ',tree.getNodeData(addedNodeId))
				console.log('upper:',nodeData.team_code,'-',data.upper_code,'=>',nodeId);
			}
		}
		selected_nodeId = addedNodeId;
		tree.select(selected_nodeId);
	}
	// team code 중복 체크
	function checkOverlap(newTC){
		console.log('check team_code')
		for(var i=1; i<=100; i++){
			var nodeId = 'tui-tree-node-'+i;
			var nodeData = tree.getNodeData(nodeId);
			if(nodeData == null){
				continue;	
			}else if(nodeData.team_code == newTC){
				console.log(nodeData.team_code,'-',newTC)
				return true;
			}
		}
		return false;		
	}

	function loadContent(type, nodeId){
		if(type == 'deptInfo'){
			var now = tree.getNodeData(nodeId);
			var parent = tree.getNodeData(tree.getParentId(nodeId));
			var child = tree.getNodeData(tree.getChildIds(nodeId)[0]);
			var ogTable = $('#deptInfo_table_sample tbody').clone(true);
			var newTable = $('#deptInfo_table');
			console.log('::load deptInfo table::');
			console.log(nodeId,':',now);
			//console.log('parent:',parent.team_name);
			//console.log('child:',child);
			
			ogTable.find('td').eq(0).text(now.team_name);
			ogTable.find('td').eq(1).text(now.team_code);

			if(now.reg_date == null || now.reg_date == "" || now.reg_date == "defined"){
				ogTable.find('td').eq(2).text('-');
			}else{
				var dt = new Date(now.reg_date);
				var dt_form = dt.getFullYear()+'년 '+(dt.getMonth()+1)+'월 '+dt.getDate()+'일';
				ogTable.find('td').eq(2).text(dt_form);
			}			
			if(parent.team_name == null || parent.team_name == "" || parent.team_name == "defined"){
				ogTable.find('td').eq(3).text('-');
			}else{
				ogTable.find('td').eq(3).text(parent.team_name);
			}
			if(child == null || child == "" || child == "defined"){
				ogTable.find('td').eq(4).text('-');
			}else{
				ogTable.find('td').eq(4).text(child.team_name+' 외');
			}
			
			newTable.empty();
			newTable.append(ogTable);
			newTable.attr('style', "display:'';");
		// 수정중
		} else if(type='deptUser'){
			console.log('::load deptUser list::');
			var code = tree.getNodeData(nodeId).team_code;
			console.log('code: ', code);
			var userList = getUser_ajax(code);
			console.log('userList: ',userList);
			var ogList = $('#deptUser_list_sample li').clone(true);
			var newList = $('#deptUser_list');
			
			newList.empty();
			console.log(ogList.html());
			console.log(newList);
			if(userList.length > 0){
				userList.forEach(function(data, i){
					//ogList.find('li').addClass(data.team_code+'-'+i);
					ogList.find('input').addClass(data.user_code);
					ogList.find('span').text(data.name+' '+data.class_name);
					if(data.position_code == 'P01'){
						newList.prependTo(ogList);
					}else{
						newList.appendTo(ogList);
					}
				});	
			}else{
				newList.append(ogList);
			}
			newList.attr('style', "display:'';");
		}
	}
	// tab click
	function clickTab(type){
		console.log('click tab: ',type);
		if(type == 'deptInfo'){
			selected_tab = type;
			loadContent(type, selected_nodeId);
		}else if(type='deptUser'){
			selected_tab = type;
			loadContent(type, selected_nodeId);
		}else {
			
		}
	}
 // methodEnd

</script>
</html>