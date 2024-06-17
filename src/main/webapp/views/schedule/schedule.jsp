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
<link href='https://cdn.jsdelivr.nenpm/bootstrap@4.5.0/dist/css/bootstrap.css' rel='stylesheet'>

<jsp:include page="/views/common/head.jsp"></jsp:include>

<!-- js -->
<!-- 캘린더 -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.14/index.global.min.js"></script>
<!-- 툴팁쓸거면... -->
<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
<script src="https://unpkg.com/tippy.js@6"></script>

<style>

/*
fieldset {
    text-align: center;
    height: 80px;
    border-radius: 10px;
    width: 320px;
    box-shadow: 3px 2px 9px 1px darkgrey;
    background-color:white;
}
*/

.pln_btn{
	width: 230px;
}

.modal-header {
    background-color: black;
    color:#FFF;
    border-bottom:2px dashed white;
 }

.all{
	background-color: #ff6666;
	color:white;
	height:20px;
	padding: 0px;
    font-size: 13px;
}

.common{
	background-color: #ffd146;
	color:white;
	padding: 0px;
    font-size: 13px;
}

.dept{
	background-color: #6fb171;
	color:white;
	padding: 0px;
    font-size: 13px;
}

.private{
	background-color: #55b4ff;
	color:white;
	padding: 0px;
    font-size: 13px;
}

textarea{
	resize:none;
}

</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<!-- Start #main -->
	<main id="main" class="main">

		<div class="pagetitle">
			<h1>일정 관리</h1>
		</div>
		<!-- End Page Title -->
		<button
			class="btn btn-dark mt-2 d-grid gap-2 col-2 border-secondary p-3 pln_btn"
			data-bs-toggle="modal" data-bs-target="#writeModal">+ 일정 추가
		</button>
		<!-- End Schedule Button -->
		<div class="row">
			<div class="mt-1 d-grid gap-2 col-2 rounded-5 p-3">
				<div class="card border-secondary">
					<div class="card-header">선택한 일정 보기</div>
					<div class="card-body text-secondary mt-2">
						<ul class="list-group list-group-flush">
							<li class="list-group-item"><button type="button" class="btn w-100 filter_btn all" id="all" data-type="all">전체</button></li>
							<li class="list-group-item"><button type="button" class="btn w-100 filter_btn common" id="common" data-type="common">전사</button></li>
							<li class="list-group-item"><button type="button" class="btn w-100 filter_btn dept" id="dept" data-type="dept">부서</button></li>
							<li class="list-group-item"><button type="button" class="btn w-100 filter_btn private" id="private" data-type="private">개인</button></li>
						</ul>
					</div>
				</div>
			</div>
			<!-- End Schedule filter -->
			<div class="d-grid gap-2 col-10 mt-3">
				<div class="shadow-sm">
					<div id="calendar"></div>
				</div>
			</div>
			<!-- End Schedule Calendar -->
			<!-- Start #writeModal -->
			<div class="modal fade" id="writeModal" tabindex="-1" aria-labelledby="writeModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header text-light">
							<h1 class="modal-title fs-5" id="writeModalLabel">일정 등록</h1>
							<button type="button" class="btn-close bg-white rounded-5" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form>
								<div class="input-group input-group-sm mb-3">
									<label class="input-group-text">일정유형</label>
									<select class="form-select" id="selectSchRange">
										<option selected>유형선택</option>
										<option value="T01">전사</option>
										<option value="${sessionScope.team_code }">부서</option>
										<option value="3">개인</option>
									</select>
								</div>
								<div class="input-group input-group-sm mb-3">
									<span class="input-group-text" id="basic-addon1">일정제목</span> 
									<input type="text" class="form-control" id="title" placeholder="제목을 입력해주세요.">
								</div>
								<div class="input-group input-group-sm mb-3">
									<span class="input-group-text">일정내용</span>
									<textarea class="form-control h-25" row="10" id="contents" aria-label="With textarea"></textarea>
								</div>
								<div class="input-group input-group-sm mb-3">
									<input type="date" class="form-control" id="start_date" placeholder="시작날짜" aria-label="startDate"> 
									<span class="input-group-text">~</span>
									<input type="date" class="form-control" id="end_date" placeholder="종료날짜" aria-label="endDate">
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" onclick="sch_submit()">등록</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- End #wirteModal -->
		
	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
$(document).ready(function(){
	callSch();
});

var calendar;

document.addEventListener('DOMContentLoaded', function(eventList) {
    var calendarEl = document.getElementById('calendar');

    calendar = new FullCalendar.Calendar(calendarEl, {
    	googleCalendarApiKey: 'AIzaSyCJeD_Gho52ovrTpfj8zqwl-m3r41gvpBo',
    	eventSources: 
    		 {  
    		   googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
    			color:'red'
    		 },
    	locale: 'ko',
        headerToolbar : {
            left : 'prev',
            center : 'title',
            right : 'next'
        },
        selectable : true,
        nowIndicator: true,
        expandRows: true,
        dayMaxEventRows: true, 
        timeZone : 'local',
        initialView : 'dayGridMonth',
        slotLabelFormat: 'HH:mm',
        dayPopoverFormat: 'MM/DD dddd',
        dayMaxEvents : true,
        fixedWeekCount : false,
        dayCellContent: function(arg) {
            arg.dayNumberText = arg.dayNumberText.replace('일', '');
            return arg.dayNumberText;
        },
        select: function(info){
        	console.log('이게 드래그라고?');
        	writeModalOpen();
        },
        eventClick : function(info) {
        	console.log('일정클릭시');
        	detailModalOpen();
        },
        events: eventList
    });

    $(".filter_btn").click(function () {
        var eventType = $(this).data('type');
        var evt = calendar.getEvents();
        states = eventType;
        console.log(states);
        if (states === 'all') {
            evt.forEach(function(event) {
                event.setProp('display', '');
            });
        } else {
            filterEvent();
        }
    });
    
    function filterEvent() {
        var evt = calendar.getEvents();
        evt.forEach(function(event) {
            var stateCont = event.extendedProps.state;
            if (!states.includes(stateCont)) {
                event.setProp('display', 'none'); 
            } else {
                event.setProp('display', ''); 
            }
            
        });
    }
    
    calendar.render();
    
    function writeModalOpen(start,end) {
    	$('#start_date').val(start); 
    	$('#end_date').val(end); 
        $('#writeModal').modal('show');
    }
    
    calendar.setOption('dateClick', function(info) {
        writeModalOpen(info.dateStr,info.dateStr);
        calendar.addEvent({title:$('#title').val(),contents:$('#contents').val(),start_date:$('#start_date').val(),end_date:$('#end_date').val()});
    });
    
    calendar.setOption('select', function(selectionInfo) {
    	var endCal = selectionInfo.end;
    	var endDate = endCal.toISOString().split('T')[0];

    	writeModalOpen(selectionInfo.startStr,endDate);
        
        console.log(selectionInfo.startStr);
        console.log(endDate);
    });
    
    function detailModalOpen() {
       alert('흐아아아');
    }
    
});


function sch_submit() {
	alert('title : ' + $('#title').val());
	
	var paramData = {
		//id: $('sessionScope.id').val(),	//작성자 이름 
		//team_code : $('sessionScope.team_code').val(),	//작성자 소속부서
		//selectSchRange:$('#selectSchRange').val(),	//일정유형
		title:$('#title').val(),	//일정제목
		contents:$('#contents').val(),	//일정내용
		start_date:$('#start_date').val(),	//일정시작일
		end_date:$('#end_date').val()	//일정마감일
	};
	
	
	$.ajax({
		url:'/schedule/write.ajax',
		type:'POST',
		contentType: 'application/json',
		data: JSON.stringify(paramData),
		dataType:'JSON',
		success : function(data){
			console.log(data.row);
			if(data.row > 0){
				alert('등록되었습니다');
				 $('#writeModal').modal('hide');
			}
		},
		error:function(request, status, error){
			console.log(error);
		}
	});
};


function callSch(){
	$.ajax({
			url:'/schedule/list.ajax',
			type:'GET',
			contentType: 'application/json',
			dataType:'JSON',
			success : function(response){
					console.log(response);
					var events = [];
					response.list.forEach(function(item) {
							var event = {
									title: item.title,
									start: item.start_date,
									end: item.end_date,
							};
							events.push(event);
					});
					console.log('Events:', events);
					calendar.addEventSource(events); 
			},
			error:function(request, status, error){
					console.log(error);
			}
	});
};

</script>
</html>