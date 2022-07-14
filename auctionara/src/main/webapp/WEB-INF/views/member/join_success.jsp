<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@include file="/WEB-INF/views/template/header.jsp" %>


<div class="container col-6 offset-3 form-group center-block">
	<div class="row jumbotron text-center">
		<h1>회원가입이 완료되었습니다</h1>
	</div>
	
	<div class="alert alert-info" role="alert">
		<h3>
			<a href="${root}/member/login" class="alert-link">☞ 바로 로그인하러가기</a>
		</h3>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>