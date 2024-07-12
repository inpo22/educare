<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="/resources/noti/css/style.css" rel="stylesheet">

<div id="notification">
	<li class="nav-item dropdown">
		<!-- noti header -->
		<a id="notiBtn" class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
			<i class="bi bi-bell position-relative">
				<span class="badge rounded-pill bg-primary translate-middle top-0 start-100 notiCnt_badge"></span>
			</i>
		</a>
		<!-- End noti header -->
		<!-- noti list -->
		<ul id="noti_list" class="dropdown-menu notis">
			<li class="dropdown-header">
				<span class="notiCnt_msg"></span>
<!-- 				<span class="badge rounded-pill bg-primary p-2 ms-2 viewAll">전체 읽음</span> -->
				<button class="btn btn-primary rounded-pill btn-sm p-2 ms-2 readAll_btn">전체 읽음</button>
			</li>
			<!-- appended -->
		</ul><!-- End noti list -->
	</li>
</div>

<div id="sample">
	<li id="noti_list_sample" class="noti_item">
		<i></i>
		<a href="#" class="list-group-item-action" aria-current="">
			<div class="d-flex bd-highlight">
				<h6 class="noti_list_title flex-grow-1 bd-highlight"></h6>
			</div>
			<p class="noti_list_name"></small>
			<p class="noti_list_datetime"></p>
		</a>
	</li>
</div>
<script>
	$(document).ready(function() {
		getNotis_ajax();
	});
	
	var notiAllCnt = 0;

	//event
	$('.noti_item').on('click', function(){
		var noti_no = $(this).attr('id')
		//console.log('click a noti:',noti_no);
		readNotis_ajax({'noti_no'	: noti_no});
		getNotis_ajax();
	});
	
	$('.readAll_btn').on('click', function(){
		if(notiAllCnt > 0){
			$('.newNoti').each(function(i, item){
				var noti_no = $(item).attr('id')
				//console.log('click a noti:',noti_no);
				readNotis_ajax({'noti_no'	: noti_no});
				notiAllCnt--;
				//console.log('읽고 남은 알림 수:',notiAllCnt);
			});	
			if(notiAllCnt == 0){
				getNotis_ajax();
			}
		} else{
			alert('읽을 알림이 없습니다.');
		}
	});
	
	//Endevent
	
	//ajax
	function getNotis_ajax(){
		//console.log('::init noti list::');
		
		$.ajax({
			type	: 'get',
			url		: '/noti/list.ajax',
			dataType: 'json',
			success	: function(result){
 				//console.log('notiCnt:',result.notiCnt);
 				//console.log('notiList:',result.notiList);
 				notiAllCnt = result.notiCnt;
 				makeList(result.notiList);
	 		},
			error	: function(error){
				console.log(error);
			}
		});
	 }

	function readNotis_ajax(param){
		var fun_result = false;
		//console.log(':: read noti ::')
		
		$.ajax({
			type	: 'post',
			url		: '/noti/read.ajax',
			data	: param,
			dataType: 'json',
			success	: function(result){
				//console.log('result:'+result.msg);
				if(result.msg == 'success'){
					fun_result = true;
				}
	 		},
			error	: function(error){
				console.log(error);
			}
		});
		return fun_result;
	 }
	//EndAjax
	
	//method
	function makeList(list){
		//console.log(':: make noti list ::');		
		var nowDate = new Date();
 		var newList = $('#noti_list');
		var title = '';
		var icon_class = '';
		var link_addr = '';
		var noti_time = '';

		resetList();
		// 알림이 없을 경우
		if(notiAllCnt < 1){
			newList.append('<li><hr class=\"dropdown-divider\"></li>');
			newList.append('<li class=\"noti_item newNoti\"><i class=\"noti_list_icon bi bi-bell me-4 ms-5 text-secondary\"></i>받은 알림이 없습니다.</li>');
		
		// 알림이 있을 경우
		} else {
			list.forEach(function(data, i){
				var notiDate = new Date(data.noti_date);
				var ogList = $('#noti_list_sample').clone(true);
				//console.log(i,':',data.noti_no,'-',data);
				// 알림 내용 표시
				// 0:결재 1:공지 2: 메일 3: 일정
				switch(data.noti_type){
				case 0:
					//console.log('type:0-결재');
					title = '[결재요청] '+data.noti_content_title;
					icon_class = "noti_list_icon bi bi-clipboard me-3 text-secondary ";
					link_addr = "/approval/detail.go?au_code="+data.noti_content_no;
					break;
				case 1:
					//console.log('type:1-전사 공지');
					title = '[전사공지] '+data.noti_content_title;
					icon_class = "noti_list_icon bi bi-bell-fill me-3 text-warning";
					link_addr = "/allBoard/detail.go?post_no="+data.noti_content_no;
					break;
				case 2:
					//console.log('type:2-메일');
					title = '[메일수신] '+data.noti_content_title;
					icon_class = "noti_list_icon bi bi-envelope-fill me-3 text-success";
					link_addr = '/mail/detail.go?mail_no='+data.noti_content_no;
					break;
				case 3:
					//console.log('type:3-전사 일정');
					title = '[전사일정] '+data.noti_content_title;
					icon_class = "noti_list_icon bi bi-calendar me-3 text-danger";
					link_addr = "/schedule.go";
					break;
				case 4:
					//console.log('type:4-부서 공지');
					title = '[부서공지] '+data.noti_content_title;
					icon_class = "noti_list_icon bi bi-bell-fill me-3 text-warning";
					link_addr = "/allBoard/detail.go?post_no="+data.noti_content_no;
					break;
				case 5:
					//console.log('type:5-부서 일정');
					title = '[부서일정] '+data.noti_content_title;
					icon_class = "noti_list_icon bi bi-calendar me-3 text-danger";
					link_addr = "/schedule.go";
					break;
				}
				// 알림 시간 표시
				var diff = nowDate.getTime() - notiDate.getTime();
				var diffDay = Math.floor(diff / (1000*60*60*24));
				var diffHour = Math.floor((diff / (1000*60*60)) % 24);
				var diffMin = Math.floor((diff / (1000*60)) % 60);
				var diffSec = Math.floor(diff / 1000 % 60);
				//console.log('datetime: ',data.noti_date);
				//console.log(diffDay+':'+diffHour+':'+diffMin)
				if(diffDay > 0){
					noti_time = (notiDate.getMonth()+1)+'월 '+notiDate.getDate()+'일 '+notiDate.getHours()+':'+notiDate.getMinutes();
					//console.log('day:',diffDay);
				}else if(diffHour > 0){
					noti_time = diffHour+' 시간 전';	
					//console.log('hour:',noti_time);
				} else if(diffMin > 0){
					noti_time = diffMin+' 분 전';
					//console.log('min:',noti_time);
				} else if(diffMin < 1){
					noti_time = '방금 전';
				}
				// 알림 작성자 표시
				if(data.from_user_code == 'system'){
					data.from_user_class = '';
				}
				// 리스트 값 대입 및 속성 추가
				ogList.attr('id',data.noti_no);
				ogList.addClass('newNoti');
				ogList.find('.noti_list_title').text(title);
				ogList.find('.noti_list_name').text(data.from_user_name+' '+data.from_user_class);
				ogList.find('.noti_list_datetime').text(noti_time);
				ogList.find('a').attr('href',link_addr);
				ogList.find('i').addClass(icon_class);
				// 리스트 출력
				newList.append('<li><hr class=\"dropdown-divider\"></li>');
				newList.append(ogList);

			});
		}
		if(notiAllCnt > 3){	// 알림이 4개 이상일 경우, scroll 생성
			newList.attr('style',"height: 460px;");
		}
		//newList.attr('style', "display:'';");
	}
	
	function resetList(){
		//console.log('reset the list');
		// 리스트 초기화
		$('.newNoti').each(function(i, item){
			$(item).remove();
		});
		$('.dropdown-divider').each(function(i, item){
			$(item).remove();
		});
		$('.notiCnt_badge').text(notiAllCnt);
		$('.notiCnt_msg').text(notiAllCnt+' 개의 새로운 알림이 있습니다.');
		$('#noti_list').attr('style',"height: '';");
	}
	//EndMethod

</script>