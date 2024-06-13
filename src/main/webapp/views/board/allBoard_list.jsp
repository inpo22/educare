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
#backBoard{
	background-color: white;
	width: 100%;
    height: 100%; /* 높이를 원하는 크기로 설정 */
	border-radius: 20px;
}
.table {
	text-align: center;
}
.searchContainer{
	float: right;
    margin-right: 20px;
}
#searchBtn{
	background-color: rgba(52, 152, 219, 0.76);
	color: white;
	font-weight: bold;
	border-radius: 10px;
	border:none;
	width:80px;
	height:30px;
}
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
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>

	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div id="backBoard">
			<br/>
			<div class="pagetitle">
				<h1>전사 공지사항</h1>
			</div>
			<div class="searchContainer">
				<select id="searchCategory" >
					<option value="title">제목</option>
					<option value="writer">작성자</option>
					<option value="content">내용</option>
				</select>
				<input type="text" id="searchWord" placeholder="검색단어입력" maxlength="30"/>
				<!-- 이거 누르면 아작스 하는걸로 -->
				<input type="button" id="searchBtn" value="검색" />
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
			  <button class="write">글쓰기</button>

			  <div class="card-body">
				<!-- Pagination with icons -->
				<nav aria-label="Page navigation example">
				  <ul class="pagination">
					<li class="page-item">
					  <a class="page-link" href="#" aria-label="Previous">
						<span aria-hidden="true">«</span>
					  </a>
					</li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#">4</a></li>
					<li class="page-item"><a class="page-link" href="#">5</a></li>
					<li class="page-item">
					  <a class="page-link" href="#" aria-label="Next">
						<span aria-hidden="true">»</span>
					  </a>
					</li>
				  </ul>
				</nav><!-- End Pagination with icons -->
			  </div>
		</div>
		<!-- End Page Title -->

	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
$('#pagination').twbsPagination({
	startPage:1
	,totalPages:data.totalPage
	,visiblePages:5	
	,onPageClick:function(evt,pg){
		currentPage = pg;
		callList(currentPage);
	}
	
});
</script>
</html>