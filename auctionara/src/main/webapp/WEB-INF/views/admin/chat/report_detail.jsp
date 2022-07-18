<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@include file="/WEB-INF/views/admin/template/header.jsp"%>

<script>
	$(function() {
		$("#history-back").click(function() {
			window.history.back();
		});
	});
</script>

<div class="container">

	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<div class="col-1">
					<i id="history-back" class="fa-solid fa-arrow-left fa-2x"
						style="cursor: pointer;"></i>
				</div>
				<div class="col-11">
					<h1>채팅 신고 상세</h1>
				</div>
			</div>
		</div>
	</div>
	
	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<h3 class="text-secondary">신고 내용</h3>
				<h6 class="mt-2">${reportReason}</h6>
			</div>
		</div>
	</div>

	<div class="card">
		<div class="card-body">
			<c:forEach var="content" items="${content}">
				<div class="row">
					<div class="col-1">
						<h5 class="text-secondary">${content.memberNick }</h5>
					</div>
					<div class="col-11">
						<h5 class="text-secondary">${content.chatTime }</h5>
					</div>
				</div>
				<h4>${content.chatContent}</h4>
				<hr>
			</c:forEach>
		</div>
	</div>
	
	<div class="card">
		<c:choose>
			<c:when test="${restriction == 0 }">
				<a href="${pageContext.request.contextPath}/admin/restriction/restrict_chat/${auctioneerNo}/${chatReportNo}" class="btn btn-danger">제재하기</a>
			</c:when>
			<c:when test="${restriction == 1 }">
				<button class="btn btn-danger disabled">제재 완료</button>
			</c:when>
		</c:choose>
	</div>

</div>

<%@include file="/WEB-INF/views/admin/template/footer.jsp"%>