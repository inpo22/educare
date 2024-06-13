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
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/googlecalendar@6.1.8/index.global.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
									<label class="input-group-text" for="inputGroupSelect">일정유형</label>
									<select class="form-select" id="inputGroupSelect">
										<option selected>유형선택</option>
										<option value="1">전사</option>
										<option value="2">부서</option>
										<option value="3">개인</option>
									</select>
								</div>
								<div class="input-group input-group-sm mb-3">
									<span class="input-group-text" id="basic-addon1">일정제목</span> 
									<input type="text" class="form-control" placeholder="제목을 입력해주세요.">
								</div>
								<div class="input-group input-group-sm mb-3">
									<span class="input-group-text">일정내용</span>
									<textarea class="form-control h-25" row="10" aria-label="With textarea"></textarea>
								</div>
								<div class="input-group input-group-sm mb-3">
									<input type="date" class="form-control" placeholder="시작날짜" aria-label="startDate"> 
									<span class="input-group-text">~</span>
									<input type="date" class="form-control" placeholder="종료날짜" aria-label="endDate">
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary">등록</button>
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
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
    	locale: 'ko',
        headerToolbar : {
            left : 'prev',
            center : 'title',
            right : 'next'
        },
        selectable : true,
        editable : true,
        expandRows: true,
        dayMaxEventRows: true, 
        nextDayThreshold: "09:00:00",
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
        select : function() {
        	writeModalOpen();
        },
        eventClick : function() {
        	detailModalOpen();
        },
        eventDrop : function() {
        	writeModalOpen();
        },
        events: function(info, successCallback, failureCallback) {
            $.ajax({
                url: 'https://www.googleapis.com/calendar/v3/calendars/YOUR_GOOGLE_CALENDAR_ID/events',
                dataType: 'json',
                data: {
                    key: 'AIzaSyCJeD_Gho52ovrTpfj8zqwl-m3r41gvpBo' // Google Calendar API 키
                },
                success: function(response) {
                    var events = response.items.map(function(item) {
                        return {
                            title: item.summary,
                            start: item.start.dateTime || item.start.date,
                            end: item.end.dateTime || item.end.date
                        };
                    });
                    successCallback(events);
                },
                error: function(xhr, status, error) {
                    console.error('Google Calendar API 호출 중 에러:', status, error);
                    failureCallback(error);
                }
            });
        },
        events :[ 
            {
                title : '10시까지 남은 일정마무리하기',
                start : '2024-06-10',
                end : '2024-06-10',
                state: 'private',
                description: '남은 일정 : 엑셀 / 피피티 작성',
                color: '#ABDEE6'
            },
            {
                title : '야근하는날',
                start : '2024-06-27',
                end : '2024-06-28T24:00',
                description: '야근하기 싫어..',
                state: 'private',
                color: '#ABDEE6'
            },
            {
                title : '회의 및 발표회',
                start : '2024-06-24',
                end : '2024-06-25T12:00:00',
                description: '발표자료 준비해오기',
                state: 'common',
                color: '#F3B0C3'
            },
            {
                title : '세미나',
                start : '2024-06-03',
                end : '2024-06-03',
                description: '3~4시 세미나 예정',
                state: 'common',
                color: '#F3B0C3'
            },
            {
                title :'구디아카데미 오리엔테이션',
                start : '2024-06-17',
                end : '2024-06-21T12:00:00',
                description: '간단한 오리엔테이션',
                state: 'private',
                color: '#FFC8A2'
            },
            {
                title :'수업 1주차',
                start : '2024-06-24',
                end : '2024-06-28T12:00:00',
                description: '자료준비해가기',
                state: 'private',
                color: '#FFC8A2'
            },
            {
                title : '인사팀 회식 겸 식사',
                start : '2024-06-20',
                end : '2024-06-20',
                description: '냠냠',
                state: 'dept',
                color: '#CBAACB'
            },
            {
                title : '주말모임',
                start : '2024-06-30',
                end : '2024-06-30',
                description: '주말에 모임을...?',
                state: 'dept',
                color: '#CBAACB'
            }
        ]
    });

    calendar.render();
    
    function writeModalOpen() {
        $('#writeModal').modal('show');
    }

    function detailModalOpen() {
       alert('흐아아아');
    }
    
});


</script>
</html>