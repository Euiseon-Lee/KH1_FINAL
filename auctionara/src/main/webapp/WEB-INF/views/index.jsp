<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container-fluid">
	
	<div class="row">
		<h2></h2>
	</div>
	
	<div class="row">
		<h1><a href="${root}/member/join_intro">회원가입</a></h1>
	</div>
	
	<div class="row">
		<h1><a href="${root}/member/login">로그인</a></h1>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>