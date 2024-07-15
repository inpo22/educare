<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>부서 공지사항 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- css -->
<link rel="stylesheet" href="/resources/board/board.css">
<!-- js -->
<script src="/resources/js/pagination_module.js" type="text/javascript"></script>

<style>
.table {
	text-align: center;
}

.card-body{
	display: flex;
    justify-content: center; /* 자식 요소들을 가로축 기준으로 가운데 정렬 */
    width: 100%;
}

.selectBox {
	display: flex;
	justify-content: space-between;
	align-items: center; /* 수직 가운데 정렬 */
	margin-right: 20px;
	margin-left: 20px;
}

.searchContainer {
	display: flex;
	align-items: center;
}

#searchCategory, #hiddenTeamCategory, #searchWord{
	height: 38px;
	margin-right: 5px;
	border-radius: 5px;
}

.teamSelectContainer {
	display: flex;
	align-items: center;
	
}

#write{
	float:right;
	margin-right: 20px;
}

.boardTableTr:hover{
	cursor: pointer;
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
				<h1 id="BoardTitle" style="color:black;">부서 공지사항</h1>
			</div>
			<div class="selectBox">
				<div class="teamSelectContainer" >
					<c:if test="${isPerm}">
						<select id="hiddenTeamCategory">
							<option value="">전체</option>
							<c:forEach items="${teamList}" var="team">
								<option value="${team.team_code}">${team.team_name}</option>
							</c:forEach>
						</select>
					</c:if>
				</div>
				<div class="searchContainer" >
					<select id="searchCategory">
						<option value="title">제목</option>
						<option value="writer">작성자</option>
						<option value="contents">내용</option>
					</select>
					<input type="text" id="searchWord" placeholder="검색단어입력" maxlength="30"/>
					<input type="button" id="searchBtn" value="검색" class="btn btn-secondary"/>
				</div>
			</div>
			<br/><br/>
			<table class="table">
				<colgroup>
					<col width="5%" />
					<col width="10%" />
					<col width="25%" />
					<col width="10%" />
					<col width="5%" />
					<col width="15%" />
					<col width="5%" />
				</colgroup>
				<thead>
				  <tr>
					<th scope="col">No.</th>
					<th scope="col">게시판 부서</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">부서</th>
					<th scope="col">작성일자</th>
					<th scope="col">조회수</th>
				  </tr>
				</thead>
				<tbody id="list">
				  
				</tbody>
			</table>
			<button class="btn btn-primary" id="write">글쓰기</button>
			<ul class="pagination d-flex justify-content-center" id="pagination"></ul>
			  
		</div>
		<!-- End Page Title -->

	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
var page = 1;
var totalPage = 0;
var searchCategory = '';
var searchWord = '';
var topFixed = false;
var searchFlag = false;
var teamCode = '';
listCall(page, searchCategory, searchWord, teamCode);

$('#write').on('click',function(){
	location.href='/teamBoard/write.go?category='+$('#hiddenTeamCategory').val();
});

$('#hiddenTeamCategory').val('${category}');

function formatDate(dateStr) {
	const options = {year: 'numeric', month: '2-digit', day: '2-digit' };
	const date = new Date(dateStr);
	return date.toLocaleDateString('kr-KO', options);
}

function listCall(page, searchCategory, searchWord, teamCode){
// 	console.log("page:", page, "searchCategory:", searchCategory, "searchWord:", searchWord, "teamCode:", teamCode);

	$.ajax({
		type: 'post',
		url: '/teamBoard/list.ajax',
		data: {
			'page': page,
			'searchCategory':searchCategory,
			'searchWord':searchWord,
			'selectedTeamCode': teamCode
		},
		dataType: 'JSON',
		success: function(data){
			console.log(data);

			totalPage = data.totalPage;
			
			 var searchFlag = !!searchWord;
			 
			 drawList(data, page, searchFlag);

			var option = {
				totalPages: totalPage,
				startPage: page
			};
			window.pagination.init($('#pagination'), option, function(currentPage) {
				page = currentPage;
				listCall(page, searchCategory, searchWord, teamCode);
			});
		},
		error: function(request, status, error){
			console.log("code: " + request.status)
			console.log("message: " + request.responseText)
			console.log("error: " + error);
		}
	});
}

function drawList(data, page, searchFlag){
	var context = '';
	var topFixedContext = '';
    
	if(page == 1){
		for (var item of data.topFixedTeamList){
			topFixedContext += '<tr class="boardTableTr" onclick="locationMove('+item.post_no+')">'
			topFixedContext += '<td scope="col"><b>'+ item.post_no +'</b></td>'
			topFixedContext += '<td scope="col"><b>' + item.post_team_name + '</b></td>'
			topFixedContext += '<td scope="col"><b>' + item.title + '</b></td>'
			topFixedContext += '<td scope="col"><b>' + item.user_name + ' ' + item.class_name + '</b></td>'
			topFixedContext += '<td scope="col"><b>' + item.team_name + '</b></td>'
			topFixedContext += '<td scope="col"><b>' + formatDate(item.reg_date) + '</b></td>'
			topFixedContext += '<td scope="col"><b>' + item.bHit + '</b></td>'
			topFixedContext += '</tr>';
		}
	}
	for (var item of data.list) {
		context += '<tr class="boardTableTr" onclick="locationMove('+item.post_no+')">'
		context += '<td scope="col">'+ item.post_no +'</td>'
		context += '<td scope="col">' + item.post_team_name + '</td>'
		context += '<td scope="col">' + item.title + '</td>'
		context += '<td scope="col">' + item.user_name + ' ' + item.class_name + '</b></td>'
		context += '<td scope="col">' + item.team_name + '</td>'
		context += '<td scope="col">' + formatDate(item.reg_date) + '</td>'
		context += '<td scope="col">' + item.bHit + '</td>'
		context += '</tr>';
	}
	if (page > 1 || searchFlag) {
		$('#list').html(context);
	} else {
		$('#list').html(topFixedContext + context);
	}
}

function locationMove(post_no){
	location.href='/teamBoard/detail.go?post_no='+post_no;
}

$('#searchBtn').click(function() {
	searchCategory = $('#searchCategory').val();
	searchWord = $('#searchWord').val();
	teamCode = $('#hiddenTeamCategory').val();
	listCall(page, searchCategory, searchWord, teamCode);
});

$('#BoardTitle').click(function(){
	searchFlag = false;
	topFixed=false;
	location.href='/teamBoard/list.go';
});

$(document).on('mouseenter', '.boardTableTr', function() {
	$(this).css('background-color', 'gray');
});

$(document).on('mouseleave', '.boardTableTr', function() {
	$(this).css('background-color', '');
});

//엔터 키로 검색 버튼 클릭 이벤트 트리거
$('#searchWord').keypress(function(event) {
	if (event.which == 13) {
		$('#searchBtn').click();
	}
});

$('#hiddenTeamCategory').change(function() {
	var teamCode = $(this).val();
	listCall(page, searchCategory, searchWord, teamCode);
});
</script>
</html>