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

<style>
.toastui-calendar-template-timegridDisplayPrimaryTime{
	font-size: 16px;
}

.toastui-calendar-event-time-content{
	padding: 7px 5px !important;
    font-size: 14px !important;
}

.toastui-calendar-event-time{
    border-radius: 10px !important;
    border-left: 3px solid rgb(101 101 101) !important;
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

.all {
	background-color: #535050;
	color: white;
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
    color: black;
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

.fc-toolbar-chunk{
	font-size: 19px;
}

.filter_btn{
	padding:15px;
}

.w-10{
	width: 10% !important;
}

</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<!-- Start #main -->
	<main id="main" class="main">

		<div class="pagetitle">
			<h1>강의실 관리</h1>
		</div>
		<!-- End Page Title -->

			<div class="row-sm-4">
				<fieldset>
					<button type="button" class="filter_btn w-10" id="all" data-type="all"
						style="border: 0; border-radius: 7px; background-color: #e55d62;">전체</button>
					<button type="button" class="filter_btn w-10" id="A101" data-type="A101"
						style="border: 0; border-radius: 7px; background-color: #db7e6a;">A101</button>
					<button type="button" class="filter_btn w-10" id="A102" data-type="A102"
						style="border: 0; border-radius: 7px; background-color: #faab23;">A102</button>
					<button type="button" class="filter_btn w-10" id="B101" data-type="B101"
						style="border: 0; border-radius: 7px; background-color: #87b27c;">B101</button>
					<button type="button" class="filter_btn w-10" id="B102" data-type="B102"
						style="border: 0; border-radius: 7px; background-color: #7db0c7;">B102</button>
					<button type="button" class="filter_btn w-10" id="C101" data-type="C101"
						style="border: 0; border-radius: 7px; background-color: #7774b6;">C101</button>
					<button type="button" class="filter_btn w-10" id="C102" data-type="C102"
						style="border: 0; border-radius: 7px; background-color: #b789a9;">C102</button>
				</fieldset>
			</div>
			
			<div class="row">
				<div class="col-12 mt-3">
					<div class="shadow-sm">
						<div class="test">
							<button class="btn btn-outline-info" onclick="dayGo()">day</button>
							<button class="btn btn-outline-info" onclick="weekGo()">week</button>
							<button class="btn btn-outline-info" onclick="monthGo()">month</button>
						</div>
						<div id="calendar"  style="min-height: 700px;"></div>
					</div>
				</div>
			</div>
		<!-- 필터부분 완료 -->
		<!-- End #wirteModal -->
	</main>
		
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
const container = document.getElementById('calendar');

const options = {
    defaultView: 'week',
    timezone: [{
        timezoneName: 'Asia/Seoul',
        displayLabel: 'Seoul'
    }],
    useFormPopup: false,
    useDetailPopup: true,
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
};

const calendar = new tui.Calendar(container, options);

$.ajax({
    url: '/course/check.ajax',
    type: 'POST',
    contentType: 'application/json',
    dataType: 'json',
    success: function(response) {
        console.log(response);
        var events = [];
        response.list.forEach(function(item) {
            var event = {
                title: item.course_space,
                nameCourse: item.course_name,
                name: item.name,
                start: item.start_time,
                end: item.end_time,
                space: item.course_space,
                course: item.course_no,
                backgroundColor: item.course_space === 'A101' ? '#db7e6a' :
                    item.course_space === 'A102' ? '#faab23' :
                    item.course_space === 'B101' ? '#87b27c' :
                    item.course_space === 'B102' ? '#7db0c7' :
                    item.course_space === 'C101' ? '#7774b6' : '#b789a9'
            };
            events.push(event);
        });
        calendar.createEvents(events);
        calendar.render();
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
     	color: 'rgba(255, 64, 64, 0.5)',
       },
  	saturday: {
    	color: 'rgba(64, 64, 255, 0.5)',
    	},
	 },
	 week: {
	    timeGridLeft: {
	      borderRight: 'none',
	      backgroundColor: 'rgba(81, 92, 230, 0.05)',
	      width: '70px',
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

	function dayGo(){
		calendar.changeView('day');
	}
	function weekGo(){
		calendar.changeView('week');
	}
	function monthGo(){
		calendar.changeView('month');
	}
	
	
/*필터 아직 안함*/
$(".filter_btn").click(function () {
    var eventType = $(this).data('type');
    var evt =	calendar.getEvent('course_space', 'title');
    states = eventType;
    console.log("states"+states);
    console.log("evt"+evt);
    if (states === 'all') {
        evt.forEach(function(event) {
            event.setProp('display', '');
        });
    } else {
        filterEvent();
    }
});

    
function filterEvent() {
    var evt = calendar.getEvent();
    evt.forEach(function(event) {
        var stateCont = event.extendedProps.state;
        if (!states.includes(stateCont)) {
            event.setProp('display', 'none'); 
        } else {
            event.setProp('display', ''); 
        }
        
    });
}



</script>
</html>