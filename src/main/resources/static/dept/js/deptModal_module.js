/**
 * department tree modal module
 * 모달 스크롤 기능 생성: deptModal.jsp의 <style> 내용 확인
 * tree 이벤트 추가: deptModal.jsp에서 이벤트 추가
 */
var treeModule = (function (module,$){

	if (!module) {
		module = {};
	}

	var self = module;	// 모듈명
	
	self.tree = {};		// 모듈 object
	
	// create init tree
	self.tree.init = function(option){
	
		var default_option = {
			id: null,
			treeId: '#modalTree',
			data: [{
				text: '에듀케어',
				team_code: 'T000',
				team_name: '에듀케어',
				upper_code: 'T000',
				reg_date: '2002-02-02'
			}],			
			nodeDefaultState: 'opened',
			nodeId: 'tui-tree-node-1',
			modalId:'deptTree_modal',
			modalOption: {keyboard: false}
		};
		// final_option = defalut_option + new_option
		var final_option = Object.assign({}, default_option, option);
		if(final_option.id == null){
			return false;
		}

		var tree_option = {};
		tree_option.data = final_option.data;
		tree_option.nodeDefaultState = final_option.nodeDefaultState;
		
		self.tree[final_option.id] = {};
		var tree_obj = self.tree[final_option.id];

		tree_obj.var = {};
		tree_obj.var.rootId = final_option.nodeId;
		tree_obj.var.selectId = final_option.nodeId;	

		// tree instance
		tree_obj.var.tree = new tui.Tree(final_option.treeId, tree_option);
		// set tree root node data
		tree_obj.var.tree.setNodeData(tree_obj.var.rootId, final_option.data);
		//console.log('tree init obj:',tree_obj.var.tree.getNodeData(tree_obj.var.rootId))
		// tree select event
		tree_obj.var.tree.enableFeature('Selectable', {
			selectedClassName: 'tui-tree-selected',
		});

		// tree modal
		tree_obj.var.tree.modal = new bootstrap.Modal(
			document.getElementById(final_option.modalId), { keyboard: false } );
		
		return tree_obj;
	}
	
	// load dept in tree
	self.tree.loadTree = function(tree_obj){
		var tree = tree_obj.var.tree;
		var rootId = tree_obj.var.rootId;
		
		$.ajax({
			type	: 'get',
			url		: '/dept/list.ajax',
			dataType: 'json',
			async: false,
			success	: function(result){
				// clear node
				tree.removeAllChildren(rootId);
	 			if(result.deptList.length > 0){
	 				//console.log(result.deptList);
	 				// create tree
 					result.deptList.forEach(function (data, idx){
						//console.log(idx,':', data);
						addNode(rootId, data);
					});
	 				tree_obj.var.selectId = rootId;
	 				tree.select(rootId);
				}else{
					console.log('no dept');
				}
	 		},
			error	: function(error){
				console.log(error);
			}
		});//End ajax
		
		function addNode(id, data){
			if(tree.getNodeData(id)){
				var code = tree.getNodeData(id).team_code;
				//console.log(code,'(',tree.getNodeData(id).team_name,') :',data.upper_code);
				
				if(code == data.upper_code){
					var addedId = tree.add({
						text: data.team_name,
						value: data.team_code
						}, id);
					tree.setNodeData(addedId, {
						team_code: data.team_code,
						team_name: data.team_name,
						upper_code: data.upper_code,
						reg_date: data.reg_date
					});
					//console.log('added id:', addedId);
					return true;
				}else{
					tree.getChildIds(id).forEach(function(child, i){
						//console.log(child,':', data);
						addNode(child, data);
					});
				}
			}else{
				return false;
			}
		}//End addNode
		
	}//End loadTree
	
	// load member in tree
	self.tree.loadMember = function(tree_obj){
		var tree = tree_obj.var.tree;
		var rootId = tree_obj.var.rootId;
		
		$.ajax({
			type:'get',
			url:'/approval/deptList.ajax',
			data:{},
			dataType:'JSON',
			async: false,
			success:function(result) {
				//console.log(result.empList);
				// create tree
				result.empList.forEach(function (data, idx){
					//console.log(idx,':', data);
					addNode(rootId, data);
				});
				
			},
			error:function(error) {
				console.log(error);
			}
		});
		
		function addNode(id, data){
			var result;
			if(tree.getNodeData(id)){
				var code = tree.getNodeData(id).team_code;
				
				if(code == data.team_code){
					var addedId = tree.add({
						text: data.user_name+' '+data.class_name,
						value: data.user_code
						}, id);
						
					tree.setNodeData(addedId, {
						team_code	: data.team_code,
						user_name	: data.user_name,
						user_code	: data.user_code,
						class_name	: data.class_name
					});
					
					result = true;
				}else{
					tree.getChildIds(id).forEach(function(child, i){
						//console.log(i,'child: ',child)
						addNode(child, data);
					});
				}
			}else{
				result = false;
			}
			return result;
		}
	
	}
	
	// return self.tree
	return {
		init		: self.tree.init,
		loadTree	: self.tree.loadTree,
		loadMember	: self.tree.loadMember
	}

}(window, jQuery));