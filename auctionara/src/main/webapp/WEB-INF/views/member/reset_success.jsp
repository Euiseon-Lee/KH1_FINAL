<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<style>
	.half{
		position:relative;
		display: inline-block;
		width: 15%;
	}
</style>

<div class="container-fluid">

	<div class="row">
		<h1>아이디(이메일)·비밀번호 찾기</h1>
	</div>
	
	<div class="row">
		<div class="half"><a href="${root}/member/check_email">아이디 찾기</a></div>
		<div class="half"><a href="${root}/member/change_pw">비밀번호 찾기</a></div>
	</div>
	
	<div class="row">
		<h3>비밀번호가 정상적으로 재설정되었습니다</h3>
	</div>
	
	<div class="row">
		<strong>로그인하러 가시겠습니까?</strong>
		<a href="${root}/member/login">즉시 로그인</a>
	</div>









</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>