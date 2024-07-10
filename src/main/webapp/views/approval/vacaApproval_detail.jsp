<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>${dto.title} - 휴가신청서 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- css -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css"/>
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css"/>
<link href="/resources/approval/style.css" rel="stylesheet">
<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>

<style>
	.first-col {
		width: 13%;
	}
	.second-col {
		width: 37%;
	}
	.third-col {
		width: 13%
	}
	.fourth-col {
		width: 36%
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
					<h1>전자 결재</h1>
				</div>
				<button class="btn btn-primary btn-newApproval">새 결재 작성</button>
				<br/><br/><br/>
				<table class="second-sidebar">
					<tr>
						<td><b>결재하기</b></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/getApproval/list.go">결재 요청 받은 문서</a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/compApproval/list.go">결재 완료한 문서</a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/viewApproval/list.go">열람 가능한 문서</a></td>
					</tr>
				</table>
				<br/>
				<table class="second-sidebar">
					<tr>
						<td><b>상신한 결재</b></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/requestApproval/list.go">결재 요청한 문서</a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/finishApproval/list.go">결재 완료된 문서</a></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;<a href="/rejectedApproval/list.go">반려된 문서</a></td>
					</tr>
				</table>
			</div>
			<div id="right-section">
				<div class="pagetitle text-align-center">
					<h1>휴가 신청서</h1>
				</div>
				<br/><br/>
				<div class="display-grid">
					<table class="table table-bordered display-inline">
						<tr>
							<th class="table-active top-table-first-col">기안자</th>
							<td class="text-align-center top-table-second-col">${dto.user_name}&nbsp;${dto.class_name}</td>
						</tr>
						<tr>
							<th class="table-active">부서</th>
							<td class="text-align-center">${dto.team_name}</td>
						</tr>
						<tr>
							<th class="table-active">기안일</th>
							<td class="text-align-center"><fmt:formatDate value="${dto.reg_date}" pattern="yyyy.MM.dd."/></td>
						</tr>
						<tr>
							<th class="table-active">문서 번호</th>
							<td class="text-align-center">${dto.au_code}</td>
						</tr>
					</table>
					<table class="table table-bordered display-inline text-align-right">
						<tr>
							<th class="table-active order-first-col vertical-align-middle" rowspan="3">신<br/><br/>청</th>
							<td class="text-align-center order-second-col">${dto.class_name}</td>
						</tr>
						<tr>
							<td class="text-align-center vertical-align-bottom">
								<c:if test="${dto.sign_photo eq null}">
									<img src="/resources/img/approve_mark.png" class="approve-img"/>
								</c:if>
								<c:if test="${dto.sign_photo ne null}">
									<img src="/photo/${dto.sign_photo}" class="approve-img"/>
								</c:if>
								<br/>
								${dto.user_name}
							</td>
						</tr>
						<tr>
							<td class="text-align-center order-third-row"><fmt:formatDate value="${dto.reg_date}" pattern="yyyy.MM.dd."/></td>
						</tr>
					</table>
					<div id="order-list-div">
						<table class="table table-bordered display-inline text-align-right order-table">
							<tr>
								<th class="table-active order-first-col vertical-align-middle" rowspan="3">결<br/><br/>재</th>
								<c:forEach items="${orderList}" var="order">
									<td class="text-align-center order-second-col">${order.class_name}</td>
								</c:forEach>
							</tr>
							<tr>
								<c:forEach items="${orderList}" var="order">
									<td class="text-align-center vertical-align-bottom">
										<c:if test="${order.state eq 1}">
											<c:if test="${order.sign_photo eq null}">
												<img src="/resources/img/approve_mark.png" class="approve-img"/>
											</c:if>
											<c:if test="${order.sign_photo ne null}">
												<img src="/photo/${order.sign_photo}" class="approve-img"/>
											</c:if>
											<br/>
										</c:if>
										<c:if test="${order.state eq 2}">
											<img src="/resources/img/reject_mark.png" class="reject-img"/>
											<br/>
										</c:if>
										${order.user_name}
									</td>
								</c:forEach>
							</tr>
							<tr>
								<c:forEach items="${orderList}" var="order">
									<td class="text-align-center order-third-row">
										<c:if test="${order.is_my_turn eq 0}">
											<fmt:formatDate value="${order.apv_date}" pattern="yyyy.MM.dd."/>
										</c:if>
										<c:if test="${order.is_my_turn eq 1}">
											<button class="btn btn-primary btn-sm" onclick="approve()">결재</button>
											<button class="btn btn-danger btn-sm" onclick="reject()">반려</button>
										</c:if>
									</td>
								</c:forEach>
							</tr>
						</table>
					</div>
				</div>
				<table class="table table-bordered">
					<tr>
						<th class="table-active first-col">휴가 종류</th>
						<td colspan="3">
							<c:if test="${dto.va_type eq 0}">
								연차
							</c:if>
							<c:if test="${dto.va_type eq 1}">
								오전 반차
							</c:if>
							<c:if test="${dto.va_type eq 2}">
								오후 반차
							</c:if>
							<c:if test="${dto.va_type eq 3}">
								경조사
							</c:if>
							<c:if test="${dto.va_type eq 4}">
								공가
							</c:if>
							<c:if test="${dto.va_type eq 5}">
								병가
							</c:if>
							<c:if test="${dto.va_type eq 6}">
								대체휴가
							</c:if>
						</td>
					</tr>
					<tr>
						<th class="table-active">휴가 기간</th>
						<td class="second-col">
							<fmt:formatDate value="${dto.start_date}" pattern="yyyy.MM.dd"/>
							<c:if test="${dto.va_type ne 1 and dto.va_type ne 2}">
								&nbsp;&nbsp;~&nbsp;&nbsp;
								<fmt:formatDate value="${dto.end_date}" pattern="yyyy.MM.dd"/>
							</c:if>
							&nbsp;&nbsp;&nbsp;&nbsp;
							(${dto.va_days}&nbsp;일)
						</td>
						<th class="table-active third-col">남은 연차</th>
						<td class="fourth-col">${remainVaca}&nbsp;일</td>
					</tr>
					<tr>
						<th class="table-active">제목</th>
						<td colspan="3">${dto.title}</td>
					</tr>
					<tr>
						<th class="table-active vertical-align-middle">내용</th>
						<td colspan="3">
							<div id="viewer"></div>
						</td>
					</tr>
					<tr>
						<th class="table-active vertical-align-middle">첨부파일</th>
						<td colspan="3">
							<c:forEach items="${attachFileList}" var="file">
								<a href="/approval/download?file_no=${file.file_no}&new_filename=${file.new_filename}">
									<i class="bi bi-download"></i>&nbsp;${file.ori_filename}
								</a>
								<br/>
							</c:forEach>
						</td>
					</tr>
				</table>
				<br/>
				<div class="text-align-right">
					<button class="btn btn-secondary btn-sm" onclick="approvalList()">돌아가기</button>
				</div>
			</div>
		</div>
	</main>
	<!-- End #main -->
	
	<jsp:include page="/views/common/footer.jsp"></jsp:include>
	<jsp:include page="/views/approval/newApproval_modal.jsp"></jsp:include>
	
</body>
<script>
	var content = '${dto.contents}';
	
	const viewer = toastui.Editor.factory({
		el: document.querySelector('#viewer'),
		viewer: true,
		initialValue: content
	});
	
	function approvalList() {
		location.href = '/getApproval/list.go';
	}
	
	var au_code = '${dto.au_code}';
	
	function approve() {
		var result = confirm('결재 하시겠습니까?');
		if (result) {
			location.href = '/approval/approve.do?au_code=' + au_code;
		}
	}
	
	function reject() {
		var result = confirm('반려 하시겠습니까?');
		if (result) {
			location.href = '/approval/reject.do?au_code=' + au_code;
		}
	}
</script>
</html>