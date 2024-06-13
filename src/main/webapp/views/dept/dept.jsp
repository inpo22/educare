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
							<!-- care-header End -->
							<div class="card-body">
								<div id="tree" class="tui-tree-wrap"></div>
							</div>
							<!-- care-body End -->
						</div>
						<!-- care End -->
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
						<!-- care End -->

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
var data = [
    {text: '에듀케어', children: [
        {text: '대표', children: [
            {text:'행정관리팀', children:[
                {text:'입학 관리'},
                {text:'기획 총무'}
            ]},
            {text:'교무실', children:[
                {text:'고1'},
                {text:'고2'},
                {text:'고3'}
            ]},
            {text:'입학 지원팀', children:[
                {text:'진로 상담'}
            ]}
         ]}
    ]}
];


var tree = new tui.Tree('#tree', {
	data: data,
    nodeDefaultState: 'opened',
    template: {
        internalNode: // Change to Mustache's format
            '<div class="tui-tree-content-wrapper" style="padding-left: {{indent}}px">' + // Example for using indent value
                '<button type="button" class="tui-tree-toggle-btn tui-js-tree-toggle-btn">' +
                    '<span class="tui-ico-tree"></span>' +
                    '{{stateLabel}}' +
                '</button>' +
                '<span class="tui-tree-text tui-js-tree-text">' +
                    '<span class="tui-tree-ico tui-ico-folder"></span>' +
                    '{{text}}' +
                '</span>' +
            '</div>' +
            '<ul class="tui-tree-subtree tui-js-tree-subtree">' +
                '{{children}}' + // Mustache's format
            '</ul>',
        leafNode:
            '<div class="tui-tree-content-wrapper" style="padding-left: {{indent}}px">' + // Example for using indent value
                '<span class="tui-tree-text {{textClass}}">' +
                    '<span class="tui-tree-ico tui-ico-file"></span>' +
                    '{{text}}' +
                '</span>' +
            '</div>'
    }
});

// Bind custom event
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