(function(module, $) {
    'use strict';

    // 모듈이 선언 안되어있다면 선언
    if (!module) {
        module = {};
    }

    // 이 후 사용되는 모듈명을 self로 통일
    var self = module;

    // 모듈내 Object 초기화 (예시로 tree라고 적어둠)
    self.tree = {};

    // init 함수 (option으로 미리 세팅해야할 요소들을 세팅 할 수 있음)
    self.tree.init = function(option) {
        //option을 안넣을경우 default로 들어갈 항목들을 정의
        var default_option = {
            id: null,
            treeId: '#deptTree',
            data: [{id: 'T00', text: '에듀케어'}],
            nodeDefaultState: 'opened',
            nodeId: 'tui-tree-node-1',
            selected_tab: 'deptInfo',
            modalId:'createDeptModal',
            modalOption: {keyboard: false}
        };

        // default_option과 option을 merge (이 때, 병목되는 값이 있으면 option에 있는 값을 우선순위로 세팅)
        var final_option = Object.assign({}, default_option, option);

        if (final_option.id == null) {
            alert('id는 필수입력값입니다.');
            return false;
        }
        // 트리 선언
        self.tree[final_option.id] = {};
        var tree_object = self.tree[final_option.id];
        // 변수 초기화 (js 밖에서도 컨트롤 or 조회 가능하게 할 변수만 선언)
        tree_object.var = {};

        // 변수
        tree_object.var.selected_nodeId = final_option.nodeId;
        tree_object.var.selected_tab = final_option.selected_tab;

        var tree_option = {};
        tree_option.data = final_option.data;
        tree_option.nodeDefaultState = final_option.nodeDefaultState;
        // 부서 트리 객체 생성
        tree_object.var.tree = new tui.Tree(final_option.treeId, tree_option);

        // modal 객체
        tree_object.var.tree.createDeptModal = new bootstrap.Modal( document.getElementById(final_option.modalId), final_option.modalOption );

        /*
        코드 작성
         */

        // 상위 Object를 리턴하거나 대표 var를 리턴하거나 window.tree 이렇게 접근 가능해서 굳이 리턴 없어도 됨.
        return tree_object;
    }

    // function start
    self.tree.fn명 = function(id명, 파라미터){
        /*
        코드 작성
         */
    }
    // function end

// line 1에 선언된 module과 $에 대해서 무엇인지 명시
}(window, jQuery));