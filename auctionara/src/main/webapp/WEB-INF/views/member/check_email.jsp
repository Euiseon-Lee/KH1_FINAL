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
	
	<form action="check_email" method="post">
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
			<button type="submit">확인</button>
		</div>
			
	</form>	
	
	<c:if test="${param.success != null}">
		<div class="row">
			<h4 style="color:blue;">${param.checkedEmail}은 경매나라에 가입된 계정입니다</h4>
		</div>
		<div class="row">
			<span><strong>로그인하러 가시겠습니까? </strong></span> &nbsp;&nbsp;
			<a href="${root}/member/login">바로 로그인</a>
		</div>
	</c:if>



	<c:if test="${param.fail != null}">
		<div class="row">
			<h4 style="color:red;">${param.checkedEmail}은 존재하지 않는 계정입니다</h4>
		</div>
		
		<div class="row">
			<span><strong>아직 경매나라 계정이 없나요? </strong></span> &nbsp;&nbsp;
			<a href="${root}/member/join">회원가입</a>	
		</div>
	</c:if>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>





