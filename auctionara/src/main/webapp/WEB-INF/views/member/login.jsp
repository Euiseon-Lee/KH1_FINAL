<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container-fluid">
	<div class="row">
		<h1>점보트론:<br>
			우리 동네에서<br>
			간편한 중고 경매
		</h1>
	</div>

	<form action="login" method="post">
		<input type="hidden" name="referer" value=${referer}>
	
		<div class="row">
			<input type="email" name="memberEmail" autocomplete="off" placeholder="email as id">
		</div>
		
		<div class="row">
			<input type="password" name="memberPw" autocomplete="off" placeholder="password">
		</div>

		

		<div class="row">
			<label>
				<input type="checkbox" >	
			</label> 아이디 저장하기		
		</div>

		<div class="row">
			<label>
				<input type="checkbox">	
			</label> 자동 로그인 설정
		</div>

		<div class="row">
			<button type="submit" onkeydown="hitEnterkey(event);">로그인</button>
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
		<a href="${root}/member/join_intro">회원가입</a>		
	</div>	










</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>