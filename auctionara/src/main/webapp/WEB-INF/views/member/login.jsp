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
			<label>이메일
				<input type="email" name="memberEmail" autocomplete="off" placeholder="email">
			</label>
		</div>
		
		<div class="row">
			<label>비밀번호
				<input type="password" name="memberPw" autocomplete="off" placeholder="password">
			</label>
		</div>

		

		<div class="row">
			<label>
				<input type="checkbox" >	
			</label> 이메일 기억하기		
		</div>

		<div class="row">
			<label>
				<input type="checkbox">	
			</label> 자동 로그인 설정
		</div>

		<div class="row">
			<button type="submit">로그인</button>
		</div>	

	</form>	
	
	
	
	<div class="row">
		<a href="${root}/member/find_email">이메일을 잊으셨나요?</a>
	</div>

	<div class="row">
		<a href="${root}/member/find_pw">비밀번호를 잊으셨나요?</a>
	</div>	










</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>