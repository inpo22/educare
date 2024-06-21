<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		width: 59%;
		height: 100%;
	}
	#right-section {
		width: 40%;
		height: 100%;
		padding-left: 50px;
	}
	.section-title {
		font-size: 20px;
		font-weight: 600;
		color: #012970;
		padding-left: 10px;
	}
	.white-section {
		background-color: white;
		height: auto;
		border-radius: 5px;
		box-shadow: 4px 4px 2px -2px rgba(0, 0, 0, 0.2);
	}
	.small-white-section {
		background-color: white;
		height: auto;
		width: 23%;
		display: inline-block;
		border-radius: 5px;
		box-shadow: 4px 4px 2px -2px rgba(0, 0, 0, 0.2);
		padding: 20px;
		text-align: center;
	}
	.small-white-section span {
		font-size: 1.25rem;
	}
	.margin-right {
		margin-right: 20px;
	}
	#chart {
		padding-top: 10px;
	}
	.first-col {
		width: 54%
	}
	.second-col {
		width: 25%
	}
	.third-col {
		width: 20%
	}
	.table th, .table td {
		text-align: center;
	}
	a {
		color: black;
	}
	.blue-color {
		color: rgb(88, 88, 255);
	}
	.schedule-ul {
		padding-top: 1px;
	}
	.schedule-ul li {
		list-style-type: none;
		margin: 20px 0;
	}
	.more-div {
		padding-left: 30px;
		padding-bottom: 10px;
	}
	.purple-color {
		color: #e06efc
	}
	.green-color {
		color: #6efcb3
	}
	.font-weight {
		font-weight: 900
	}
</style>
</head>

<body>

	<jsp:include page="/views/common/header.jsp"></jsp:include>
	<jsp:include page="/views/common/sidebar.jsp"></jsp:include>

	<main id="main" class="main">
		<div class="display-flex">
			<div id="left-section">
				<h5>관리자 대시보드</h5>
			</div>
			<div id="right-section">
			</div>
		</div>

	</main>
	<!-- End #main -->

	<jsp:include page="/views/common/footer.jsp"></jsp:include>

</body>
<script>
	var lastYearData = [];
	var thisYearData = [];
	
	var now = new Date();
	var month = now.getMonth() + 1;
	var months = [month];
	
	for (var i = 0; i < 5; i++) {
		month -= 1;
		if (month == 0) {
			month = 12;
		}
		months.unshift(month);
	}
	
	// console.log(months);
	
	$.ajax({
		type:'get',
		url:'/mainChart/list.ajax',
		data:{
			'months':months.toString()
		},
		dataType:'json',
		success:function(data) {
			lastYearData.push(data.dataList[1].first);
			lastYearData.push(data.dataList[1].second);
			lastYearData.push(data.dataList[1].third);
			lastYearData.push(data.dataList[1].fourth);
			lastYearData.push(data.dataList[1].fifth);
			lastYearData.push(data.dataList[1].sixth);
			
			thisYearData.push(data.dataList[0].first);
			thisYearData.push(data.dataList[0].second);
			thisYearData.push(data.dataList[0].third);
			thisYearData.push(data.dataList[0].fourth);
			thisYearData.push(data.dataList[0].fifth);
			thisYearData.push(data.dataList[0].sixth);
			
			var options = {
				series: [{
					name: '작년',
					data: lastYearData
				}, {
					name: '올해',
					data: thisYearData
				}],
				chart: {
					type: 'bar',
					height: 500,
				},
				plotOptions: {
					bar: {
						horizontal: false,
						columnWidth: '55%',
						endingShape: 'rounded'
					},
				},
				dataLabels: {
					enabled: false
				},
				stroke: {
					show: true,
					width: 2,
					colors: ['transparent']
				},
				xaxis: {
					categories: [months[0] + '월', months[1] + '월', months[2] + '월', months[3] + '월', months[4] + '월', months[5] + '월']
				},
				yaxis: {
					title: {
						text: '(백만원)'
					}
				},
				fill: {
					opacity: 1
				},
				tooltip: {
					y: {
						formatter: function (val) {
							return val + " 백만원"
						}
					}
				}
			};

			var chart = new ApexCharts(document.querySelector("#chart"), options);
			chart.render();
		},
		error: function(request, status, error) {
			console.log("code: " + request.status)
			console.log("message: " + request.responseText)
			console.log("error: " + error);
		}
	});
	



</script>
</html>