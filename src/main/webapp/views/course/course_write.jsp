<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>::EDUcare 강의등록 페이지::</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<jsp:include page="/views/common/head.jsp"></jsp:include>

<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

<style>
.pln_btn {
	height: 54px;
}

.board {
	background-color: white;
	padding: 15px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.card-header {
	font-weight: bold;
}

.search-btn {
	border: none;
	box-shadow: 3px 1px 6px #929297;
}

textarea {
	resize: none;
	height: 91px;
}

.reserv-textarea{
	resize: none;
	height: 280px;
}

.modal-body{
	padding: 0px 22px !important;
}
#calendar {
  	border-radius: 12px;
}

.cal-header {
    display: flex;
    justify-content: space-between;
    text-align: center;
    padding: 15px 5px;
    border-top-left-radius: 12px;
    border-top-right-radius: 12px;
}

.cal-header .nav-btn {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 20px;
    color: #6c757d;
}

.cal-header .nav-btn:hover {
    color: black;
}

#year-month {
    font-size: 20px;
    font-weight: 600;
    color: black;
}

.mainRow {
    display: flex;
    padding: 10px 0px;
}

.mainRow .day {
    flex: 1;
    text-align: center;
    font-weight: 600;
    color: #495057;
    text-transform: uppercase;
    font-size: 14px;
}

.days {
    display: flex;
    flex-wrap: wrap;
}

.days .day, .days .emptyDay {
    width: calc(100% / 7);
    height: 30px;
    box-sizing: border-box;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 16px;
    margin-bottom: 3px;
}

.days .day {
    cursor: pointer;
    border: 1px solid transparent; 
}

.days .day:hover {
    background-color: #FFC107;
    color: white;
    border-radius:20px;
    border: 1px solid transparent; 
}

.days .emptyDay {
    background-color: transparent;
    border: none; 
}

.input-group .btn {
    width: 70px;
}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div class="pagetitle">
			<h1>강의 관리 > 강의 등록</h1>
		</div>
		<!-- End Page Title -->

		<div class="row">
			<div class="d-grid gap-2 col-12 mt-3 board">
				<div class="row">
					<div class="col-md-6">
						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon1">강의명</span> 
							<input type="text" class="form-control" name="course_name" id="title" placeholder="강의명을 입력해주세요.">
						</div>

						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon2">강사명</span> 
							<input type="text" class="form-control" name="user_name" id="name" placeholder="강사명을 입력해주세요.">
						</div>

						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon3">강의료</span> 
							<input type="text" class="form-control" name="course_price" id="pay" placeholder="강의료를 입력해주세요.">
						</div>
					</div>

					<div class="col-md-6">
						<div class="row">
							<div class="col-md-12">
								<div class="input-group input-group mb-3">
									<button class="btn btn-outline-warning w-100" type="button" data-bs-toggle="modal" data-bs-target="#reservationModal">강의실 확인 및 예약하기</button>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12">
								<div class="input-group input-group mb-3">
									<textarea class="form-control" aria-label="With textarea" placeholder="강의실 예약시 예약정보가 출력됩니다."></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="editor"></div>
			</div>
		</div>

		<div class="modal fade" id="reservationModal" tabindex="-1"
			aria-labelledby="reservationModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="reservationModalLabel">강의실 예약확인 및 선택</h1>
						<button type="button" class="btn-close bg-white rounded-5" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="modalForm">
							<div class="row">
								<div class="d-grid gap-2 col-12 mt-3">
									<div class="row">
										<div class="col-md-4">
											<div class="input-group input-group">
												
												<!-- 캘린더 하는중..직접 만들어야하네.. =ㅅ=..언제하냐 -->
												<div class="calendar" id="calendar">
													<div class="cal-header">
														<button class="nav-btn prev-btn" id="prevBtn"><i class="bi bi-arrow-left"></i></button>
														<div id="year-month"></div>
														<button class="nav-btn next-btn" id="nextBtn"><i class="bi bi-arrow-right"></i></button>
													</div>
													<div class="mainRow">
														<div class="day">일</div>
														<div class="day">월</div>
														<div class="day">화</div>
														<div class="day">수</div>
														<div class="day">목</div>
														<div class="day">금</div>
														<div class="day">토</div>
													</div>
													<div id="daysData" class="daysData"></div>
												</div>
												<!--  캘린더 망치면 위에 부분까지 지우기  -->
												
												
											</div>
										</div>
										
										<div class="col-md-4 mt-3">
											<div class="row">
												<div class="col-md-12">
													<div class="input-group input-group mb-3">
													
														<label class="input-group-text">강의실</label>
															<select class="form-select" id="select-space">
																<option value="">강의실 선택</option>
																<option value="A101">A101</option>
																<option value="A101">A102</option>
																<option value="B101">B101</option>
																<option value="B102">B102</option>
																<option value="C101">C101</option>
																<option value="C101">C102</option>
															</select>
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-12">
													<div class="input-group input-group mb-3">
														<div id="buttonContainer"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-md-4 mt-3">
											<div class="row">
												<div class="col-md-12">
													<div class="input-group input-group mb-3">
														<textarea class="form-control reserv-textarea" aria-label="With textarea"
															placeholder="예약하실 날짜와 시간 선택시 예약정보가 출력됩니다." readonly></textarea>
													</div>
												</div>
											</div>
										</div>

									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" id="closeButton"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn text-light bg-dark"
							id="submitButton" onclick="sch_beforeSubmit()">등록</button>
						<button type="button" class="btn btn-secondary" id="deleteButton"
							onclick="sch_del()" style="display: none;">삭제</button>
						<button type="button" class="btn text-light bg-dark"
							id="beforeUpdateButton" style="display: none;">수정</button>
						<button type="button" class="btn text-light bg-dark"
							id="updateButton" style="display: none;">수정완료</button>
					</div>
				</div>
			</div>
		</div>


	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
$(document).ready(function () {
    drawCalendar();	//캘린더 그리깅
});

function course_wirte() {
	location.href = '/course/write.go'
}

const editor = new toastui.Editor({
	el : document.querySelector('#editor'),
	height : '500px',
	initialEditType : 'wysiwyg',
	hideModeSwitch : true,
	initialValue : "** 이곳에 강의에 대한 상세 커리큘럼에 대해서 적어주세요.**"
});
editor.removeToolbarItem('code');
editor.removeToolbarItem('codeblock');



var today = new Date();	//오늘
var preYear = today.getFullYear();	// 이번년
var preMonth = today.getMonth();	// 이번달 

var preMonthFirst = new Date(preYear, preMonth, 1);	
var preMonthLast = new Date(preYear, preMonth + 1, 0); 

var preMonthFirstDate = preMonthFirst.getDate(); // 현재 달 첫날 일
var preMonthFirstDay = preMonthFirst.getDay(); // 현재 달 첫날 요일

var preMonthLastDate = preMonthLast.getDate(); // 현재 달 마지막 일
var preMonthLastDay = preMonthLast.getDay(); // 현재 달 마지막 요일

function drawCalendar() {

    $('#year-month').html(preYear + "년 " + (preMonth + 1) + "월");

    var count = 1;
    var total = 42; //공식인가봄?

    var con = '';
    con += '<div class="days">';

    for (var i = 0; i < total; i++) {
        if (i < preMonthFirstDay || count > preMonthLastDate) {
            con += '<div class="emptyDay"></div>';
        } else {
            con += '<div class="day" id="select-day" data-day="'+count+'">' + count + '</div>';
            count++;
        }
    }
    con += '</div>';

    $('#daysData').html(con);
    
    // 날짜 클릭 이벤트 핸들러 등록
    $('#daysData').on('click', '.day', function() {
        var selectDay = $(this).data('day');
        
        var calMonth = preMonth+1;
        if(calMonth.toString().length < 2){
        	calMonth = '0' + calMonth;
        }
        
        if(selectDay.toString().length < 2){
        	selectDay = '0' + selectDay;
        	console.log(selectDay);
        }
        
        var formatDay = preYear +'-' + calMonth +'-'+selectDay; 
        console.log('Selected day:', formatDay);
        var seleteRoom = $('#select-space').val();
        console.log('seleteRoom:', seleteRoom);
        
        if (seleteRoom) {
            timeBtn(formatDay, seleteRoom); // 선택한 날짜와 강의실에 따라 시간 버튼 생성
        } else {
            alert('강의실을 먼저 선택해주세요.');
        }
    });
}

$('#prevBtn').on("click", function() {
	event.preventDefault();
    event.stopPropagation(); // 이벤트 버블링 제거
	console.log('prevBtn 왜 닫히냐구');
	
    preMonth--;
	if(preMonth < 0){
		preMonth = 11;
		preYear--;
	}
	 
	reDrawCalendar();
	
});

$('#nextBtn').on("click", function() {
	event.preventDefault();
    event.stopPropagation(); // 이벤트 버블링 제거
	console.log('nextBtn 왜 닫히냐구');
	
	preMonth++;
	if(preMonth > 11){
		preMonth = 0;
		preYear++;
	}
	reDrawCalendar();
	
});


function reDrawCalendar(){
	var rePreMonthFirstDay = new Date(preYear, preMonth, 1).getDay();
	var rePreMonthLastDate =  new Date(preYear, preMonth + 1, 0).getDate();
	
	$('#year-month').html(preYear + "년 " + (preMonth + 1) + "월");
	
	var count = 1;
    var total = 42; //공식인가봄?

    var con = '';
    con += '<div class="days">';

    for (var i = 0; i < total; i++) {
        if (i < rePreMonthFirstDay || count > rePreMonthLastDate) {
            con += '<div class="emptyDay"></div>';
        } else {
            con += '<div class="day" id="select-day" data-day="' + count + '">' + count + '</div>';
            count++;
        }
    }
    con += '</div>';

    $('#daysData').html(con);
	
}

//날짜 클릭시 선택할 수 있는 시간 나오게 하기 ... 하는중입니다... 
//캘린더 틀 만드느라 못했어유..
function timeBtn(selectDay,selectRoom){
	var newTimeBtn = document.createElement('button');
	
	 // 캘린더에서 날짜 클릭 시 이벤트 핸들러
	//  $('#calendar').on('click', '.date', function() {
	//    var selectedDate = $(this).data('date'); // 클릭한 날짜 가져오기, 예: '2024-06-20'
	var paramData={
		start_time: selectDay,
		course_space: selectRoom
	};
	
	$.ajax({
		url: '/course/reservationTime.ajax',
		type: 'POST',
		dataType:'JSON',
		data: JSON.stringify(paramData),
		contentType: 'application/json',
		success:function(data){
			console.log("datadatea",data.list[0].time);
				 displayTimeButtons(data.list);
				
			 if(response < 0){
				 alert('아직예약없음');
			 }
		},
		error:function(request, status, error){
			console.log(error);
		}
		
	});
}
	
function displayTimeButtons(times) {
    $('#buttonContainer').empty();
    console.log("ttttttt",times[0]);
    
    var timess = {times};
    console.log("tttrererert",timess[0]);
    for (var i = 9; i < 23; i++) {
        var disabledAttr = '';

        for (var j = 0; j < times.length; j++) {
            if (times[j].time == i) {
                disabledAttr = 'disabled'; 
                break;
            }
        }

        var contentTime = '<button class="time-btn btn btn-outline-secondary mb-2 mx-1" data-time="' + i + '" ' + disabledAttr + '>';
        contentTime += i + ":00";
        contentTime += '</button>';

        $('#buttonContainer').append(contentTime);
    }
}

</script>

</html>