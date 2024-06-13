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

.first-col {
	width: 100px;
}

.second-col {
	width: 300px;
}

.third-col {
	width: 800px;
}

.fourth-col {
	width: 500px;
}

.btn-search, .select-read, .select-del {
	height: 33px;
}
a {
	color: black;
}
.blue-color {
	color: rgb(88, 88, 255);
}
.text-bold {
	font-weight: bold;
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
				<br/>
				<br/>
				<br/><a href="#" class="blue-color"><b>받은 메일함</b></a><br/>
				<br/><a href="#">보낸 메일함</a>
			</div>
			<div id="right-section">
				<select>
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="send_user_name">보낸 사람</option>
				</select> <input type="text"/>
				<button class="btn btn-secondary btn-search" onclick="search()">검색</button>
				<br/>
				<br/>
				<table class="table">
					<thead>
						<tr>
							<th scope="col" class="first-col"><input type="checkbox" id="select-all"/></th>
							<td scope="col" class="second-col">
								<button class="btn btn-primary select-read" onclick="read()">읽음</button>
								<button class="btn btn btn-danger select-del" onclick="del()">삭제</button>
							</td>
							<th scope="col" class="third-col"></th>
							<th scope="col" class="fourth-col"></th>
						</tr>
					</thead>
					<tbody id="drawList"></tbody>
				</table>
				<ul class="pagination d-flex justify-content-center" id="pagination"></ul>
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

	$('.select-box').click(function() {
		if ($('.select-box:checked').length == $('.select-box').length) {
			$('#select-all').prop('checked', true);
		} else {
			$('#select-all').prop('checked', false);
		}
	});

	var page = 1;

	listCall(page);

	function listCall(page) {
		$.ajax({
			type:'get',
			url:'/receivedMail/list.ajax',
			data:{
				'page':page
			},
			dataType:'json',
			success:function(data) {
				console.log('시작');
				drawList(data.list);
				setupPagination(page, data.topPage)
			},
			error : function(request, status, error) {
				console.log("code: " + request.status)
				console.log("message: " + request.responseText)
				console.log("error: " + error);
			}
		});
	}
	
	function setupPagination(page, topPage) {
		var pagination = $('#pagination');
		var count = 0;
		
		pagination.empty();
		
		var content = '<li class="page-item">';
		content += '<a class="page-link" href="#" aria-label="Previous">';
		content += '<span aria-hidden="true">&laquo;</span>';
		content += '</a>';
		content += '</li>';
		if (page < 3) {
			for (var i = 1; i <= topPage; i++) {
				content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
				count++;
				if (count == 5) {
					break;
				}
			}
		}else if (page >= 3 && topPage >= 5 && page < (topPage - 2)) {
			for (var i = page - 2; i <= topPage; i++) {
				content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
				count++;
				if (count == 5) {
					break;
				}
			}
		}else if (page >= 3 && topPage >= 5 && page >= (topPage - 2)) {
			for (var i = topPage - 4; i <= topPage; i++) {
				content += '<li class="page-item"><a class="page-link" href="#">' + i + '</a></li>';
				count++;
				if (count == 5) {
					break;
				}
			}
		}
		
		content += '<li class="page-item">';
		content += '<a class="page-link" href="#" aria-label="Next">';
		content += '<span aria-hidden="true">&raquo;</span>';
		content += '</a>';
		content += '</li>';
		
		pagination.html(content);
		
		pagination.on('click', 'a', function(e) {
			e.preventDefault();
			page = Number($(this).text());
			listCall(page);
			pagination.find('.page-item').removeClass('active');
			$(this).parent().addClass('active');
		});
	}
	
	function drawList(list) {
		var content = '';
		for (var row of list) {
			if (row.is_read == '0') {
				content += '<tr class="text-bold">';
			}else {
				content += '<tr>';
			}
			
			
			content += '<th scope="row" class="first-col"><input type="checkbox" class="select-box" value="' + row.mail_no + '"/></th>';
			content += '<td>' + row.send_user_name + '</td>';
			content += '<td><a class="list-title" href="#">' + row.subject + '</a></td>';
			
			var date = new Date(row.send_date);
		    var dateStr = date.toLocaleString("ko-KR");
		    content += '<td>' + dateStr + '</td>';
			
			content += '</tr>';
		}
		
		$('#drawList').html(content);
	}
	
	function read() {
		var readArr = [];
		$('.select-box').each(function(idx, item) {
			if ($(item).is(":checked")) {
				var val = $(this).val();
				//console.log(val);
				readArr.push(val);
			}
		});
		// console.log('readArr : ', readArr);

		$.ajax({
			type:'post',
			url:'/receivedMail/read.ajax',
			data:{
				readList:readArr
			},
			dataType:'JSON',
			success:function(data) {
				console.log(data.result);
				$('#drawList').empty();
				listCall(page);
			},
			error:function(error) {
				console.log(error);
			}
		});
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
					url:'/receivedMail/delete.ajax',
					data:{
						delList:delArr
					},
					dataType:'JSON',
					success:function(data) {
						if (data.cnt > 0) {
							alert('선택하신 메일 ' + data.cnt + '건 삭제 완료했습니다.');
						}
						
						$('#drawList').empty();
						listCall(page);
					},
					error:function(error) {
						console.log(error);
					}
				});
			}
		}
		
		
	}
</script>
</html>