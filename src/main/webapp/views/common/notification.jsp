<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<li class="nav-item dropdown">
		<!-- noti cnt -->
		<a class="nav-link nav-icon notiBtn" href="#" data-bs-toggle="dropdown">
			<i class="bi bi-bell"></i>
			<span class="badge bg-primary badge-number">4</span>
		</a>
		<!-- End noti cnt -->
		<!-- noti list -->
		<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
			<li class="dropdown-header">
			1개의 새로운 알림이 있습니다.
			</li>
			<li>
				<hr class="dropdown-divider">
			</li>

			<li class="notification-item">
				<i class="bi bi-exclamation-circle text-warning"></i>
				<div>
					<h6>[신규 일정]고2 상담 담임별 일정</h6>
					<p>2024-05-29 10:30</p>
				</div>
			</li>

			<li>
				<hr class="dropdown-divider">
				<a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
			</li>

		</ul><!-- End noti list -->
	</li>
</div>
<script>

	const toggleButton = document.querySelector;
	const menu = document.querySelector('.dropdown-menu');

	$('.notiBtn').on('click', function () {
		console.log('open the noti')
		//menu.classList.toggle('show');
/* 		if(menu.classList.contains('show')){
			console.log('open noti menu');
		}
 */	})
</script>
