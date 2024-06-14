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
	.display-flex {
		display: flex;
	}
	
	#left-section {
		width: 15%;
		height: 100%;
	}
	
	#right-section {
		width: 84%;
		height: 100%;
		background-color: white;
		padding: 30px;
	}
	#second-sidebar td {
		padding: 5px 0;
	}
	.first-col {
		width: 15%;
	}
	.second-col {
		width: 74%;
	}
	.table-bordered th {
		text-align: center;	
	}
	.text-align-right {
		text-align: right;
	}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div class="display-flex">
			<div id="left-section">
				<div class="pagetitle">
					<h1>메일</h1>
				</div>
				<button class="btn btn-primary btn-newMail">메일 작성</button>
				<br/><br/><br/>
				<table id="second-sidebar">
					<tr>
						<td><a href="/receivedMail/list.go">받은 메일함</a></td>
					</tr>
					<tr>
						<td><a href="/writtenMail/list.go" class="blue-color"><b>보낸 메일함</b></a></td>
					</tr>
				</table>
			</div>
			<div id="right-section">
				<button class="btn btn-outline-secondary btn-sm" onclick="reply()">답장</button>
				&nbsp;&nbsp;
				<button class="btn btn-outline-secondary btn-sm" onclick="relay()">전달</button>
				<br/><br/>
				<table class="table table-bordered">
					<tr>
						<th class="table-active first-col">제목</th>
						<td class="second-col">${dto.subject}</td>
					</tr>
					<tr>
						<th class="table-active justify-content-center">보낸 사람</th>
						<td>${dto.send_user_name}</td>
					</tr>
					<tr>
						<th class="table-active">받는 사람</th>
						<td>
							<c:forEach items="${receiverList}" var="receiver">
								<span class="badge bg-primary">${receiver.receiver_name}&nbsp;${receiver.class_name}</span>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th class="table-active">참조</th>
						<td>
							<c:forEach items="${ccList}" var="cc">
								<span class="badge bg-primary">${cc.cc_name}&nbsp;${cc.class_name}</span>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th class="table-active">작성일자</th>
						<td>${dto.send_date}</td>
					</tr>
					<tr>
						<th class="table-active">첨부파일</th>
						<td>
							<c:forEach items="${attachFileList}" var="file">
								<a href="/mail/download/${file.new_filename}">
									<i class="bi bi-download"></i>&nbsp;${file.ori_filename}
								</a>
								<br/>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<td colspan="2">${dto.content}</td>
					</tr>
				</table>
				<br/>
				<div class="text-align-right">
					<button class="btn btn-secondary btn-sm" onclick="mailList()">돌아가기</button>
				</div>
			</div>
		</div>
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
	var mail_no = '${dto.mail_no}'
	var writeType = -1;
	
	function reply() {
		writeType = 0;
		location.href = '/mail/write.go?mail_no=' + mail_no + '&writeType=' + writeType;
	}

	function relay() {
		writeType = 1;
		location.href = '/mail/write.go?mail_no=' + mail_no + '&writeType=' + writeType;
	}
	
	function mailList() {
		location.href = '/receivedMail/list.go';
	}
	


</script>
</html>