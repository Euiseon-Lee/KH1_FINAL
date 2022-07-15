<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container-fluid">
	<div class="row mt-3">
		<div class="col-4 align-self-center mr-5">
			<h2 class="row fw-bold"><span class="border-bottom border-dark pb-4">비밀번호 찾기</span></h2>
			<form action="change_pw" method="post">
				<p class="row text-muted mt-4 mb-0">가입하셨던 이메일 계정을 입력하시면,</p>
				<p class="row text-muted mb-0">비밀번호를 새로 설정할 수 있는 링크를</p>
				<p class="row text-muted">이메일로 발송해드립니다</p>
				<div class="row border-bottom mt-4 mb-2">
					<input type="email" name="memberEmail" class="form-control border-0" autocomplete="off" placeholder="name@example.com">				
				</div>
				<c:if test="${param.fail != null}">
				<div class="row">
					<p class="text-primary">이메일 정보가 일치하지 않습니다</p>
				</div>
				</c:if>
				<c:if test="${param.success != null}">
				<div class="row">
					<p class="text-success mb-0">비밀번호 재설정 링크가 성공적으로 발송되었습니다</p>
					<p class="text-success">해당 메일함을 확인해주세요</p>
				</div>
				</c:if>				
				<div class="row">
					<button type="submit" class="btn btn-primary btn-block mt-2">링크 발송</button>	
				</div>
			</form>
		</div>
		<div class="col">
			<img src="${root}/image/login_bg.jpg" id="login-bg" />
		</div>
	</div>	
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>