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
		<div class="half"><a href="${root}/member/find_email">아이디 찾기</a></div>
		<div class="half"><a href="${root}/member/change_pw">비밀번호 찾기</a></div>
	</div>
	
	<form action="find_email" method="post">
		<div class="row">
			<p>
				경매나라는 이메일을 아이디로 사용하고 있습니다
				<br>
				소유하고 계신 계정을 입력해보세요
				<br>
				가입여부를 확인해드립니다
			</p>
		</div>
		
		<div class="row">
			<input type="email" name="memberEmail" placeholder="email"> 
		</div>
		
		<div class="row">
			<button type="submit" onkeydown="hitEnterkey(event);">확인</button>
		</div>	
	</form>	


</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>