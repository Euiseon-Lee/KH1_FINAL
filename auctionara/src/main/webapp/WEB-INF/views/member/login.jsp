<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="saveIdExists" value="${cookie.saveId != null}"></c:set>
<c:set var="autologinExists" value="${cookie.autologin != null}"></c:set>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container-fluid">
	<div class="row">
		<h1>점보트론:<br>
			우리 동네에서<br>
			간편한 중고 경매
		</h1>
	</div>

	<form action="login" method="post">
		<input type="hidden" name="referer" value="${referer}">
	
		<div class="row">
			<input type="email" name="memberEmail" autocomplete="off" placeholder="email as id" id="memberEmail" value="${cookie.saveId.value}">
		</div>
		
		<div class="row">
			<input type="password" name="memberPw" autocomplete="off" placeholder="password">
		</div>

	
		<c:if test="${param.fail != null}">
			<div class="row">
					<h4 style="color:red;">로그인 정보가 일치하지 않습니다</h4>
			</div>
		</c:if>		

		<div class="row">
			<label>
				<c:choose>
					<c:when test="${saveIdExists}">
						<input type="checkbox" name="remember" checked>
					</c:when>
					<c:otherwise>
						<input type="checkbox" name="remember">
					</c:otherwise>
				</c:choose>
			</label> 아이디 저장하기		
		</div>

		<div class="row">
			<label>
				<c:choose>
					<c:when test="${autologinExists}">
						<input type="checkbox" name="autologin" checked>
					</c:when>
					<c:otherwise>
						<input type="checkbox" name="autologin">
					</c:otherwise>
				</c:choose>		
			</label> 자동 로그인 설정
		</div>

		<div class="row">
			<button type="submit" onkeydown="hitEnterkey(event);" id="submit">로그인</button>
		</div>	

	</form>	
	

	
	
	<div class="row">
		<a href="${root}/member/check_email">이메일을 잊으셨나요?</a>
	</div>

	<div class="row">
		<a href="${root}/member/change_pw">비밀번호를 잊으셨나요?</a>
	</div>
	
	<div class="row">
		<span><strong>아직 경매나라 계정이 없나요? </strong></span> &nbsp;&nbsp;
		<a href="${root}/member/join">회원가입</a>		
	</div>	


</div>





<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
// 	$(function(){
		
// 		$("#submit").on("click", function(){
				
// 			localStorage.setItem('autoLogincheck', $("#auto").is(":checked"));
// 			localStorage.setItem('autoLoginEmail', $("#memberEmail").val());
// 			localStorage.setItem('autoLoginToken', $("#autoToken").val());

// 		})

// 	});

</script>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>