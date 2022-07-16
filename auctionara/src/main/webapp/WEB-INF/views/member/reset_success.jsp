<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container-fluid">
	<div class="row mt-3">
		<div class="col-4 align-self-center mr-5">
			<h2 class="row fw-bold">비밀번호가</h2>
			<h2 class="row fw-bold mt-1">재설정되었습니다</h2>
			<div class="row mt-3">
				<a class="text-primary fw-bold" href="${root}/member/login"><i class="fa-solid fa-angles-right mr-2"></i>로그인하러 가기</a>
			</div>			
		</div>
		<div class="col">
			<img src="${root}/image/login_bg.jpg" id="login-bg" />
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>