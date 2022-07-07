<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>


<div class="container-fluid">

	<div class="row">
		<h1>비밀번호 재설정</h1>
	</div>

	<form action="reset" method="post">
		<input type="hidden" name="memberEmail" value="${param.memberEmail}">
		<input type="hidden" name="newCertNo" value="${newCertNo }">
		
		<div class="row">
			<label> 변경할 비밀번호
				<input type="password" name="memberPw" required>
			</label>
		</div>
		
		<div class="row">
			<input type="submit" value="변경">
		</div>

	</form>


</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>