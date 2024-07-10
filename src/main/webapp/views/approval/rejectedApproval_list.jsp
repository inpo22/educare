<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>반려된 문서 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<jsp:include page="/views/common/head.jsp"></jsp:include>

<!-- css -->
<link href="/resources/approval/style.css" rel="stylesheet">

<!-- js -->
<script src="/resources/js/pagination_module.js" type="text/javascript"></script>

<style>
	.table th, .table td {
		text-align: center;
	}
	.first-col {
		width: 10%;
	}
	.second-col {
		width: 45%;
	}
	.third-col {
		width: 10%;
	}
	.fourth-col {
		width: 14%;
	}
	.fifth-col {
		width: 10%;
	}
	.sixth-col {
		width: 10%;
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
						<td>&nbsp;&nbsp;&nbsp;<a href="/rejectedApproval/list.go" class="blue-color"><b>반려된 문서</b></a></td>
					</tr>
				</table>
			</div>
			<div id="right-section">
				<select id="search-condition" class="form-select">
					<option value="subject">제목</option>
					<option value="content">내용</option>
					<option value="all_approvers">결재자</option>
				</select> 
				<input type="text" id="search-content" class="form-control"/>
				<button class="btn btn-secondary" onclick="search()">검색</button>
				<br/>
				<br/>
				<table class="table">
					<thead>
						<tr>
							<th class="table-active first-col">문서 종류</th>
							<th class="table-active second-col">제목</th>
							<th class="table-active third-col">기안일</th>
							<th class="table-active fourth-col">기안자</th>
							<th class="table-active fifth-col">부서</th>
							<th class="table-active sixth-col">결재 상태</th>
						</tr>
					</thead>
					<tbody id="drawList"></tbody>
				</table>
				<div id="pagination-div">
					<ul class="pagination d-flex justify-content-center" id="pagination"></ul>
				</div>
			</div>
		</div>
	</main>
	<!-- End #main -->
	<jsp:include page="/views/common/footer.jsp"></jsp:include>
	<jsp:include page="/views/approval/newApproval_modal.jsp"></jsp:include>
	
</body>
<script>
	var page = 1;
	var totalPage = 0;
	var searchCondition = '';
	var searchContent = '';
	var listType = 'rejected';
	listCall(page, searchCondition, searchContent);
	
	function listCall(page, searchCondition, searchContent) {
		$.ajax({
			type:'get',
			url:'/approval/list.ajax',
			data:{
				'page':page,
				'condition':searchCondition,
				'content':searchContent,
				'listType':listType
			},
			dataType:'json',
			success:function(data) {
				// console.log('시작');
				totalPage = data.totalPage;
				
				drawList(data.list);
				
				var option = {
					totalPages: totalPage,
					startPage: page
				};
				window.pagination.init($('#pagination'), option, function(currentPage) {
					page = currentPage;
					listCall(page, searchCondition, searchContent);
				});
			},
			error : function(request, status, error) {
				console.log("code: " + request.status)
				console.log("message: " + request.responseText)
				console.log("error: " + error);
			}
		});
	}
	
	function drawList(list) {
		var content = '';
		if (list.length == 0) {
			content += '<tr>';
			content += '<td colspan="6">결재 요청한 문서가 없습니다.</td>';
			content += '</tr>';
			
			$('#pagination-div').css('display', 'none');
		} else {
			$('#pagination-div').css('display', 'block');
			for (var row of list) {
				content += '<tr>';
				if (row.au_type == 0) {
					content += '<td>업무 기안</td>';
				} else if (row.au_type == 1) {
					content += '<td>휴가신청서</td>';
				}
				content += '<td><a href="/approval/detail.go?au_code=' + row.au_code + '">' + row.title + '</a></td>';
				
				var date = new Date(row.reg_date);
			    var dateStr = date.toLocaleDateString("ko-KR");
			    content += '<td>' + dateStr + '</td>';
			    
				content += '<td>' + row.approvers_name + '</td>';
				content += '<td>' + row.approvers_team + '</td>';
				content += '<td><span class="badge bg-danger bg-result">반려</span></td>';
				content += '</tr>';
			}
		}
		$('#drawList').html(content);
	}
	
	function search() {
		page = 1;
		searchCondition = $('#search-condition').val();
		searchContent = $('#search-content').val();
		
		listCall(page, searchCondition, searchContent);
	}
</script>
</html>