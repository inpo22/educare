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
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css" />
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>
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
					<div class="col-lg-4">
						<!-- 조직도 card -->
						<div class="card">
							<div class="card-header border-0">
								<div class="d-flex justify-content-between">
									<h3 class="card-title">조직도</h3>
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
	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
	$(document).ready(function() {
		
	});
	
	// 부서 트리
	var tree = new tui.Tree('#deptTree', {
		data: [{id: 'T00', text: '에듀케어', hashChild:true }],
		nodeDefaultState: 'opened'
	}).enableFeature('Editable', {
		dataKey: 'text'
	});

	//ajax
	$.ajax({
		type	: 'get',
		url		: '/dept/list',
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
	
	// method
	function createTree(list){
		tree.createChildNode('tui-tree-node-1');
		list.forEach(function (data, idx){
			//treeData[idx] = {id: data.team_code, parent: data.upper_code, text: data.team_name}
			var upper_code = 2+Number(data.upper_code.substring(1));
			console.log(idx,': ', upper_code);
			if(data.upper_code == 'T00'){
				console.log('상위 부서: ',data);
				tree.add({text:data.team_name}, 'tui-tree-node-1');
			}else{
				console.log('하위 부서: ',data);				
				tree.add({text:data.team_name}, 'tui-tree-node-'+upper_code);
			}
			
		});
	}
	
	
	//event
	//tree event
	tree.on('selectContextMenu', function(e) {
	    var command = e.command;
	    var nodeId = e.nodeId;
	
	    switch (command) {
	        case 'create':
	            tree.createChildNode(nodeId);
	            break;
	        case 'update':
	            tree.editNode(nodeId);
	            break;
	        case 'remove':
	            tree.remove(nodeId);
	            break;
	    }
	});
	
	tree.on('beforeCreateChildNode', function(event) {
	    if (event.cause === 'blur') {
	        tree.finishEditing();
	        tree.remove(event.nodeId);
	        return false;
	    }
	    return confirm('Are you sure you want to create?');
	});
	
	tree.on('beforeEditNode', function(event) {
	    if (event.cause === 'blur') {
	        tree.finishEditing();
	        return false;
	    }
	    return confirm('Are you sure you want to edit?');
	});
	
	tree.on('beforeMove', function() {
	    console.log('before move');
	});
	
	tree.on('beforeAjaxRequest', function(eventData) {
	    print('beforeAjaxRequest', eventData);
	})
	
	tree.on('successAjaxResponse', function(eventData) {
	    print('successAjaxResponse', eventData);
	});
	
	function print(title, jsonData) {
	    var textareaId = title.replace(/([A-Z])/g, '-$1').toLowerCase();
	    var message = title + ' : \n';
	    message += JSON.stringify(jsonData, null, 8);
	
	    document.getElementById(textareaId).value = message
	}
	
	// Add features
	tree.enableFeature('Selectable')
	    .enableFeature('Editable', {
	    dataKey: 'text'
	}).enableFeature('Draggable', {
	    isSortable: true
	}).enableFeature('ContextMenu', {
	    menuData: [
	        {title: 'create', command: 'create'},
	        {title: 'update', command: 'update'},
	        {title: 'remove', command: 'remove'}
	    ]
	}).enableFeature('Ajax', {
	    command: {
	        read: {
	            url: 'data/tree.json',
	            contentType: 'application/json',
	            params: function(treeData) {
	                return {
	                    productId: tree.getNodeData(treeData.nodeId).pid
	                };
	            }
	        },
	        create: {
	            url: 'data/response.json',
	            contentType: 'application/json',
	            params: function(treeData) {
	                return {
	                    targetId: tree.getNodeData(treeData.parentId).pid,
	                    productName: treeData.data.text
	                };
	            }
	        },
	        update: {
	            url: 'data/response.json',
	            contentType: 'application/json',
	            params: function(treeData) {
	                return {
	                    productId: tree.getNodeData(treeData.nodeId).pid,
	                    productName: treeData.data.text
	                };
	            }
	        },
	        remove: {
	            url: 'data/response.json',
	            contentType: 'application/json',
	            params: function(treeData) {
	                return {
	                    productId: tree.getNodeData(treeData.nodeId).pid
	                };
	            }
	        },
	        move: {
	            url: 'data/response.json',
	            contentType: 'application/json',
	            params: function(treeData) {
	                return {
	                    productId: tree.getNodeData(treeData.nodeId).pid,
	                    targetId: tree.getNodeData(treeData.newParentId).pid,
	                    moveIdx: treeData.index
	                };
	            }
	        }
	    },
	    parseData: function(command, responseData) {
	        if (command === 'read') {
	            return responseData.tree;
	        } else {
	            return true;
	        }
	    }
	});



</script>
</html>