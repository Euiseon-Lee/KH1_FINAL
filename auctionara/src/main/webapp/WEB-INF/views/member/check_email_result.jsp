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
		<h1>아이디 검색 결과</h1>
	</div>
	
	<div class="row">
		<div class="half"><a href="${root}/member/check_email">아이디 찾기</a></div>
		<div class="half"><a href="${root}/member/change_pw">비밀번호 찾기</a></div>
	</div>


	<div class="row">
		<h3>"${memberEmailResult}"는 경매나라에 등록된 계정입니다</h3>
	</div>
	
	<div class="row">
		<a href="${root}/member/login">바로 로그인하러 가기</a>
	</div>

	<div class="row">
		<a href="${root}">메인 페이지로 이동</a>
	</div>




</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>