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
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<link rel="stylesheet" href="/resources/board/board.css">
<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<style>
th.th{
	background-color: lightgray;
	text-align: center;
}

td {
	text-align: left;
}

.buttonCon{
	display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 20px;
}

#backBtn {
	background-color: lightgray;
	border-color: lightgray;
}

#deleteBtn {
	background-color: gray;
	border-color: gray;
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
			<br/>
			<table class="table">
				<colgroup>
					<col width="10%" />
					<col width="50%" />
				</colgroup>
				<tr>
					<th class="th" scope="col">제목</th>
					<td scope="col">${dto.title}</td>
				</tr>
				<tr>
					<th class="th" scope="col">작성자</th>
					<td scope="col">${dto.user_name}</td>
				</tr>
				<tr>
					<th class="th" scope="col">강의명</th>
					<td scope="col">${dto.course_name}</td>
				</tr>
				<tr>
					<th class="th" scope="col">작성날짜</th>
					<td scope="col" id="reg_date">${dto.reg_date}</td>
				</tr>
				<c:if test="${not empty dto.edit_date}">
				<tr>
					<th class="th" scope="col">수정날짜</th>
					<td scope="col" id="edit_date">${dto.edit_date}</td>
				</tr>
				</c:if>
				<tr>
					<th class="th" scope="col">조회수</th>
					<td scope="col">${dto.bHit}</td>
				</tr>
				<tr>
					<th class="th" scope="col">첨부파일</th>
					<td scope="col">
						<c:forEach items="${attachFileList}" var="file">
							<a href="/board/download/${file.new_filename}">
								<i class="bi bi-download"></i>&nbsp;${file.ori_filename}
							</a>
							<br/>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div id="viewer"></div>
					</td>
				</tr>
			</table>
			<br/><br/>
			<div class="buttonCon">
				<input type="button" id="backBtn" value="뒤로" class="btn btn-primary" onclick="BoardList()"/>
				<c:if test="${isPerm}">
					<input type="button" id="updateBtn" value="수정" class="btn btn-primary" onclick="BoardUpdate()"/>
					<input type="button" id="deleteBtn" value="삭제" class="btn btn-primary" onclick="boardDel()"/>
				</c:if>
			</div>
		</div>
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
var content = '${dto.contents}';

const viewer = toastui.Editor.factory({
	el: document.querySelector('#viewer'),
	viewer: true,
	initialValue: content// 여기에 내용 담아야함
});

function formatDate(dateStr) {
    const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
    const date = new Date(dateStr);
    return date.toLocaleDateString('ko-KR', options); // "ko-KR"로 수정
}

// 등록일 포맷팅
const regDateElement = document.getElementById('reg_date');
if (regDateElement) { // 요소가 존재하는지 확인
    const regDateText = regDateElement.innerText;
    const formattedDate = formatDate(regDateText);
    regDateElement.innerText = formattedDate;
} else {
    console.log('regDateElement not found');
}

// 수정일 포맷팅
const editDateElement = document.getElementById('edit_date');
if (editDateElement) { // 요소가 존재하는지 확인
    const editDateText = editDateElement.innerText;
    const formattedDate2 = formatDate(editDateText);
	editDateElement.innerText = formattedDate2;
} else {
    console.log('editDateElement not found');
}

// 뒤로가기
function BoardList(){
	location.href = '/dataBoard/list.go';
}

// 수정
function BoardUpdate(){
	location.href = '/dataBoard/update.go?post_no='+${dto.post_no};
}
// 삭제
function boardDel(){
	var post_no =${dto.post_no };
	if(confirm("공지를 삭제하시겠습니까?")){
		$.ajax({
			type:'post'
			,url:'/board/del.ajax'
			,data:{
				'post_no':post_no
			},dataType:'JSON'
			,success:function(data){
				console.log(data);
				if(data.row > 0){
					alert("삭제 되었습니다.");
					location.href = '/dataBoard/list.go';
				}
			},error:function(error){
				console.log(error);	
			}		
		});
	}
}

// 타이틀 클릭시 리스트페이지로
$('#BoardTitle').click(function(){
	location.href='/dataBoard/list.go';
});

</script>
</html>






