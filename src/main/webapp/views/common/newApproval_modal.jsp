<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 전자 결재 유형 선택 모달 -->
<div id="newApproval-modal" class="modal" onclick="closeApprovalModal()">
	<div class="modal-content" onclick="event.stopPropagation()">
		<div>
			<span class="modal-title">문서 종류</span>
        	<span class="close" onclick="closeApprovalModal()">&times;</span>
        	<br/><br/>
        	<div class="approval-type-list">
        		<ul>
        			<li>- 휴가신청서</li>
        			<li>- 업무기안</li>
        		</ul>
        	</div>
        	<br/>
        	<div class="text-align-right right-padding">
        		<button class="btn btn-primary btn-sm approval-write">작성하기</button>
        	</div>
		</div>
    </div>
</div>

<script>
	$('.btn-newApproval').click(function() {
		$('#newApproval-modal').css('display', 'block');
	});
	
	var selectedApprovalType = '';
	
	$('.approval-type-list li').click(function() {
		$('.selected-value').removeClass('selected-value');
		$(this).addClass('selected-value');
		selectedApprovalType = $(this).html();
		// console.log(selectedApprovalType);
	});
	
	$('.approval-write').click(function() {
		if (selectedApprovalType == '- 휴가신청서') {
			location.href = '/vacaApproval/write.go';
		} else if (selectedApprovalType == '- 업무기안') {
			location.href = '/busiApproval/write.go';
		}
	});
	
	function closeApprovalModal() {
	    $('.modal').css('display', 'none');
	    $('.selected-value').removeClass('selected-value');
	    selectedApprovalType = '';
	}
</script>

