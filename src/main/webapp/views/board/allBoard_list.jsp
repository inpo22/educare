<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
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
#backBoard{
	background-color: white;
	width: 100%;
    height: 110%; /* 높이를 원하는 크기로 설정 */
	border-radius: 20px;
}

#allBoardTitle{
	margin-left: 20px;
}

.table {
	text-align: center;
}
.searchContainer{
	float: right;
    margin-right: 20px;
}
/* #searchBtn{
	background-color: rgba(52, 152, 219, 0.76);
	color: white;
	font-weight: bold;
	border-radius: 10px;
	border:none;
	width:80px;
	height:30px;
} */
.card-body{
	display: flex;
    justify-content: center; /* 자식 요소들을 가로축 기준으로 가운데 정렬 */
    width: 100%;
}
.write{
	float:right;
	margin-right: 20px;
	border:none;
	border-radius: 10px;
	width:80px;
	height: 30px;
}
.table .boardTableTr:hover {
    --bs-table-bg: lightgray;
    cursor: pointer;
}

#allBoardTitle:hover{
	cursor: pointer;
	color: rgba(52, 152, 219, 0.76);
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>

	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<br/>
			<div class="pagetitle">
				<h1 id="allBoardTitle">전사 공지사항</h1>
			</div>
			<div class="searchContainer">
				<select id="searchCategory" >
					<option value="title">제목</option>
					<option value="writer">작성자</option>
					<option value="contents">내용</option>
				</select>
				<input type="text" id="searchWord" placeholder="검색단어입력" maxlength="30"/>
				<input type="button" id="searchBtn" value="검색" class="btn btn-primary"/>
			</div>
			<br/><br/>
			<table class="table">
				<colgroup>
					<col width="5%" />
					<col width="25%" />
					<col width="10%" />
					<col width="10%" />
					<col width="15%" />
					<col width="5%" />
				</colgroup>
				<thead>
				  <tr>
					<th scope="col">No.</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">부서명</th>
					<th scope="col">작성일자</th>
					<th scope="col">조회수</th>
				  </tr>
				</thead>
				<tbody id="list">
				  
				</tbody>
			</table>
			<button class="write" onclick="location.href='/allBoard/write.go'">글쓰기</button>
			<ul class="pagination d-flex justify-content-center" id="pagination"></ul>
			  
		</div>
		<!-- End Page Title -->

	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
var topFixedContext = '';
var page = 1;
var totalPage = 0;
var searchCategory = '';
var searchWord = '';
var topFixed = false;
var searchFlag = false;
listCall(page, searchCategory, searchWord);

function formatDate(dateStr) {
	const options = {year: 'numeric', month: '2-digit', day: '2-digit' };
	const date = new Date(dateStr);
	return date.toLocaleDateString('kr-KO', options);
}

function listCall(page, searchCategory, searchWord){
	$.ajax({
		type: 'post',
		url: '/allBoard/list.ajax',
		data: {
			'page': page,
			'searchCategory':searchCategory,
			'searchWord':searchWord
		},
		dataType: 'JSON',
		success: function(data){
			console.log(data);
			var context = '';
			totalPage = data.totalPage;
			if(topFixed == false){
				for (item of data.topFixedList){
					topFixedContext += '<tr class="boardTableTr" onclick="locationMove('+item.post_no+')">'
					topFixedContext += '<td scope="col"><b>'+ item.post_no +'</b></td>'
					topFixedContext += '<td scope="col"><b>' + item.title + '</b></td>'
					topFixedContext += '<td scope="col"><b>' + item.user_name + ' ' + item.class_name + '</b></td>'
					topFixedContext += '<td scope="col"><b>' + item.team_name + '</b></td>'
					topFixedContext += '<td scope="col"><b>' + formatDate(item.reg_date) + '</b></td>'
					topFixedContext += '<td scope="col"><b>' + item.bHit + '</b></td>'
					topFixedContext += '</tr>';
				}
				topFixed = true;
			}
			if(searchFlag == true){
				for (item of data.list){
						context += '<tr class="boardTableTr" onclick="locationMove('+item.post_no+')">'
						context += '<td scope="col">'+ item.post_no +'</td>'
						context += '<td scope="col">' + item.title + '</td>'
						context += '<td scope="col">' + item.user_name + ' ' + item.class_name + '</b></td>'
						context += '<td scope="col">' + item.team_name + '</td>'
						context += '<td scope="col">' + formatDate(item.reg_date) + '</td>'
						context += '<td scope="col">' + item.bHit + '</td>'
						context += '</tr>';
				}			
			}else{
				for (item of data.list){
					if(item.fixed_yn == 0){
						context +=  '<tr class="boardTableTr" onclick="locationMove('+item.post_no+')">'
						context += '<td scope="col">'+ item.post_no +'</td>'
						context += '<td scope="col">' + item.title + '</td>'
						context += '<td scope="col">' + item.user_name + ' ' + item.class_name + '</b></td>'
						context += '<td scope="col">' + item.team_name + '</td>'
						context += '<td scope="col">' + formatDate(item.reg_date) + '</td>'
						context += '<td scope="col">' + item.bHit + '</td>'
						context += '</tr>';
					}
				}			
			}
			if(page > 1 || searchFlag){
				$('#list').html(context);
			}else{
			$('#list').html(topFixedContext+context);
			}
			setupPagination(page, totalPage);
		},
		error: function(error){
			console.log(error);
		}
	});
}

function locationMove(post_no){
	location.href='/allBoard/detail.go?post_no='+post_no;
}
//totalPage 활용하여 Pagination 버튼 설정
// totalPage 활용하여 Pagination 버튼 설정
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

//설정된 버튼에 이벤트 적용
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
	listCall(page, searchCategory, searchWord);
	
});

$('#searchBtn').click(function() {
	searchFlag = true;
	searchCategory = $('#searchCategory').val();
	searchWord = $('#searchWord').val();
	if(searchWord == ''){
		alert("검색어를 입력해주세요.");
		return;
	}
	listCall(page, searchCategory, searchWord);
});

$('#allBoardTitle').click(function(){
	searchFlag = false;
	topFixed=false;
	location.href='/allBoard/list.go';
});

$(document).on('mouseenter', '.boardTableTr', function() {
    $(this).css('background-color', 'gray');
});

$(document).on('mouseleave', '.boardTableTr', function() {
    $(this).css('background-color', '');
});

//엔터 키로 검색 버튼 클릭 이벤트 트리거
$('#searchWord').keypress(function(event) {
	if (event.which == 13) { // 13은 Enter 키의 키코드입니다.
		$('#searchBtn').click();
	}
});
</script>
</html>
