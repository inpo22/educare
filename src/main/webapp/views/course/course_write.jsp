<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>강의 관리 - 에듀케어</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- css -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<link href="/resources/course/course.css" rel="stylesheet">

<jsp:include page="/views/common/head.jsp"></jsp:include>

<!-- js -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

<style>
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
							<span class="input-group-text" id="basic-addon1">사원번호</span> 
							<input type="text" class="form-control" name="user_code" id="user_code" placeholder="강사의 사원번호를 입력해주세요.">
							<button class="btn btn-outline-secondary user-code-btn" type="button" id="checkUserBtn" onclick="checkUserCode()" style="width: 27% !important;">사원여부확인</button>
						</div>
						
						<div class="input-group input-group mb-3">
							<span class="input-group-text">강사명</span>
							<input type="text" class="form-control readInfo" name="user_name" id="user_name" placeholder="사원체크성공시 강사명이 출력됩니다." readonly>
							<span class="input-group-text">소속부서</span> 
							<input type="text" class="form-control readInfo" id="team_name"  name="team_name" placeholder="사원체크성공시 소속부서가 출력됩니다."  readonly>
						</div>
						
						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon2">강의명</span> 
							<input type="text" class="form-control" name="title" id="title" placeholder="강의명 입력해주세요.">
						</div>

						<div class="input-group input-group mb-3">
							<span class="input-group-text" id="basic-addon3">강의료</span> 
							<input type="text" class="form-control" name="course_price" id="course_price" placeholder="강의료를 입력해주세요.">
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
									<div class="form-control reservTextareaGo" id="reservTextareaGo" aria-label="With textarea"></div>
								</div>
							</div>
						</div>
					</div>
					
					<input type="hidden" name="content" id="content"/>
					
				</div>
				<div id="editor"></div>
					<button type="button" class="btn text-light bg-dark mt-2" id="submitButton">등록</button>
			</div>
		</div>

		<div class="modal fade" id="reservationModal" tabindex="-1"
			aria-labelledby="reservationModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="reservationModalLabel">강의실 예약 선택</h1>
						<button type="button" id="top-close-btn" class="btn-close bg-white rounded-5" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="modalForm">
						<input type="hidden" id="selectDate" name="selectDate" value=""/> 
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
														<small>* 오늘날짜는 ' <small class="todayBox">&nbsp &nbsp &nbsp</small> ' 로 표시됩니다.</small></br>
														<small>* 예약누르신날짜는 ' <small class="miniBox">&nbsp &nbsp &nbsp</small> ' 로 표시됩니다.</small>
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
																<option value="A102">A102</option>
																<option value="B101">B101</option>
																<option value="B102">B102</option>
																<option value="C101">C101</option>
																<option value="C102">C102</option>
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
														<div class="form-control reserv-textarea" id="reserv-textarea" aria-label="With textarea"></div>
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
							id="submitModalButton" onclick="submitButton()">등록</button>
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
    selectTimeBtnEvent(); //강의시간 선택 이벤트
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

/* 강의실 예약 : 캘린더, 예약시간버튼, 날짜+예약시간 창 */
var today = new Date();	
var preYear = today.getFullYear();	
var preMonth = today.getMonth();
var currentDay = today.getDate();

var preMonthFirst = new Date(preYear, preMonth, 1);	
var preMonthLast = new Date(preYear, preMonth + 1, 0); 

var preMonthFirstDate = preMonthFirst.getDate(); 
var preMonthFirstDay = preMonthFirst.getDay(); 

var preMonthLastDate = preMonthLast.getDate(); 
var preMonthLastDay = preMonthLast.getDay();

function drawCalendar() {
	
    $('#year-month').html(preYear + "년 " + (preMonth + 1) + "월");
	
  	//오늘날짜 구하기 
  	var today = new Date();
    var tyear = today.getFullYear();
    var tmonth = today.getMonth();
    var tday = today.getDate();
    
    var count = 1;
    var total = 42; //공식인가봄?

    var con = '';
    con += '<div class="days">';

    for (var i = 0; i < total; i++) {
        if (i < preMonthFirstDay || count > preMonthLastDate) {
            con += '<div class="emptyDay"></div>';
        } else {
        	var dateToCheck = new Date(preYear, preMonth, count);
            var isDisabled = (dateToCheck < today) ? ' disabled' : '';
        	var checkToday = (preYear === today.getFullYear() && preMonth === today.getMonth() && count === currentDay) ? ' today' : '';
        	con += '<div class="day' + checkToday  + isDisabled + '" id="select-day-' + count + '" data-day="' + count + '">' + count + '</div>';
            count++;
        }
    }
    con += '</div>';
	
    $('#daysData').html(con);
    
    $('#daysData').on('click', '.day', function() {
    	
        var selectDay = $(this).data('day');
        var calMonth = preMonth+1;
        var calYear = preYear;
        
        if(calMonth.toString().length < 2){
        	calMonth = '0' + calMonth;
        }
        
        if(selectDay.toString().length < 2){
        	selectDay = '0' + selectDay;
        }
        
        var formatDay = preYear +'-' + calMonth +'-'+selectDay; 
        var seleteRoom = $('#select-space').val();
        
        if (seleteRoom) {
        	$('#selectDate').val(formatDay);
            timeBtn(formatDay, seleteRoom);
            $('.day').removeClass('selectedDay');
        	$(this).addClass('selectedDay');
        } else {
            alert('강의실을 먼저 선택해주세요.');
        }
    });
}

$('#prevBtn').on("click", function() {
	event.preventDefault();
    event.stopPropagation();
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
    event.stopPropagation();
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
	var chkDay = [];

	$('.reservation-item').each(function() {
		var year = $(this).find('span').html().substring(0,4)*1;
		var month = $(this).find('span').html().substring(5,7)*1;
		var day = $(this).find('span').html().substring(8,10)*1;
		var dupFlag = true;

		for (var i = 0; i < chkDay.length; i++) {
			if (chkDay[i].year == year && chkDay[i].month == month && chkDay[i].day == day) {
				dupFlag = false;
				break;
			}
		}

		if (dupFlag) {
			var obj = {year:year, month:month, day:day};
			chkDay.push(obj);
		}
	});

	$('#year-month').html(preYear + "년 " + (preMonth + 1) + "월");
	
	//오늘날짜 구하기 
  	var today = new Date();
    var tyear = today.getFullYear();
    var tmonth = today.getMonth();
    var tday = today.getDate();
    
	var count = 1;
    var total = 42;

    var con = '';
    con += '<div class="days">';

    for (var i = 0; i < total; i++) {
        if (i < rePreMonthFirstDay || count > rePreMonthLastDate) {
            con += '<div class="emptyDay"></div>';
        } else {
            var dateToCheck = new Date(preYear, preMonth, count);
            var isDisabled = (dateToCheck < today) ? ' disabled' : '';

            var checkToday = (preYear === tyear && preMonth === tmonth && count === tday) ? ' today' : '';
            var highLightDay = '';
            for (var j = 0; j < chkDay.length; j++) {
                if (preYear === chkDay[j].year && (preMonth + 1) === chkDay[j].month && count === chkDay[j].day) {
                    highLightDay = ' highlight';
                    break;
                }
            }
            con += '<div class="day' + checkToday + highLightDay + isDisabled + '" id="select-day-' + count + '" data-day="' + count + '">' + count + '</div>';
            count++;
        }
    }
    con += '</div>';

    $('#daysData').html(con);
    
}

function timeBtn(selectDay,selectRoom) {
	var newTimeBtn = document.createElement('button');
	
	var paramData = {
		start_time: selectDay,
		course_space: selectRoom
	};
	
	console.log("paramData",paramData);
	$.ajax({
		url: '/course/reservationTime.ajax',
		type: 'POST',
		dataType:'JSON',
		data: JSON.stringify(paramData),
		contentType: 'application/json',
		success:function(data) {
			displayTimeButtons(data.list);
		},
		error:function(request, status, error){
			console.log(error);
		}
		
	});
}
	
function displayTimeButtons(times) {
	
    $('#buttonContainer').empty();
    
    var timess = {times};
    
    for (var i = 9; i < 23; i++) {
        var disabledAttr = '';

        for (var j = 0; j < times.length; j++) {
            if (times[j].time == i) {
                disabledAttr = 'disabled'; 
                break;
            }
        }
		var formatTime = i < 10 ? '0'+i : i;
       
		var contentTime = '<button class="time-btn btn btn-outline-secondary mb-2 mx-1" data-time="' + formatTime + '" ' + disabledAttr + '>';
        contentTime += formatTime + ":00";
        contentTime += '</button>';
		
        $('#buttonContainer').append(contentTime);
    }
    
    // 텍스트 영역의 예약된 시간 업데이트 함수 호출
    var selectDate = $('#selectDate').val();
    checkReservTimeInReservTextArea(selectDate);
}

function checkReservTimeInReservTextArea(selectDate) {
    $('.time-btn').removeClass('reserved-time').removeAttr('style');

    $('.reservation-item').each(function() {
        var findHtml = $(this).find('span').html();
        var reservationDate = findHtml.substring(0,10);
        var reservationTime = findHtml.substring(11,13);
        
        console.log("reservationDate",reservationDate);
        console.log("reservationTime",reservationTime);

        if (reservationDate === selectDate) {
        	// 이렇게까지해야되나..?
            $('.time-btn[data-time="' + reservationTime + '"]').addClass('reserved-time').css('background-color', 'gray');
        }
    });
}


function selectTimeBtnEvent() {
	var selectedRoom = ''; 
	
	$(document).on('click', '.time-btn', function(event) {
	    selectedRoom = $('#select-space').val();
	    var selectDate =  $('#selectDate').val();
	    var selectTime = $(this).attr('data-time');
	    
	    // 예약존재 확인
	    if (alreadyReserv(selectDate, selectTime)) {
	    	
	        alert('이미 선택된 시간입니다.');
	        event.preventDefault();
	        event.stopPropagation(); 
	        return;
	    }
	    
	    var selectReserv = '<div class="reservation-item"><span>' + selectDate + ' ' + selectTime + ':00' + '</span><button type="button" class="btn btn-sm btn-remove">x</button></div>';
	    var readonlyReserv = '<div class="reservation-item"><span>' + selectDate + ' ' + selectTime + ':00' + '</span></div>';
	    $('#reserv-textarea').append(selectReserv);
	    $('#reservTextareaGo').append(readonlyReserv);
		
	    // 눌린 예약시간인거 알려주는용도
	    $(this).attr('style', 'background-color: gray;');
	    
	    // 눌린 날짜인거 알려주는 용도
        reservCalendarDate(selectDate);
	    
	    event.stopPropagation();
	    event.preventDefault();
	});

	$(document).on('click', '.btn-remove', function() {
	    var removeData = $(this).parent('.reservation-item');
	    var findHtml =  $(this).parent('.reservation-item').find('span').html();
	    var removeDate = findHtml.substring(0,10);
	    var removeTime = findHtml.substring(11,13);
	    
	    console.log('removeDate : ', removeDate);
	    console.log('removeTime : ', removeTime);
	    console.log('==============================');
	    
	    // 예약지우기
	    removeData.remove();
	    
	    $('#reservTextareaGo .reservation-item').each(function() { 
	    	if ($(this).find('span').html() === findHtml) { 
	    		$(this).remove(); 
	    	} 
	    });
	    
	    
		// 없는날짜 스타일 제거
	    if (!exDate(removeDate)) {
	        removeReservCalendarDate(removeDate);
	    }

	    // 그시간의 시간버튼 스타일도 지우기
	    $('.time-btn[data-time="' + removeTime + '"]').removeAttr('style');
	});
	
	
	var selectedRoom = $('#select-space').val();
	
	$(document).on('change', '#select-space', function(event) {
		 var selectDate =  $('#selectDate').val();
		 if($('#reserv-textarea').html() != ''){
			if(confirm("강의실 변경시 선택하셨던 일정은 모두 삭제됩니다. 정말 변경하시겠습니까?")){
				$('.reservation-item').remove();
				$('.day').removeClass('highlight');
				$('.time-btn').removeAttr('style');
				$('.day').removeClass('selectedDay');
				if($(this).val() == ''){
					$('.time-btn').remove();
				} else {
				timeBtn(selectDate,selectedRoom);
				}
			}else{
				$(this).val(selectedRoom);
				console.log('selectedRoom : ', selectedRoom); 
				return false;
			}
		 }
	});

}



function alreadyReserv(selectDate, selectTime) {
    var already = false;
    $('.reservation-item').each(function() {
        var findHtml = $(this).find('span').html();
        if (findHtml === selectDate + ' ' + selectTime + ':00') {
        	$('.time-btn[data-time="' + selectTime + '"]').addClass('reserved-time');
        	already = true;
            return false;
        }
    });
    return already;
}

function exDate(removeDate) {
    var remove = false;
    $('.reservation-item').each(function() {
        if ($(this).find('span').html().includes(removeDate)) {
        	remove = true;
            return false;
        }
    });
    return remove;
}

function reservCalendarDate(date) {
    $('.day').each(function() {
        var day = $(this).data('day'); 
        var selectDate = $('#selectDate').val(); 
        var untilMonth = selectDate.substring(0, 7);
        var fullDate = untilMonth + '-' + (day < 10 ? '0' + day : day);

        console.log('day : ', day);
        console.log('fullDate : ', fullDate);

        if (fullDate === date) {
            $(this).addClass('highlight'); 
        }
    });
	
}

function removeReservCalendarDate(date) {
    $('.day').each(function() {
        var day = $(this).data('day');
        var selectDate = $('#selectDate').val(); 
        var untilMonth = selectDate.substring(0, 7);
        var fullDate = untilMonth + '-' + (day < 10 ? '0' : '') + day;

        if (fullDate === date) {
            $(this).removeClass('highlight');
        }
    });
}

// 현재날짜보다 이전날짜 클릭안되게하는거...
// 하..

function submitButton(){
	$('#reservationModal').modal('hide');
}

function checkUserCode(){
	var userCode = $('#user_code').val();
	
	if($('#checkUserBtn').html() === '수정'){
		$('#user_code').val('');
		$('#user_code').attr("readonly",false);
		$('#checkUserBtn').html('사원여부확인');
		return false;
	}
	
	console.log('userCode.>>>>'+userCode);
	$.ajax({
		url: '/course/checkUserCode.ajax',
		type: 'POST',
		dataType:'JSON',
		data:{ user_code: userCode },
		success:function(data) {
			console.log(data.result);
			if(data.result === "success" ){
				alert('사원번호 확인완료 되었습니다.');
				$('#user_code').attr("readonly",true); 
				$('#checkUserBtn').html('수정');
				$('#checkUserBtn').addClass('removeUser');
			}else{
				alert('입력하신 사원번호는 없는번호이니 다시 입력해주세요.');
			}
		},
		error:function(request, status, error){
			console.log(error);
		}
		
	}); 
}


$('#submitButton').click(function() {
	var num_check=/([^0-9])/;
	var userCode = $('#user_code').val();
	var courseTitle = $('#title').val();
	var coursePrice = $('#course_price').val();
	var rezCourse = $('#reservTextareaGo .reservation-item').find('span').html();
	var editorContent = editor.getHTML();
	var formatContent = $('#content').val(editorContent);
	var content = formatContent.val();
	var MAX_CONTENT_SIZE = 5 * 1024 * 1024;
    console.log("rezCourse",rezCourse);
	
    if ($("#user_code").attr("readonly") == undefined){
        alert('사원여부확인 체크해주세요.');
        return false;
    }else if (courseTitle === ''){
        alert('강의명을 입력해주세요.');
        $('#title').focus();
        return false;
    }else if (coursePrice === ''){
        alert('강의료를 입력해주세요.');
        $('#course_price').focus();
        return false;
    }else if (num_check.test(coursePrice)){
   		alert('강의료는 숫자로만 입력해주세요.');
   		$('#course_price').val= '';
   		$('#course_price').focus();
   		return false;
    }else if (rezCourse === undefined){
        alert('강의실예약은 필수입니다.');
        return false;
    }else if (editor.getMarkdown() === '') {
        alert('내용을 입력해 주세요.');
        editor.focus();
    } else if (new Blob([editorContent]).size > MAX_CONTENT_SIZE) {
        alert('내용의 용량이 초과되었습니다. 이미지의 크기나 갯수를 줄여 주세요.');
    } else{
    	submitCourseWrite();
    }

});


function submitCourseWrite(){
	var userCode = $('#user_code').val();
	var courseTitle = $('#title').val();
	var coursePrice = $('#course_price').val();
	var selectRoom = $('#select-space').val();
	
	var rezCourse = $('#reservTextareaGo .reservation-item span');
	var startTimeArray = [];
	var endTimeArray = [];
	rezCourse.each(function(){
		var endDay =  $(this).html().substring(0,10);
		var endTime = parseInt($(this).html().substring(11,13))+1;
		var fullFormatEnd = endDay + ' ' + endTime + ':00';
		var formatFullEnd= new Date(fullFormatEnd);
		var formatFullStart= new Date($(this).html());
		startTimeArray.push(formatFullStart);
		console.log("------------------");
		console.log("endDay==>"+endDay);
		console.log("------------------");
		console.log("endTime==>"+endTime);
		endTimeArray.push(formatFullEnd);
	});
	
	var editorContent = editor.getHTML();
	var formatContent = $('#content').val(editorContent);
	var content = formatContent.val();
	
	var minStart = startTimeArray.reduce((prev,curr) => {
		return new Date(prev).getTime() <= new Date(curr).getTime() ? prev : curr;
	})
	
	var maxEnd = endTimeArray.reduce((prev,curr) => {
		return new Date(prev).getTime() <= new Date(curr).getTime() ? curr : prev;
	})
	
	console.log("++++++++++++++++++++++");
	console.log("minStart==>"+minStart);
	
	console.log("++++++++++++++++++++++");
	console.log("maxEnd==>"+maxEnd);
	
	
	var paramData = {
		user_code: userCode,
		course_name: courseTitle,
		course_price: coursePrice,
		course_space: selectRoom,
		start_time_array: startTimeArray,
		end_time_array: endTimeArray,
		course_con: content,
		min_start: minStart,
		max_end : maxEnd
	};
		
	console.log("paramData",paramData);
	 $.ajax({
		url: '/course/reservationWrite.ajax',
		type: 'POST',
		dataType:'JSON',
		data: JSON.stringify(paramData),
		contentType: 'application/json',
		success:function(data) {
			console.log(data.result);
			if(data.result === "success" ){
				alert('등록이 완료되었습니다.');
				location.href='/course/list.go';
			}else{
				alert('등록에 실패하였습니다.');
			}
		},
		error:function(request, status, error){
			console.log(error);
		}
		
	}); 
	
}

$('#closeButton, #top-close-btn').on('click',function(){
	$('.reservation-item').remove();
	$('.day').removeClass('highlight');
	$('.time-btn').removeAttr('style');
	$('.time-btn').remove();
	$('#select-space').val('');
	$('.day').removeClass('selectedDay');
});

</script>

</html>