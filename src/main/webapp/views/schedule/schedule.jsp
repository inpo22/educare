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
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.4/main.min.css' rel='stylesheet' />
<jsp:include page="/views/common/head.jsp"></jsp:include>

<!-- js -->
<!-- 캘린더 -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.14/index.global.min.js"></script>
<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
<script src="https://unpkg.com/tippy.js@6"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>

.pln_btn {
	height: 54px;
}

.card-header {
	font-weight: bold;
}

.card-body {
	padding: 10px;
}

.modal-header {
	background-color: black;
	color: #FFF;
	border-bottom: 1px dashed white;
}

.all {
	background-color: #ff6666;
	color: white;
	height: 20px;
	padding: 0px;
	font-size: 13px;
}

.common {
	background-color: #ffd146;
	color: white;
	padding: 0px;
	font-size: 13px;
}

.dept {
	background-color: #6fb171;
	color: white;
	padding: 0px;
	font-size: 13px;
}

.private {
	background-color: #55b4ff;
	color: white;
	padding: 0px;
	font-size: 13px;
}

.all:hover, .common:hover, .dept:hover, .private:hover {
    box-shadow: inset 1px 1px 2px 0px #403e3ed9;
    color: white;
}

textarea {
	resize: none;
}


#calendar {
	background-color: white;
	padding: 15px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

:root { -
	-fc-border-color: #e9ecef;
}

.fc-day-sat .fc-daygrid-day-number {
	color: blue;
}

.fc-day-sun .fc-daygrid-day-number {
	color: red;
}

.fc-day-mon .fc-daygrid-day-number, .fc-day-tue .fc-daygrid-day-number,
.fc-day-wed .fc-daygrid-day-number, .fc-day-thu .fc-daygrid-day-number,
.fc-day-fri .fc-daygrid-day-number {
	color: black;
}

.fc-day-sun .fc-col-header-cell-cushion {
	color: red;
}

.fc-day-sat .fc-col-header-cell-cushion {
	color: blue;
}

.fc-day-mon .fc-col-header-cell-cushion, .fc-day-tue .fc-col-header-cell-cushion,
.fc-day-wed .fc-col-header-cell-cushion, .fc-day-thu .fc-col-header-cell-cushion,
.fc-day-fri .fc-col-header-cell-cushion {
	color: black;
}

.fc-event-start {
	border: none;
}

.fc-direction-ltr .fc-daygrid-event.fc-event-end, .fc-direction-rtl .fc-daygrid-event.fc-event-start{
	border: none;
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
		
		<div class="row">
			<div class="col-2 rounded-5 p-3">
			<button class="btn btn-dark border-secondary pln_btn w-100" data-bs-toggle="modal" id="write_btn" data-bs-target="#writeModal">+ 일정 추가</button>
			<!-- End Schedule Button -->
				<div class="card border-secondary mt-4">
					<div class="card-header">선택한 일정 보기</div>
					<div class="card-body text-secondary mt-2">
						<ul class="list-group list-group-flush">
							<li class="list-group-item"><button type="button" class="btn w-100 filter_btn all" id="all" data-type="">전체</button></li>
							<li class="list-group-item"><button type="button" class="btn w-100 filter_btn common" id="common" data-type="SKED_TP01">전사</button></li>
							<li class="list-group-item"><button type="button" class="btn w-100 filter_btn dept" id="dept" data-type="SKED_TP02">부서</button></li>
							<li class="list-group-item"><button type="button" class="btn w-100 filter_btn private" id="private" data-type="SKED_TP03">개인</button></li>
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
							<h1 class="modal-title fs-5" id="writeModalLabel"></h1>
							<button type="button" class="btn-close bg-white rounded-5" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form id="modalForm">
								<div class="input-group input-group-sm mb-3">
									<label class="input-group-text">일정유형</label>
									<select class="form-select" id="selectSchRange">
										<option selected>유형선택</option>
										<option value="SKED_TP01">전사</option>
										<option value="SKED_TP02">부서</option>
										<option value="SKED_TP03">개인</option>
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
							<button type="button" class="btn btn-secondary" id="closeButton" data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn text-light bg-dark" id="submitButton" onclick="sch_submit()">등록</button>
							<button type="button" class="btn btn-secondary" id="deleteButton" onclick="sch_del()" style="display:none;">삭제</button>
							<button type="button" class="btn text-light bg-dark" id="updateButton" onclick="sch_uodatet()" style="display:none;">수정</button>
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
        slotLabelFormat: {
            hour: '2-digit',
            minute: '2-digit',
            omitZeroMinute: false,
            meridiem: false
        },
        dayPopoverFormat: {
            month: 'short',
            day: 'numeric',
            weekday: 'long'
        },
        dayMaxEvents : true,
        fixedWeekCount : false,
        displayEventTime: false,
        dayCellContent: function(arg) {
            arg.dayNumberText = arg.dayNumberText.replace('일', '');
            return arg.dayNumberText;
        },
        select: function(info){	//드래그시
        	document.getElementById('modalForm').reset();
        	writeModalOpen();
        },
        eventClick : function(info) {	//일정클릭시
        	document.getElementById('modalForm').reset();
        	detailModalOpen(info);
        	info.jsEvent.cancelBubble = true; 
            info.jsEvent.preventDefault(); 
        },
        eventDidMount: function(info) {
            var popover = new bootstrap.Popover(info.el, {
                title: info.event.title,
                trigger: 'hover',
                placement: 'top',
                container: 'body'
            });
        },
        events: function(info, successCallback, failureCallback) {
        	
        	$.ajax({
        		url:'/schedule/list.ajax',
        		type:'POST',
        		contentType: 'application/json',
        		dataType:'JSON',
        		success : function(response){
        				console.log(response);
        				var events = [];
        				response.list.forEach(function(item) {
        						var tp_color; 
        						var event = {
        							title: item.title,
        							start: item.start_date,
        							end: item.end_date,
        							skedNo: item.sked_no,
        							skedType:item.sked_type,
        							contents:item.contents,
        							name : item.name,
        							team_name : item.team_name,
        							backgroundColor: item.sked_type === 'SKED_TP01' ? '#ffd146':
        											 item.sked_type === 'SKED_TP02' ? '#6fb171':
        											 item.sked_type === 'SKED_TP02' ? '#55b4ff':'#ff6666'
        						};
        					
        						events.push(event);
        				});
        				console.log('Events:', events);
        				successCallback(events);
        				//return events;
        				//calendar.addEventSource(events); 
        		},
        		error:function(request, status, error){
        				console.log(error);
        		}
        	});
        	
        	
        }
       
    });
    
    calendar.setOption('dateClick', function(info) {
        writeModalOpen(info.dateStr,info.dateStr);
    });
    
    $('#write_btn').on('click', function () {
    	forWriteModal();
    });
    
    function writeModalOpen(start,end) {
    	forWriteModal();
    	$('#start_date').val(start); 
    	$('#end_date').val(end); 
    }
    
   function forWriteModal(){
	   	document.getElementById('modalForm').reset();
   		$('#writeModalLabel').html('일정 등록');
   		$('#writeModal').modal('show');
        $('#closeButton').show(); 
        $('#deleteButton').hide();
    	$('#submitButton').show(); 
        $('#updateButton').hide();
   }
    
    calendar.setOption('select', function(selectionInfo) {
    	var endCal = selectionInfo.end;
    	var endDate = endCal.toISOString().split('T')[0];

    	writeModalOpen(selectionInfo.startStr,endDate);
        
        console.log(selectionInfo.startStr);
        console.log(endDate);
    });
    
    function detailModalOpen(info) {
    	console.log(info.event);
    	var skedNo = info.event.extendedProps.skedNo;
    	if(skedNo == null){
    		return;
    	}
    	var title = info.event.title;
    	var contents = info.event.extendedProps.contents;
    	var skedType = info.event.extendedProps.skedType;
    	var start = info.event.start.toISOString().split('T')[0];
    	var end = info.event.end;
    	var name = info.event.extendedProps.name;
    	var team_name = info.event.extendedProps.team_name;
    	var info_user = '<div class="input-group input-group-sm mb-3 name_info"><span class="input-group-text" id="basic-addon1">작성자</span> <input type="text" class="form-control" id="name"><span class="input-group-text team_name_info" id="basic-addon1">소속부서</span> <input type="text" class="form-control" id="team_name"></div>';	
    	var parent = document.querySelector("form");
    	
    	console.log(end);
    	parent.insertAdjacentHTML('afterbegin',info_user);
    	$('#name').val(name);
    	$('#name').attr('disabled',true);
    	$('#team_name').val(team_name);
    	$('#team_name').attr('disabled',true);
      	$('#writeModal').modal('show');
      	$('#writeModalLabel').html('일정 상세정보');
      	$('#title').val(title);
      	$('#title').attr('disabled',true);
       	$('#contents').val(contents);
    	$('#contents').attr('disabled',true);
       	$('#selectSchRange').val(skedType);
       	$('#selectSchRange').attr('disabled',true);
       	$('#start_date').val(start);
    	$('#start_date').attr('disabled',true);
       	if(end === null){
       		$('#end_date').val(start);
       	}else{
       		$('#end_date').val(end.toISOString().split('T')[0]);
       	}
       	$('#end_date').attr('disabled',true);
    	$('#closeButton').hide(); 
       	$('#submitButton').hide(); 
    	$('#deleteButton').show(); 
    	$('#deleteButton').attr('data-val',skedNo); 
        $('#updateButton').show();
    }
    
    calendar.render();
});


$('#writeModal').on('hidden.bs.modal', function () {
	$('.name_info').remove();
	$('#title').val('').removeAttr('disabled');
    $('#contents').val('').removeAttr('disabled');
    $('#selectSchRange').val('').removeAttr('disabled');
    $('#start_date').val('').removeAttr('disabled');
    $('#end_date').val('').removeAttr('disabled');
    $('#deleteButton').removeAttr('data-val');
});


function sch_submit() {
	
	var paramData = {
		sked_type: $('#selectSchRange').val(), 
		title:$('#title').val(),	
		contents:$('#contents').val(),	
		start_date:$('#start_date').val(),
		end_date:$('#end_date').val()
	};
	
	$.ajax({
		url:'/schedule/write.ajax',
		type:'POST',
		contentType: 'application/json',
		data: JSON.stringify(paramData),
		dataType:'JSON',
		success : function(data){
			console.log("datadatarow: " +data.row);
			 calendar.addEvent(paramData);
			if(data.row > 0){
				alert('등록되었습니다');
				$('#writeModal').modal('hide');
				calendar.refetchEvents();
			}
			
		},
		error:function(request, status, error){
			console.log(error);
		}
	});
};

function sch_del(){
	var delNo = $('#deleteButton').attr('data-val');
	
	if(confirm("해당 일정을 삭제하시겠습니까?")){
		$.ajax({
			url:'/schedule/delete.ajax',
			type:'POST',
			data: { sked_no: delNo },
			success : function(data){
				if(data.row > 0){
					alert('삭제되었습니다.');
					$('#writeModal').modal('hide');
					calendar.refetchEvents();
				}
			},
			error:function(request, status, error){
				console.log(error);
			}
		});
		
	} 
	
}

$(".filter_btn").click(function () {
    var filter_skedType = $(this).data('type');
    //callSch(skedType);
    filterEvent(filter_skedType);
    var evt = calendar.getEvents();
    filter = filter_skedType;
    console.log(filter);
    if (filter === '') {
        evt.forEach(function(event) {
            event.setProp('display', '');
        });
    } else {
        filterEvent(filter_skedType);
    }
});

function filterEvent(filter_skedType) {
    var evt = calendar.getEvents();
    evt.forEach(function(event) {
        var skedTypeResult = event.extendedProps.skedType;
        if (!filter_skedType.includes(skedTypeResult)) {
            event.setProp('display', 'none'); 
        } else {
            event.setProp('display', ''); 
        }
         
    });
}

</script>
</html>