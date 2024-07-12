<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>보낸 메일함 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<jsp:include page="/views/common/head.jsp"></jsp:include>
<!-- css -->
<link href="/resources/mail/style.css" rel="stylesheet">

<!-- js -->
<script src="/resources/js/pagination_module.js" type="text/javascript"></script>

<style>
	.first-col {
		width: 5%;
	}
		
	.second-col {
		width: 15%;
	}
		
	.third-col {
		width: 54%;
	}
		
	.fourth-col {
		width: 25%;
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
					<h1><a href="/receivedMail/list.go">메일</a></h1>
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
				<select id="search-condition" class="form-select">
					<option value="subject">제목</option>
					<option value="content">내용</option>
					<option value="receivers_name">받는 사람</option>
				</select> 
				<input type="text" id="search-content" class="form-control"/>
				<button class="btn btn-secondary" onclick="search()">검색</button>
				<br/>
				<br/>
				<table class="table">
					<thead>
						<tr>
							<th scope="col" class="first-col"><input type="checkbox" id="select-all"/></th>
							<td scope="col" class="second-col">
								<button class="btn btn-outline-danger btn-sm" onclick="del()">삭제</button>
							</td>
							<th scope="col" class="third-col"></th>
							<th scope="col" class="fourth-col"></th>
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

</body>
<script>
	$('#select-all').click(function() {
		var $chk = $('.select-box');

		if ($(this).is(":checked")) {
			$chk.prop('checked', true);
		} else {
			$chk.prop('checked', false);
		}
	});

	$(document).on('click', '.select-box', function() {
		if ($('.select-box:checked').length == $('.select-box').length) {
			$('#select-all').prop('checked', true);
		} else {
			$('#select-all').prop('checked', false);
		}
	});

	var page = 1;
	var totalPage = 0;
	var searchCondition = '';
	var searchContent = '';
	listCall(page, searchCondition, searchContent);

	function listCall(page, searchCondition, searchContent) {
		$.ajax({
			type:'get',
			url:'/writtenMail/list.ajax',
			data:{
				'page':page,
				'condition':searchCondition,
				'content':searchContent
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
			content += '<th colspan="4">보낸 메일이 없습니다.</th>';
			content += '</tr>';
			
			$('#pagination').css('display', 'none');
		} else {
			for (var row of list) {
				
				content += '<tr>';
				content += '<th scope="row" class="first-col"><input type="checkbox" class="select-box" value="' + row.mail_no + '"/></th>';
				content += '<td>' + row.receivers_name + '</td>';
				content += '<td><a class="list-title" href="/mail/detail.go?mail_no=' + row.mail_no + '">' + row.subject + '</a></td>';
				
				var date = new Date(row.send_date);
			    var dateStr = date.toLocaleString("ko-KR");
			    content += '<td>' + dateStr + '</td>';
				
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
	
	
	function del() {
		var delArr = [];
		
		$('.select-box').each(function(idx, item) {
			if ($(item).is(":checked")) {
				var val = $(this).val();
				//console.log(val);
				delArr.push(val);
			}
		});
		// console.log('delArr : ', delArr);
		
		if (delArr.length > 0) {
			var result = confirm('선택하신 메일 ' + delArr.length + '건을 삭제하시겠습니까?');
			if (result) {
				$.ajax({
					type:'post',
					url:'/writtenMail/delete.ajax',
					data:{
						delList:delArr
					},
					dataType:'JSON',
					success:function(data) {
						if (data.cnt > 0) {
							alert('선택하신 메일 ' + data.cnt + '건 삭제 완료했습니다.');
						}
						
						$('#drawList').empty();
						listCall(page, searchCondition, searchContent);
					},
					error:function(error) {
						console.log(error);
					}
				});
			}
		}
	}
	
	$('.btn-newMail').click(function() {
		location.href = '/mail/write.go';
	});
</script>
</html>