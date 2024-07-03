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
<link rel="stylesheet" href="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.css" />

<jsp:include page="/views/common/head.jsp"></jsp:include>

<!-- js -->
<!-- 캘린더 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.js"></script>
<script src="https://uicdn.toast.com/calendar/latest/toastui-calendar.ie11.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<style>
.toastui-calendar-template-timegridDisplayPrimaryTime{
	font-size: 16px;
}

.toastui-calendar-event-time-content{
	padding: 7px 5px !important;
    font-size: 14px !important;
    color:white !important;
}

.toastui-calendar-event-time{
    border-radius: 10px !important;
    border-left: 0px solid rgb(101 101 101) !important;
}

.toastui-calendar-edit-button {
    display: none !important; 
}

.toastui-calendar-delete-button {
     display: none !important;
}

.toastui-calendar-popup-section toastui-calendar-section-button{
	display: none !important;
}

.toastui-calendar-vertical-line{
	display: none !important;
}

.toastui-calendar-detail-container .toastui-calendar-section-button {
	border: none !important;
}

.toastui-calendar-detail-container{
	height:170px !important;
	border-radius: 28px !important;
	min-width: 245px !important;
	max-width: 245px !important;
}

.toastui-calendar-events{
	margin-right: 0px !important;
}

.toastui-calendar-week-view-day-names{
	height: 46px !important;
}

.toastui-calendar-popup-container{
	border-radius: 28px !important;
}


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
background: #EEEEEE;
color: #707070;
}

.modal-footer {
background: #EEEEEE;
color: #707070;
}

textarea {
	resize: none;
}

#courseInfo{
	border: 5px double #e8e8e8;
    background-color: white;
    resize: none;
    color: black;
  	height: 72px;
    overflow: auto;
    border-radius: 6px;
    font-size: 15px;
    padding: 2px 10px;
}

#calendar {
	height:680px;
}

.calendar-view{
	background-color: white;
	padding: 15px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

:root { -
	-fc-border-color: #e9ecef;
}

.filter_btn{
	padding:6px;
	color:white;
}

.w-10{
	width: 10% !important;
}


.bi-arrow-left-square{
	font-size:33px;
	color: #727070;
}

.bi-arrow-right-square{
	font-size:33px;
	color: #727070;
}

.goPrevOrNextBtn{
	width:70px;
	background-color: white;
	border:none;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<!-- Start #main -->
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>MY CLASS CALENDAR</h1>
		</div>
		<!-- End Page Title -->
		<div id="courseInfo" class="shadow-sm"> :: ${sessionScope.user_name}의 수강 목록 ::</div> 
		<div class="calendar-view mt-3">
			<div class="calendar-header mb-2 d-flex align-items-center justify-content-between">
				<div>
					<button onclick="goPrevOrNext('prev')" class="goPrevOrNextBtn"><i class="bi bi-arrow-left-square mt-2"></i></button>
					<button onclick="goPrevOrNext('next')" class="goPrevOrNextBtn"><i class="bi bi-arrow-right-square"></i></button>
					<span id="calendarRange" class="fs-3"></span>
				</div>
				<div class="d-flex align-items-center btn-group">
					<button class="btn btn-outline-secondary" onclick="goCalendar('day')">DAY</button>
					<button class="btn btn-outline-secondary" onclick="goCalendar('week')">WEEK</button>
					<button class="btn btn-outline-secondary" onclick="goCalendar('month')">MONTH</button>
				</div>
			</div>
			<div id="calendar"></div>
		</div>
		<!-- 필터부분 완료 -->
		<!-- End #wirteModal -->
	</main>

	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
var container = document.getElementById('calendar');

var options = {
    defaultView: 'month',
    timezone: [{
        timezoneName: 'Asia/Seoul',
        displayLabel: 'Seoul'
    }],
    useFormPopup: false,
    useDetailPopup: true,
    useCreationPopup: false,
    isReadOnly: true,
    usageStatistics: false,
    week: {
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        hourStart: 8,
        hourEnd: 23,
        eventView: ['time'],
        taskView: false,
        showNowIndicator: false
    },
    template: {
  		popupDetailAttendees({ attendees }) {
  	      return attendees + ' 강사님';
  	    },
  	  	popupDetailTitle({ title }) {
  	      return title;
  	    },
  	  	popupDetailState({ state }) {
  	      return state || '📚';
  	    },
    },
    
};

var calendar = new tui.Calendar(container, options);

var range = $('#calendarRange');

function displayRenderRange() {
    range.html(getNavbarRange(
        calendar.getDateRangeStart(),
        calendar.getDateRangeEnd(),
        calendar.getViewName()
    ));
}
function getNavbarRange(tzStart, tzEnd, viewType) {
    var start = new Date(tzStart.getTime());
    var end = new Date(tzEnd.getTime());
    var middle;

    if (viewType === 'month') {
        middle = new Date(start.getTime() + (end.getTime() - start.getTime()) / 2);
        return moment(middle).format('YYYY-MM');
    }
    if (viewType === 'day') {
        return moment(start).format('YYYY-MM-DD');
    }
    if (viewType === 'week') {
        return moment(start).format('YYYY-MM-DD') + ' ~ ' + moment(end).format('YYYY-MM-DD');
    }
    throw new Error('no view type');
}

$.ajax({
    url: '/course/stuCheck.ajax',
    type: 'POST',
    contentType: 'application/json',
    dataType: 'json',
    success: function(response) {
        console.log(response);
        var events = [];
        response.list.forEach(function(item) {
            var event = {
            	id: item.course_space,
            	calendarId: item.course_space,
                title: item.course_name,
                nameCourse: item.course_name,
                location : item.course_space,
                attendees : item.name,
                name: item.name,
                start: item.start_time,
                end: item.end_time,
                space: item.course_space,
                state: item.course_name,
                course: item.course_no,
                backgroundColor: item.course_space === 'A101' ? '#db7e6a' :
                    item.course_space === 'A102' ? '#faab23' :
                    item.course_space === 'B101' ? '#87b27c' :
                    item.course_space === 'B102' ? '#7db0c7' :
                    item.course_space === 'C101' ? '#7774b6' : '#b789a9'
            };
            events.push(event);
        });
        
        response.stuCourselist.forEach(function(item) {
        	var content = '<div>';
        	content += "📚 " +item.course_name + " ( " + item.course_start.split('T')[0] + " ~ " + item.course_end.split('T')[0]+ " ) ";
        	content += '</div>';
        	$('#courseInfo').append(content);
        });
        
        calendar.createEvents(events);
        calendar.render();
        displayRenderRange();
    },
    error: function(request, status, error) {
        console.log(error);
    }
});

calendar.setTheme({
 	common: {
 		gridSelection: {
         	backgroundColor: 'rgba(81, 230, 92, 0.05)',
         	border: '1px dotted #515ce6'
     	},
    	holiday: {
     		color: 'red',
       	},
  		saturday: {
    		color: 'blue',
    	},
	},
	week: {
	  	timeGridLeft: {
	      	borderRight: 'none',
	      	backgroundColor: '#fff2d663',
	   	},
    	nowIndicatorToday: {
        	border: '2px solid #515ce6',
     	},
     	nowIndicatorPast: {
         	border: '1px dashed red',
      	},  
      	futureTime: {
          	color: 'black',
      	},
     	panelResizer: {
         	border: '2px dotted #e5e5e5',
      	},
	},
});

function goCalendar(view){
	console.log("view"+ view);
	calendar.changeView(view);
	displayRenderRange();
}
function goPrevOrNext(result){
	if(result == 'prev'){
		calendar.prev();
		displayRenderRange();
	}else{
		calendar.next();
		displayRenderRange();
	}
}

</script>
</html>