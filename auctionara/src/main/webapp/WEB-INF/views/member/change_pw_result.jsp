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
		<div class="half"><a href="${root}/member/check_email">아이디 찾기</a></div>
		<div class="half"><a href="${root}/member/change_pw">비밀번호 찾기</a></div>
	</div>
	
	<form action="change_pw" method="post">
		<div class="row">
			<p>
				가입하셨던 이메일 계정을 입력하시면,
				<br>
				비밀번호를 새로 설정할 수 있는 링크를 이메일로 발송해드립니다
			</p>
		</div>
		
		<div class="row">
			<input type="email" name="memberEmail" placeholder="email" value="${param.checkedEmail}"> 
		</div>
		
		<div class="row">
			<button type="submit">링크 발송</button>
		</div>	
		
		<div>
			<input type="text" name="certNumber">
			<input type="button" value="인증하기" class="btn-cert-check">
		</div>
	</form>	


</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>