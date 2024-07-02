(function(module, $) {
	'use strict';

	// 모듈이 선언 안되어있다면 선언
	if (!module) {
		module = {};
	}

	// 이 후 사용되는 모듈명을 self로 통일
	var self = module;

	// 모듈내 Object 초기화 (예시로 tree라고 적어둠)
	self.pagination = {};

	// init 함수 (option으로 미리 세팅해야할 요소들을 세팅 할 수 있음)
	self.pagination.init = function(element, option, onPageClick) {
	
		//option을 안넣을경우 default로 들어갈 항목들을 정의
		var default_option = {
			totalPages: 1,
			startPage: 1
		};

		// default_option과 option을 merge (이 때, 병목되는 값이 있으면 option에 있는 값을 우선순위로 세팅)
		var final_option = Object.assign({}, default_option, option);
		
		var count = 0;
		var page = final_option.startPage;
		var totalPage = final_option.totalPages;
		
		
		element.empty();
		
		var content = '<li class="page-item">';
		content += '<a class="page-link" href="#">&laquo;</a>';
		content += '</li>';
		content += '<li class="page-item">';
		content += '<a class="page-link" href="#">&lsaquo;</a>';
		content += '</li>';
		
		if (page < 3) {
			for (var i = 1; i <= totalPage; i++) {
				content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
				count++;
				if (count == 5) {
					break;
				}
			}
		}else if (page >= 3 && page < (totalPage - 2)) {
			for (var i = page - 2; i <= totalPage; i++) {
				content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
				count++;
				if (count == 5) {
					break;
				}
			}
		}else if (page >= 3 && page >= (totalPage - 2)) {
			for (var i = totalPage - 4; i <= totalPage; i++) {
				if (i == 0) {
					continue;
				}
				content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
				count++;
				if (count == 5) {
					break;
				}
			}
		}
		
		content += '<li class="page-item">';
		content += '<a class="page-link" href="#">&rsaquo;</a>';
		content += '</li>';
		
		content += '<li class="page-item">';
		content += '<a class="page-link" href="#">&raquo;</a>';
		content += '</li>';
		
		element.html(content);
		element.find('.page-item').removeClass('active');
		
		$('.page-link').each(function() {
			if ($(this).html() == page) {
				$(this).parent().addClass('active');
			}
		});
		
		element.off('click', '.page-link').on('click', '.page-link', function(e) {
			e.preventDefault();
			
			if ($(this).html() == '«') {
				page = 1;
			}else if ($(this).html() == '‹') {
				if (page > 1) {
					page--;
				}
			}else if ($(this).html() == '›') {
				if (page < totalPage) {
					page++;
				}
			}else if ($(this).html() == '»') {
				page = totalPage;
			}else {
				page = parseInt($(this).html());
			}
			
			if (typeof onPageClick === 'function') {
				onPageClick(page);
			}
			
			self.pagination.init(element, {
				totalPages: totalPage,
				startPage: page
			});
			
		});
		
	}

// line 1에 선언된 module과 $에 대해서 무엇인지 명시
}(window, jQuery));