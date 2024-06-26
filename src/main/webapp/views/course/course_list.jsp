<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Dashboard - NiceAdmin Bootstrap Template</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- js -->

<style>
.pln_btn {
	height: 54px;
}

.board {
	background-color: white;
	padding: 15px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.card-header {
	font-weight: bold;
}
/*
.form-select{
	border: none;
    box-shadow: -1px 1px 6px #929297;
}

.form-control{
	border: none;
    box-shadow: 1px 1px 6px #929297;
}

.search-btn {
    border: none;
    box-shadow: 3px 1px 6px #929297;
}

*/

.search-btn {
	border: 1px solid lightgray;
}

.input-group-text{
	border:none;
}

.form-check-input:checked {
    background-color: #000000;
    border-color: #000000;
}

.w-50 {
    width: 37% !important;
}

.pointer{
	cursor: pointer;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>강의 관리</h1>
		</div>
		<!-- End Page Title -->
		<div class="row">
			<div class="col-2 rounded-5 p-3">
				<button class="btn btn-dark border-secondary pln_btn w-100" data-bs-toggle="modal" id="write_btn" onclick="course_wirte()">+ 강의 등록</button>
				<!-- End Schedule Button -->
				<div class="input-group mt-4">
					<div class="form-check form-switch" id="showYn">
						<input class="form-check-input" type="checkbox" id="showOnlytPreCourse">
						<label class="form-check-label" for="showOnlytPreCourse" id="preCourse">현재 진행예정인 강의만 보기</label>
					</div>
				</div>
			</div>
			<!-- End Schedule filter -->
			<div class="d-grid gap-2 col-10 mt-3 board h-100">
			<!-- 검색 -->
				<div class="input-group mb-3 w-50">
					<select class="form-select text-secondary" id="searchFilter" aria-label="Default select example">
						<option value="name">강사명</option>
						<option value="course_name">강의명</option>
						<option value="course_space">강의실</option>
					</select> 
					<input type="text" class="form-control w-25" id="searchContent" aria-label="Text input with dropdown button" onKeyPress="if(event.keyCode==13) { $('#searchClick').click();}">
					<button class="btn form-control btn-outline-secondary w-10 search-btn" id="searchClick" type="button"><i class="bi bi-search"></i></button>
				</div>

				<table class="table table-hover">
					<colgroup>
					<col width="15%" />
					<col width="30%" />
					<col width="15%" />
					<col width="20%" />
					<col width="20%" />
					</colgroup>
					<thead>
						<tr class="table-active">
							<th scope="col">강사</th>
							<th scope="col">강의명</th>
							<th scope="col">강의실</th>
							<th scope="col">강의시작일</th>
							<th scope="col">강의종료일</th>
						</tr>
					</thead>
					<tbody id="drawList"></tbody>
				</table>
				<div id="pagination-div">
					<ul class="pagination d-flex justify-content-center" id="pagination"></ul>
				</div>
			</div>
		</div>
		<input type="hidden" name="show_yn" id="checkBox"/>
	</main>
	<!-- End #main -->

<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
var page = 1;
var totalPage = 0;
var searchFilter = '';
var searchContent = '';
var showCourse =  $('#showOnlytPreCourse').is(':checked');
var checkCourse = $('#checkBox').val(showCourse ? 0 : 1);
//ture : 0 --> 현재진행중인강의만 false: 1 --> 마감된 강의까지 ALL
console.log("showCourse"+ showCourse);
console.log("checkCoursecheckCourse"+ $('#checkBox').val());

read_courseList(page, searchFilter, searchContent, showCourse);	

$('#showOnlytPreCourse').on('click',function(){
	showCourse =  $('#showOnlytPreCourse').is(':checked');
	read_courseList(page, searchFilter, searchContent, showCourse);
});

function read_courseList(page, searchFilter, searchContent, showCourse){
	$.ajax({
		url:'/course/list.ajax',
		type:'GET',
		dataType: 'JSON',
		data:{
			'page':page,
			'searchFilter':searchFilter,
			'searchContent':searchContent,
			'showCourse':showCourse
		},
		success: function(data){
			console.log(data);
			totalPage = data.totalPage;
			drawList(data.list);
			setupPagination(page, totalPage);
		},
		error:function(request, status, error){
			console.log(error);
		}
		
	});
}

function setupPagination(page, totalPage) {
	var pagination = $('#pagination');
	var count = 0;
	
	pagination.empty();
	
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
	
	pagination.html(content);
	pagination.find('.page-item').removeClass('active');
	
	$('.page-link').each(function() {
		if ($(this).html() == page) {
			$(this).parent().addClass('active');
		}
	});
	
}

$('#pagination').on('click', '.page-link', function(e) {
	e.preventDefault();
	// console.log(page);
	// console.log($(this).html());
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
	// console.log(page);
	read_courseList(page, searchFilter, searchContent);
});

function drawList(list){
	var con = '';
	for(var list of list){
		con += '<tr class="pointer" onclick="location.href=\'/course/detail.go?course_no=' + list.course_no + '\'">';
		con += '<td>'+list.name+'</td>';
		con += '<td>'+list.course_name+'</td>';
		con += '<td>'+list.course_space+'</td>';
		con += '<td>'+list.course_start.substring(0,10)+'</td>';
		con += '<td>'+list.course_end.substring(0,10)+'</td>';
		con += '</tr>';
	}
	$('#drawList').html(con);
}


$('#searchClick').click(function(){
	searchFilter = $('#searchFilter').val();
	searchContent = $('#searchContent').val();
	if(searchContent == ''){
		alert('검색어를 입력해주세요.');
		return;
	}
	read_courseList(page, searchFilter, searchContent);
});

function course_wirte(){
	location.href='/course/write.go'
}
</script>
</html>