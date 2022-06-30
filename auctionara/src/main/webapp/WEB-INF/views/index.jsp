<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container-fluid">
	
	<!-- 세션 확인용 임시 공간 -->
	<div class="row">
		<h5>회원번호: ${whoLogin}</h5>
	</div>
	<div class="row">
		<h5>로그인상태: ${isLogin}</h5>
	</div>
	<div class="row">
		<h5>관리자 여부: ${isAdmin}</h5>
	</div>
	<div class="row">
		<h5>블랙회원 여부: ${isBlackMamba}</h5>
	</div>
	
	<div class="row">
		<h1><a href="${root}/member/join_intro">회원가입</a></h1>
	</div>
	
	<div class="row">
		<h1><a href="${root}/member/login">로그인</a></h1>
	</div>
	
	<div class="row">
		<h1><a href="${root}/member/logout">로그아웃</a></h1>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>