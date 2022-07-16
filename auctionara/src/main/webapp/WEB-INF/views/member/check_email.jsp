<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>
<div class="container-fluid">
	<div class="row mt-3">
		<div class="col-4 align-self-center mr-5">
			<h2 class="row fw-bold"><span class="border-bottom border-dark pb-4">아이디(이메일) 찾기</span></h2>
			<form action="check_email" method="post">
				<p class="row text-muted mt-4">경매나라는 이메일을 아이디로 사용하고 있습니다</p>
				<p class="row text-muted mt-3 mb-0">소유하고 계신 계정을 입력해보세요</p>
				<p class="row text-muted">가입여부를 확인해드립니다</p>
				<div class="row border-bottom mt-4 mb-2">
					<input type="email" name="memberEmail" class="form-control border-0" autocomplete="off" placeholder="name@example.com" value="${param.checkedEmail}">				
				</div>
				<c:if test="${param.success != null}">
				<div class="row">
					<p class="text-success">경매나라에 가입된 계정입니다</p>
				</div>
				</c:if>
				<c:if test="${param.fail != null}">
				<div class="row">
					<p class="text-primary">존재하지 않는 계정입니다</p>
				</div>
				</c:if>				
				<div class="row">
					<button type="submit" class="btn btn-primary btn-block mt-2">확인</button>	
				</div>		
			</form>
			<c:if test="${param.success != null}">
			<div class="row justify-content-center">
				<span class="fw-bold mt-4">로그인하러 가시겠습니까? <a class="ml-3" href="${root}/member/login">바로 로그인</a></span>
			</div>
			</c:if>
			<c:if test="${param.fail != null}">
			<div class="row justify-content-center">
				<span class="fw-bold mt-4">아직 경매나라 계정이 없나요? <a class="ml-3" href="${root}/member/join">회원가입</a></span>
			</div>
			</c:if>				
			<a class="row text-muted mt-3 justify-content-center fs-small" href="${root}/member/change_pw">비밀번호를 잊으셨나요?</a>
		</div>
		<div class="col">
			<img src="${root}/image/login_bg.jpg" id="login-bg" />
		</div>
	</div>	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>