<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>부서 관리 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">
<style>
</style>
<jsp:include page="/views/common/head.jsp"></jsp:include>

<!-- style css -->
<link href="/resources/dept/css/style.css" rel="stylesheet">

<!-- tui-tree -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.context-menu/latest/tui-context-menu.css"/>
<link href="/resources/dept/tui-tree/css/tree.css" rel="stylesheet">
<script src="https://uicdn.toast.com/tui.context-menu/latest/tui-context-menu.js"></script>	
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>

<!-- 
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css" />
 -->
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
									<button id="removeDept_btn" type="button" onclick="removeDept()" class="btn btn-outline-danger">
										<i class="bi bi-folder-minus"></i>
									</button>
								</div>
							</div>
							<!-- card-header End -->
							<div class="card-body">
								<div id="deptTree" class="tui-tree-wrap" data-bs-spy="scroll"></div>
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
										<input class="form-check-input" type="checkbox" name="all">
										<button type="button" id="changeLeader_btn" class="btn btn-outline-primary btn-sm">부서장 위임</button>
										<button type="button" id="changeDept_btn" class="btn btn-outline-primary btn-sm">부서 이동</button>
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

	<!-- changeDept_Modal -->
	<div class="modal fade" id="changeDept_modal" tabindex="-1">
	<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title">부서 이동</h5>
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		</div>
		<div class="modal-body">
		</div>
		<div class="modal-footer">
		</div>
	</div>
	</div>
	</div>
	<!-- End changeDept_Modal -->
	
	<jsp:include page="/views/common/footer.jsp"></jsp:include>
	
</body>
<script>
	$(document).ready(function() {
		getDept_ajax();
	});
	
	var rootId = 'tui-tree-node-1';
	var newTC;
	var selected_tab;
	var checked = new Set();
	var treeData = [];
	
	// modal 객체
	var modal = new bootstrap.Modal(
			document.getElementById('changeDept_modal'), { keyboard: false });
	
	var tree = new tui.Tree('#deptTree', {
		data: [{id: 'T00', text: '에듀케어'}],
		nodeDefaultState: 'opened'
	});

	// event
	// root node data
	tree.setNodeData(rootId, {
		team_code: 'T000',
		team_name: '에듀케어',
		upper_code: 'T00',
		reg_date: '2002-02-02'
	});

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
			{title: 'create', command: 'create'},
			{title: 'update', command: 'update'},
			{title: 'remove', command: 'remove'}
		]
	});
	
	// tree-contextmenu event
	tree.on('selectContextMenu', function(e) {
		var command = e.command;
		var nodeId = e.nodeId;
		var data = tree.getNodeData(nodeId);

		tree.select(nodeId);
		switch (command) {
			case 'create':
				tree.createChildNode(nodeId);
				break;
			case 'update':
				tree.editNode(nodeId);
				break;
			case 'remove':
				selected_nodeId = nodeId;
				//tree.remove(nodeId);
				removeDept();
				break;
		}
	});
	
	// tree-select event
	tree.on('select', function(e){
		selected_nodeId = e.nodeId;
		console.log('click: '+e.nodeId);
		//console.log('selected node data: '+nodeData.team_code,'/'+nodeData.team_name,'/'+nodeData.upper_code);
		loadContent(selected_tab, e.nodeId);
	});
	
	tree.on('beforeCreateChildNode', function(e) {
		if (event.cause === 'blur') {
			tree.finishEditing();
			tree.remove(e.nodeId);
			return false;
		}
		var result = confirm('새로운 부서를 추가하시겠습니까?');
		if(result){
			var add_param = {
				'team_code' : newTC,
				'team_name' : e.value,
				'upper_code': tree.getNodeData(selected_nodeId).team_code
			}
			console.log('add dept:',e.value,'-',add_param);
			createDept_ajax(add_param);
			tree.select(e.nodeId)

		}else{
			tree.finishEditing();
			tree.remove(e.nodeId);
			return false;
		}
		return result
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
			}else{
				tree.finishEditing();
				return false;
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
	$('#createDept_btn').on('click', function(){
		if(selected_nodeId != null){
			tree.createChildNode(selected_nodeId);
		}
	});

	//부서장 위임
	$('#changeLeader_btn').on('click', function(){
		console.log('checked list:',checked.size,'/',checked);
		var result = confirm('해당 사원을 부서장으로 위임하시겠습니까?')
		if(result){
			if(checked.size != 1){
				alert('부서장으로 위임할 사람을 1명 선택해주세요.')
			}else{
				var update_param = {
					'team_code'	: tree.getNodeData(selected_nodeId).team_code,
					'user_code'	: Array.from(checked)[0]
				}
				changeLeader_ajax(update_param);
			}			
		}
	});

	//수정중
	// 부서 이동
	$('#changeDept_btn').on('click', function(){
		console.log('checked list:',checked.size,'/',checked);
		if(checked.size == null){
			alert('선택된 항목이 없습니다.')
		} else{
			modal.show();
		}
	});
	
 	$('.form-check-input').on('click', function(){
		var code = $(this).attr('name');
		console.log('click:',code)
 		if(code == 'all'){
			if($(this).is(':checked')){
				$('.form-check-input').each(function(i, item){
					var user_code = $(item).attr('name');
					if(typeof user_code != 'undefined' || user_code != null){
						$(item).prop('checked', true);
						checked.add(user_code);
					}
		 		});
				checked.delete(code);
			}else{
				$(".form-check-input").prop("checked", false);
				checked.clear();
			}
		}else{
			if($(this).is(':checked')){
				$(this).prop("checked", true);
				checked.add(code);
			}else{
				$(this).prop("checked", false);
				checked.delete(code);
			}
		}
 		//console.log('checked list:',checked.size,'/',checked);
 	})
 	 //eventEnd

	 //ajax
	function getDept_ajax(){
		$.ajax({
			type	: 'get',
			url		: '/dept/list.ajax',
			dataType: 'json',
			success	: function(result){
	 			if(result.deptList.length > 0){
	 				console.log('::init TREE::')
	 				createTree(result.deptList);
	 				newTC = result.newTC;
				}else{
					console.log('dept list empty');
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
					console.log('dept member list empty');
				}
	 		},
			error	: function(error){
				console.log(error);
			}
		});
		return result_data;
	}
		
	function createDept_ajax(param){
		console.log('::create Dept::');
		console.log('param:',param);
		$.ajax({
			type	: 'post',
			url		: '/dept/register.ajax',
			data	: param,
			dataType: 'json',
			success	: function(result){
				console.log('createDept_ajax: ',result.msg);
				if(result.msg == 'success'){
					//alert('해당 부서가 등록되었습니다.');
					getDept_ajax();
				}
	 		},
			error	: function(error){
				console.log(error);
			}
		});
	}
	
	function removeDept_ajax(code){
		console.log(':: remove Dept -', code);
		
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
					//alert('해당 부서가 삭제되었습니다.');
					tree.remove(selected_nodeId);
					getDept_ajax()
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
	
	
	function changeLeader_ajax(param){
		console.log('::changeLeader_ajax::');
		console.log('param:',param);

		$.ajax({
			type	: 'get',
			url		: '/dept/user/update.ajax',
			data	: param,
			dataType: 'json',
			success	: function(result){
				console.log('changeLeader_ajax: ',result.msg);
				if(result.msg == 'success'){
					loadContent(selected_tab,selected_nodeId);
				}
	 		},
			error	: function(error){
				console.log(error);
			}
		});
	}	

	//ajaxEnd
	
	
	// method
	// 트리 생성
	function createTree(list){
		tree.removeAllChildren(rootId);
		
		list.forEach(function (data, idx){
			//console.log(idx,':', data);
			addNode(rootId, data);
 			//console.log('====================================================')
		});
		var ogTree = $('#deptTree').clone(true);
		var newTree = $('#changeDept_modal').find('.modal-body');
		newTree.append(ogTree);
		//console.log(newTree.html())
		modal.show()

		selected_nodeId = rootId;
		selected_tab = 'deptInfo';
		tree.select(selected_nodeId);
	}

	function addNode(id, data){
		var result;
		if(tree.getNodeData(id)){
			var code = tree.getNodeData(id).team_code;
			//console.log(code,':',data.team_code);
			
			if(code == data.upper_code){
				var addedNodeId = tree.add({text:data.team_name}, id);
				tree.setNodeData(addedNodeId, {
					team_code: data.team_code,
					team_name: data.team_name,
					upper_code: data.upper_code,
					reg_date: data.reg_date
				});
				//console.log('added node Id:',addedNodeId);
				//console.log('added node data: ',tree.getNodeData(addedNodeId))
				//console.log('upper:',code,'-',data.upper_code,'=>',id);
				result = true;
			}else{
				tree.getChildIds(id).forEach(function(child, i){
					//console.log(i,'child: ',child)
					addNode(child, data)
				});
			}
		}else{
			result = false;
		}
		return result;
	}

	// remove Dept
 	function removeDept(){
 		var data = tree.getNodeData(selected_nodeId);
		var result = confirm('해당 부서를 삭제 하시겠습니까?');
		if(result){
			console.log('remove param:',data.team_code)
			removeDept_ajax(data.team_code);
		}		
	}

	 function loadContent(type, nodeId){
		if(type == 'deptInfo'){
			var now = tree.getNodeData(nodeId);
			var parent = tree.getNodeData(tree.getParentId(nodeId));
			var child = tree.getNodeData(tree.getChildIds(nodeId)[0]);
			var ogTable = $('#deptInfo_table_sample tbody').clone(true);
			var newTable = $('#deptInfo_table');
			console.log('::load deptInfo table::');
			console.log('load: ',nodeId);
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
		
		} else if(type='deptUser'){
			console.log('::load deptUser list::');
			var code = tree.getNodeData(nodeId).team_code;
			var userList = getUser_ajax(code);
			var newList = $('#deptUser_list');
			//console.log('code: ', code);
			console.log('userList: ',userList);
			
			// 부서원 리스트 check-input 초기화
			$('.form-check-input').each(function(i, item){
				var user_code = $(item).attr('name');
				if(typeof user_code != 'undefined' || user_code != null){
					$(item).prop('checked', false);
					checked.clear();
				}
	 		});
			//console.log('checked list:',checked.size,'/',checked);
			
			// 부서원 리스트 출력
			newList.empty();
			if(userList.length > 0){
				userList.forEach(function(data, i){
					var ogList = $('#deptUser_list_sample li').clone(true);
					//console.log(i,':',data.name);
					ogList.find('input').attr('name',data.user_code);
					ogList.find('span').text(data.name+' '+data.class_name);
					
 					if(data.position_code == 'P01'){// 부서장
						newList.prepend(ogList);
					}else{	// 부서원
						newList.append(ogList);
					}
				});	
			}else{
				newList.append('<li class=\"list-group-item\"> no data </li>');
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
		}
	}
	
 // methodEnd

</script>
</html>