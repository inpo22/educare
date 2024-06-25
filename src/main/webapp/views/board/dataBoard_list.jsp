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

<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- css -->
<link rel="stylesheet" href="/resources/board/board.css">
<!-- js -->

<style>
.table {
	text-align: center;
}

.searchContainer{
	float: right;
    margin-right: 20px;
}

#searchCategory, #searchWord{
	height: 38px;
	margin-right: 5px;
	border-radius: 5px;
	border-color: lightgray;
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
				<h1 id="BoardTitle">학생 자료실</h1>
			</div>
			<div class="searchContainer">
				<select id="searchCategory" >
					<option value="title">제목</option>
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
					<col width="15%" />
					<col width="5%" />
				</colgroup>
				<thead>
				  <tr>
					<th scope="col">No.</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일자</th>
					<th scope="col">조회수</th>
				  </tr>
				</thead>
				<tbody id="list">
				  
				</tbody>
			</table>
			<c:if test="${isPerm}">
				<button class="write" onclick="location.href='/stdBoard/write.go'">글쓰기</button>
			</c:if>
			<ul class="pagination d-flex justify-content-center" id="pagination"></ul>
		</div>
		<!-- End Page Title -->

	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
</script>
</html>