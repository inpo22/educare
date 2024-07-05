<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>${dto.subject} - 메일 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- css -->
<link href="/resources/mail/style.css" rel="stylesheet">

<!-- js -->

<style>
	.first-col {
		width: 15%;
	}
	.second-col {
		width: 74%;
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
						<td><a href="/writtenMail/list.go">보낸 메일함</a></td>
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
						<td>
							<span class="badge bg-primary">${dto.send_user_name}
								<c:if test="${dto.class_name ne null}">
									&nbsp;${dto.class_name}
								</c:if>
							</span>
						</td>
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
								<a href="/mail/download?file_no=${file.file_no}&new_filename=${file.new_filename}">
									<i class="bi bi-download"></i>&nbsp;${file.ori_filename}
								</a>
								<br/>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="viewer">${dto.content}</div>
						</td>
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
		writeType = 1;
		location.href = '/mail/write.go?mail_no=' + mail_no + '&writeType=' + writeType;
	}

	function relay() {
		writeType = 2;
		location.href = '/mail/write.go?mail_no=' + mail_no + '&writeType=' + writeType;
	}
	
	function mailList() {
		location.href = '/receivedMail/list.go';
	}
	
	$('.btn-newMail').click(function() {
		location.href = '/mail/write.go';
	});
</script>
</html>