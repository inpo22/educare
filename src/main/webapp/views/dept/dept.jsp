<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
<link rel="stylesheet" href="/resources/dept/css/style.css">
<!-- tui-tree -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.context-menu/latest/tui-context-menu.css" />
<link rel="stylesheet" href="/resources/dept/tui-tree/css/tree.css">
<script src="https://uicdn.toast.com/tui.context-menu/latest/tui-context-menu.js"></script>
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>
<!-- module -->
<script src="/resources/dept/js/deptModal_module.js"></script>
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
									<button id="createDept_btn" type="button" onclick="createDetp()"
										class="btn btn-outline-success m-1">
										<i class="bi bi-folder-plus"></i>
									</button>
									<button id="removeDept_btn" type="button" onclick="removeDept()"
										class="btn btn-outline-danger m-1">
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
								<ul class="nav nav-tabs nav-tabs-bordered d-flex" id="tabList"
									role="tablist">
									<li class="nav-item flex-fill" role="presentation">
										<button class="nav-link w-100 active" id="deptInfo_tab"
											onclick="clickTab('deptInfo')" data-bs-toggle="tab"
											data-bs-target="#deptInfo_tab_content" type="button"
											role="tab" aria-controls="deptInfo" aria-selected="true">
											부서 정보</button>
									</li>
									<li class="nav-item flex-fill" role="presentation">
										<button class="nav-link w-100" id="deptUser_tab"
											onclick="clickTab('deptUser')" data-bs-toggle="tab"
											data-bs-target="#deptUser_tab_content" type="button"
											role="tab" aria-controls="deptUser" aria-selected="false">
											부서원 리스트</button>
									</li>
								</ul>
								<!-- TabsEnd -->

							</div>
							<!-- care-header End -->
							<div id="card-body-list" class="card-body">
								<!-- 부서 card body 내용 -->
								<div class="tab-content mt-3" id="tabContent">
									<div class="tab-pane ms-5 fade show active"
										id="deptInfo_tab_content" role="tabpanel"
										aria-labelledby="deptInfo_tab">
										<table id="deptInfo_table" class="table table-borderless">
										</table>
									</div>
									<div class="tab-pane fade" id="deptUser_tab_content"
										role="tabpanel" aria-labelledby="deptUser_tab">
										<input class="form-check-input me-3" type="checkbox" name="all">
										<button type="button" id="changeLeader" onclick="changeLeader()"
											class="btn btn-outline-primary btn-sm  me-2">부서장 위임</button>
										<button type="button" id="moveMember_btn"
											class="btn btn-outline-primary btn-sm">부서 이동</button>
										<br /> <br />
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
			<input class="form-check-input me-2" type="checkbox"> 
			<i class="ri-account-circle-fill"></i>
			<a class="list_userLink" href="#">
				<span class="list_userName me-2"></span>
				<span class="badge rounded-pill bg-primary badge-leader">팀장</span>
			</a>
		</li>
	</ul>
	<!-- deptUser List End -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

	<!-- changeDept_Modal -->
	<div class="modal fade" id="updateMemberDept_modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">부서 이동</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div id="modalTree" class="tui-tree-wrap" data-bs-spy="scroll"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary btn-sm" onclick="moveMember()">이동</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End changeDept_Modal -->



</body>
<script>
	$(document).ready(function() {
		loadTree();
	});
	
	var selected_tab;
	var checked = new Set();
	var checkName = /^[가-힣]|[A-Z]|[a-z0-9]$/;

	// tree module
	var mainModule = treeModule.init({
		id: 'main',
		treeId: '#deptTree',
		modalId:'updateMemberDept_modal'
	});
	var tree = mainModule.var.tree;				// tree 객체
	var rootId = mainModule.var.rootId;	// 선택한 트리 rootId
	var selected_id = mainModule.var.selectId;	// 선택한 부서 nodeId

	var subModule = treeModule.init({
		id: 'sub',
		nodeId: 'tui-tree-node-3',
		modalId:'updateMemberDept_modal'
	});
	var modalTree = subModule.var.tree;				// tree 객체
	var modal = subModule.var.tree.modal;		// modal 객체	
	var modal_rootId = subModule.var.rootId;	// 선택한 트리 rootId
	var selected_modalId = subModule.var.selectId;	// 선택한 부서 nodeId

	// event
	// tree-select event
	tree.on('select', function(e){
		selected_id = e.nodeId;
		//console.log('click: '+e.nodeId);
		//console.log('selected node data: '+nodeData.team_code,'/'+nodeData.team_name,'/'+nodeData.upper_code);
		//console.log('tab:',selected_tab,'id:',selected_id);
		clickTab(selected_tab);
	});
	
	modalTree.on('select', function(e){
		//console.log('modal click: '+e.nodeId);
		var data = modalTree.getNodeData(e.nodeId);
		
		if(tree.getNodeData(selected_id).team_code != data.team_code){
			selected_modalId = e.nodeId;
			//console.log('selected node data: '+data.team_code,'/'+data.team_name,'/'+data.upper_code);			
		}else{
			alert('이미 해당 부서입니다. 다른 부서를 선택해주세요.');
			selected_modalId = modalTree.getRootNodeId();
		}
		//console.log('now selected:',selected_modalId);
		
	});

	// add tree option
	tree.enableFeature('Draggable', {
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
		
		tree.select(e.nodeId);
		
		switch (command) {
			case 'create':
				tree.createChildNode(nodeId);
				break;
			case 'update':
				tree.editNode(nodeId);
				break;
			case 'remove':
				selected_id = nodeId;
				//tree.remove(nodeId);
				removeDept();
				break;
		}
	});
	
	tree.on('beforeCreateChildNode', function(e) {
		var result = confirm('새로운 부서를 추가하시겠습니까?');
		var validation = checkName.test(e.value);
		
		if (event.cause === 'blur') {
			tree.finishEditing();
			tree.remove(e.nodeId);
			return false;
		} else if(result){
			if(!validation){
				alert('사용할 수 없는 부서명입니다. 다시 입력해주세요.')
				//console.log(e.value,'- 유효성 결과: ',validation);
				tree.finishEditing();
				tree.remove(e.nodeId);
				return false;
			}else {
				var add_param = {
					'team_name' : e.value,
					'upper_code': tree.getNodeData(selected_id).team_code
				}
				//console.log('add dept:',e.value,'-',add_param);
				createDept_ajax(add_param);
				selected_tab = 'deptInfo';
				tree.select(e.nodeId)
			}
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
		var result = confirm('부서명을 수정하시겠습니까?');
		var data = tree.getNodeData(e.nodeId);
		var validation = checkName.test(e.value);
		
		if(result){
			if(data.team_name == e.value){
				alert('기존 부서명과 동일합니다. 다시 입력해주세요.');
				tree.finishEditing();
				return false;
			}else if(!validation){
				alert('사용할 수 없는 부서명입니다. 다시 입력해주세요.');
				//console.log(e.value,'- 유효성 결과: ',validation);
				tree.finishEditing();
				return false;
			}else {
				var edit_name = e.value;
				var edit_param = {
						'nodeId'	: e.nodeId,
						'team_code'	: data.team_code,
						'team_name'	: edit_name,
						'type'	: 'name'
				}
				//console.log("::edit Dept::");
				//console.log(data.team_code,':',data.team_name,'->',edit_name);
				updateDept_ajax(edit_param);	// update DB
			}
		}else{
			tree.finishEditing();
			return false;
		}
	});

	// tree-move event
	tree.on('beforeMove', function(e) {
		var edit_data = tree.getNodeData(e.nodeId);
		var og_upper = tree.getNodeData(tree.getParentId(e.nodeId));
		var new_upper = tree.getNodeData(e.newParentId);
		//console.log('::move Dept::');
		//console.log(edit_data.team_code,':',og_upper.team_name,'->',new_upper.team_name);
		if(new_upper.team_name != null){
			var move_param = {
				'nodeId'	: e.nodeId,
				'team_code'	: edit_data.team_code,
				'upper_code': new_upper.team_code,
				'type'	: 'code'
			}
			//tree.setNodeData(e.nodeId, {upper_code: new_upper.team_code});	// update node data
			updateDept_ajax(move_param);	// update DB
			selected_tab = 'deptInfo';

		}else{
			//console.log('update fail');
		}
	});
	
	// basic event
	// open modal to move dept of member
	$('#moveMember_btn').on('click', function(){
		//console.log('checked list:',checked.size,'/',checked);
		if(checked.size == null || checked.size < 1){
			alert('부서 이동시킬 부서원을 1명 이상 선택 해주세요.');
			clearChecked();
		} else{
			treeModule.loadTree(subModule);
			selected_modalId = modal_rootId;
			modalTree.select(selected_modalId);
			modal.show();
		}

	});	
	// all/each check-box event
 	$('.form-check-input').on('click', function(){
		var code = $(this).attr('name');
		//console.log('click:',code)
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
 	});
	// close button event
 	$('.btn-close').on('click',function(){
		//console.log('close');
		modal.hide();
		clearChecked();
	});
	//eventEnd

	//ajax
 	function getMember_ajax(code){
		var ajax_result;
		//console.log('::init Dept Members::')
		$.ajax({
			type	: 'get',
			url		: '/dept/member/list.ajax',
			data	:	{
				'team_code'	: code
			},
			dataType: 'json',
			async	: false,
			success	: function(result){
				var newList = $('#deptUser_list');
 				var emp_cnt = result.userList.length;
				//console.log('userList: ',result.userList);
				//console.log('부서 인원수: ', emp_cnt);
				//부서 인원수 부서 정보에 저장
				tree.setNodeData(selected_id, {
					emp_cnt: emp_cnt
				});
				// 부서원 리스트 출력
				newList.empty();
				if(emp_cnt > 0){
					result.userList.forEach(function(data, i){
						var ogList = $('#deptUser_list_sample li').clone(true);
						//console.log(i,':',data.name);
						ogList.find('input').attr('name', data.user_code);
						ogList.find('a').attr('href', '/emp/detail.go?user_code='+data.user_code);
						ogList.find('.list_userName').text(data.name+' '+data.class_name);

						if(data.position_code == 'P01'){// 부서장
	 						//console.log('부서장: ',data.user_code);
	 						//ogList.find('.badge-member').attr('style', "display:none;");
							newList.prepend(ogList);
	 						
						}else{	// 부서원
	 						ogList.find('.badge-leader').attr('style', "display:none;");
							newList.append(ogList);
						}
					});	
				}else{
					newList.append('<li class=\"list-group-item\"> 해당 부서는 부서원이 없습니다. </li>');
				}
				newList.attr('style', "display:'';");
	 		},
			error	: function(error){
				console.log(error);
			}
		});
		
		return ajax_result;
	}
		
	function createDept_ajax(param){
		//console.log('::create Dept::');
		//console.log('param:',param);
		$.ajax({
			type	: 'post',
			url		: '/dept/register.ajax',
			data	: param,
			dataType: 'json',
			success	: function(result){
				//console.log('createDept_ajax: ',result.msg);				
				if(result.msg == 'success'){
					//alert('해당 부서가 등록되었습니다.');
					loadTree();
				}
	 		},
			error	: function(error){
				//console.log(error);
			}
		});
	}
	
	function removeDept_ajax(code){
		//console.log(':: remove Dept -', code);
		$.ajax({
			type	: 'get',
			url		: '/dept/delete.ajax',
			data	: {
				'team_code': code
			},
			dataType: 'json',
			success	: function(result){
				//console.log('removeDept_ajax: ',result.msg);
				
				if(result.msg == 'success'){
					//alert('해당 부서가 삭제되었습니다.');
					tree.remove(selected_id);
					loadTree();
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
				//console.log('updateDept_ajax:',result.msg);
				if(result.msg == 'success'){
					if(result.type == 'code'){
					 	tree.on('move', function(e){
							tree.setNodeData(e.nodeId, {upper_code: param.team_code});	// update node data
							selected_id = e.nodeId;
							//console.log('updated node data: ',tree.getNodeData(e.nodeId));
					 	});
					}else if(result.type == 'name'){
						tree.finishEditing();
						tree.setNodeData(param.nodeId, {team_name: param.team_name});	// update node data
						selected_id = param.nodeId;
						//console.log('updated node data: ', tree.getNodeData(param.nodeId));
					}
					loadTree();
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
		//console.log('::changeLeader_ajax::');
		//console.log('param:',param);
		$.ajax({
			type	: 'post',
			url		: '/dept/leader/update.ajax',
			data	: param,
			dataType: 'json',
			success	: function(result){
				//console.log('changeLeader_ajax: ',result.msg);
				if(result.msg == 'success'){
					alert('부서장으로 변경되었습니다.')	
					tree.select(selected_id);
				}else{
					alert('변경 실패');
				}
	 		},
			error	: function(error){
				console.log(error);
			}
		});
	}

	function moveMember_ajax(param){
		//console.log('::moveMember_ajax::');
		//console.log('param:',param);
		$.ajax({
			type		: 'post',
			url			: '/dept/member/update.ajax',
			data		: param,
			dataType	: 'json',
			contentType	: 'application/x-www-form-urlencoded; charset=UTF-8',
			success	: function(result){
				//console.log('moveMember_ajax: ',result.msg);
				if(result.msg == 'success'){
					alert('해당 부서원(들)을 부서 이동했습니다.');
					loadTree();
				}else  {
					alert('부서 이동을 실패했습니다 다시 시도해주세요.')
				}

	 		},
			error	: function(error){
				console.log(error);
			}
		});
	}
	//ajaxEnd
	
	
	// method
	function loadTree(){
		treeModule.loadTree(mainModule);
		selected_tab = 'deptInfo';
		tree.select(selected_id);
		clearChecked();
	}
	// tab click
	function clickTab(type){
		//console.log('click tab: ',type);
		selected_tab = type;
		clearChecked();
		if(type == 'deptInfo'){
			$('#deptInfo_tab').addClass('active');
			$('#deptUser_tab').removeClass('active');
			$('#deptInfo_tab_content').addClass('active show');
			$('#deptUser_tab_content').removeClass('active show');
			getDeptInfo(selected_id);
		}else if(type='deptUser'){
			//console.log('::load deptUser list::');
			$('#deptUser_tab').addClass('active');
			$('#deptInfo_tab').removeClass('active');
			$('#deptUser_tab_content').addClass('active show');
			$('#deptInfo_tab_content').removeClass('active show');
			getMember_ajax(tree.getNodeData(selected_id).team_code);
		}
	}
	
	function getDeptInfo(nodeId){
		var now = tree.getNodeData(nodeId);
		var parent = tree.getNodeData(tree.getParentId(nodeId));
		var child = tree.getNodeData(tree.getChildIds(nodeId)[0]);
		var code = tree.getNodeData(nodeId).team_code;
		//console.log('load: ',nodeId);
		//console.log('parent:',parent.team_name);
		//console.log('child:',child);
		//console.log('code: ', code);
		//selected_modalId = modal_rootId;
		modal.hide();
		
		//console.log('::load deptInfo table::');
		var ogTable = $('#deptInfo_table_sample tbody').clone(true);
		var newTable = $('#deptInfo_table');
		
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
	}

	function createDetp(){
		if(selected_id != null){
			tree.createChildNode(selected_id);
		}
	}
	
	function removeDept(){
		var data = tree.getNodeData(selected_id);
		var result = confirm('해당 부서를 삭제 하시겠습니까?');
		if(result){
			if(data.emp_cnt > 0){
				alert('해당 부서는 부서원이 있어 삭제가 불가능합니다.');
			}else {
				//console.log('remove param:',data.team_code)
				removeDept_ajax(data.team_code);
			}
		}		
	}
	
 	function changeLeader(){
		//console.log('checked list:',checked.size,'/',checked);
		var result = confirm('해당 사원을 부서장으로 위임하시겠습니까?')
		
		if(result){
			if(checked.size != 1){
				alert('부서장으로 위임할 사람을 1명 선택해주세요.');
				clearChecked();
			}else{
				var update_param = {
						'team_code'	: tree.getNodeData(selected_id).team_code,
						'user_code'	: Array.from(checked)[0]
				}
				changeLeader_ajax(update_param);
			}			
		} else{
			clearChecked();
		}
		
	}

	function moveMember(){
		//console.log('checked list:',checked.size,'/',checked);
		var result = confirm('해당 부서로 이동시키겠습니까?');
		var update_list = [];
		if(result){
			var newData = modalTree.getNodeData(selected_modalId);
			var update_param = {
					'team_code'	: newData.team_code,
					'users'		: Array.from(checked)
			}
			moveMember_ajax(update_param);
			//console.log('update_param:',update_param);
			
		} else{
			clearChecked();
		}
	}
	// reset check-box set
	function clearChecked(){
		$('.form-check-input').each(function(i, item){
			var user_code = $(item).attr('name');
			if(typeof user_code != 'undefined' || user_code != null){
				$(item).prop('checked', false);
				checked.clear();
			}
		});
	}
	// methodEnd
</script>
</html>