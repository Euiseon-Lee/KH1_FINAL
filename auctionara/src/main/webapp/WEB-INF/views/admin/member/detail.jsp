<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%@include file="/WEB-INF/views/admin/template/header.jsp" %>

<script>
	$(function(){
		$(".set-general").click(function(e){
			var result = confirm("해당 회원을 일반회원으로 설정하시겠습니까?");
			
			if(!result) {
				e.preventDefault();				
			} 
		});	
		$(".set-block").click(function(e){
			var result = confirm("해당 회원을 블랙회원으로 설정하시겠습니까?");
			
			if(!result) {
				e.preventDefault();				
			} 
		});
		$("#history-back").click(function(){
			window.history.back(); 			
		});
	});
</script>

<div class="container">
	
	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<div class="col-1">
					<i id="history-back" class="fa-solid fa-arrow-left fa-2x" style="cursor:pointer;"></i>
				</div>
				<div class="col-11">
					<h1>회원 상세정보</h1>
				</div>
			</div>
		</div>
	</div>
	
	<div class="card">
		<div class="card-body">
			<ul class="list-group list-group-flush">
				<li class="list-group-item">
					<h2 class="card-title">닉네임</h2>
					<p class="card-text">${memberDto.memberNick}</p>
				</li>
				<li class="list-group-item">
					<h2 class="card-title">이메일 주소</h2>
					<p class="card-text">${memberDto.memberEmail}</p>
				</li>
				<li class="list-group-item">
					<h2 class="card-title">보유 포인트</h2>
					<p class="card-text">
						<fmt:formatNumber value="${memberDto.memberHoldingPoints}" pattern="#,###" /> Point
					</p>
				</li>
				<li class="list-group-item">
					<h2 class="card-title">거래 가능 시간</h2>
					<p class="card-text">${memberDto.memberAvailableTime}</p>
				</li>
				<li class="list-group-item">
					<h2 class="card-title">누적 경고 횟수</h2>
					<c:choose>
						<c:when test="${memberDto.memberRedCount >= 10}">
							<p class="card-text" style="color:red;">${memberDto.memberRedCount}</p>
						</c:when>
						<c:when test="${memberDto.memberRedCount < 10}">
							<p class="card-text" style="color:black;">${memberDto.memberRedCount}</p>
						</c:when>
					</c:choose>
				</li>
				<li class="list-group-item">
					<h2 class="card-title">가입일</h2>
					<p class="card-text">${memberDto.memberJoindate}</p>
				</li>
				<li class="list-group-item">
					<h2 class="card-title">마지막 로그인 일시</h2>
					<p class="card-text">${memberDto.memberLogintime}</p>
				</li>
				<li class="list-group-item">
					<h2 class="card-title">회원 등급</h2>
					<div class="row">
						<div class="col-7">
						<c:choose>
							<c:when test="${memberDto.memberGrade == '블랙회원'}">
								<p class="card-text" style="color:red;">${memberDto.memberGrade}</p>
							</c:when>
							<c:when test="${memberDto.memberGrade == '일반회원'}">
								<p class="card-text" style="color:black;">${memberDto.memberGrade}</p>
							</c:when>
							<c:otherwise>
								<p class="card-text" style="color:gray;">${memberDto.memberGrade}</p>
							</c:otherwise>
						</c:choose>
						</div>
						<div class="col-5 text-end">
							<c:choose>
								<c:when test="${memberDto.memberGrade == '블랙회원' }">
									<a href="${pageContext.request.contextPath}/admin/member/setGeneral/${memberDto.memberNo}" class="btn btn-primary set-general">일반회원 등록</a>
								</c:when>
								<c:when test="${memberDto.memberGrade == '일반회원' }">
									<a href="${pageContext.request.contextPath}/admin/member/setBlock/${memberDto.memberNo}" class="btn btn-danger set-block">블랙회원 등록</a>
								</c:when>
								<c:otherwise>
									<span></span>
								</c:otherwise>
							</c:choose>
						</div>				
					</div>
				</li>
			</ul>
		</div>
	</div>
	
</div>

<%@include file="/WEB-INF/views/admin/template/footer.jsp" %>