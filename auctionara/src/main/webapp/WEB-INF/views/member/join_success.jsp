<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@include file="/WEB-INF/views/template/header.jsp" %>


<div class="container-fluid">
	<div class="row">
		<h1>회원가입 완료</h1>
	</div>
	
	<div class="row">
		<h3>
			<a href="${root}/member/login">로그인하러가기</a>
		</h3>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>