<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>


<div class="container-fluid">

	<form action="reset" method="post">
		<input type="hidden" name="memberEmail" value="${param.memberEmail}">
		<input type="hidden" name="certNo" value="${param.certNo}">
	
		<div class="row">
			<label> 변경할 비밀번호
				<input type="password" name="memberPw" required>
			</label>
		</div>
		
		<div class="row">
			<input type="submit" value="변경">
		</div>

	</form>
	

	
	<c:if test="${param.success != null}">
		<div class="row">
			<h4 style="color:blue;">비밀번호 재설정 완료</h4>
		</div>
	</c:if>

	<c:if test="${param.fail != null}">
		<div class="row">
			<h4 style="color:red;">비밀번호 재설정에 실패하였습니다</h4>
		</div>
	</c:if>
	
	<c:if test="${param.error != null}">
		<div class="row">
			<h4 style="color:red;">오류가 발생하였습니다</h4>
		</div>
	</c:if>


</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>