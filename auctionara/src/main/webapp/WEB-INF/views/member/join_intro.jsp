<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>


<div class="container-fluid">
	<div class="row">
		<h1>회원가입 타입 고르기</h1>
	</div>
	

	<div class="row">
		<h3><a href="${root}/member/join">일반 회원가입</a></h3>		
	</div>

	<div class="row">
		<h3><a href="">네이버 회원가입</a></h3>		
	</div>

	<div class="row">
		<h3><a href="">구글 회원가입</a></h3>
	</div>


	
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>