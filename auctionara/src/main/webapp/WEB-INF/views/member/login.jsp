<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="saveIdExists" value="${cookie.saveId != null}"></c:set>
<c:set var="autologinExists" value="${cookie.autologin != null}"></c:set>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container-fluid">
	<div class="row mt-3">
		<div class="col-4 align-self-center mr-5">
			<h2 class="row fw-bold">우리 동네에서</h2>
			<h2 class="row fw-bold mt-1 mb-5">간편한 중고 경매</h2>
			<form action="login" method="post" class="form-group">
				<div class="row border-bottom mb-2">
					<input type="email" name="memberEmail" id="memberEmail" value="${cookie.saveId.value}"
						class="form-control border-0" autocomplete="off" placeholder="name@example.com" >				
				</div>
				<div class="row border-bottom mb-4">
					<input type="password" name="memberPw" 
						class="form-control border-0" autocomplete="off" placeholder="비밀번호를 입력해주세요">
				</div>
				<c:if test="${param.fail != null}">
				<div class="row alert alert-primary" role="alert"><i class="fa-solid fa-circle-exclamation mr-2 mt-1"></i>로그인 정보가 일치하지 않습니다</div>	
				</c:if>
				<div class="row my-2">
					<div class="col form-check">
						<label class="form-check-label" for="ck1">
						<c:choose>
							<c:when test="${saveIdExists}">
							<input class="form-check-input" type="checkbox" name="remember" id="ck1" checked>
							</c:when>
							<c:otherwise>
							<input class="form-check-input" type="checkbox" name="remember" id="ck1">
							</c:otherwise>
						</c:choose>
						아이디 저장하기</label>	
					</div>
					<div class="col form-check">
						<label class="form-check-label" for="ck2">
						<c:choose>
							<c:when test="${autologinExists}">
								<input class="form-check-input" type="checkbox" name="autologin" id="ck2" checked>
							</c:when>
							<c:otherwise>
								<input class="form-check-input" type="checkbox" name="autologin" id="ck2">
							</c:otherwise>
						</c:choose>
						자동 로그인 설정</label>	
					</div>						
				</div>
				<div class="row">
					<button type="submit" class="btn btn-primary btn-block mt-2" onkeydown="hitEnterkey(event);" id="submit">로그인</button>	
				</div>
			</form>
			<div class="row mt-4 justify-content-center">
				<span class="fw-bold">아직 경매나라 계정이 없나요?<a class="ml-3" href="${root}/member/join">회원가입</a></span>
			</div>			
			<a class="row text-muted mt-3 justify-content-center fs-small" href="${root}/member/check_email">이메일을 잊으셨나요?</a>
			<a class="row text-muted mt-2 justify-content-center fs-small" href="${root}/member/change_pw">비밀번호를 잊으셨나요?</a>	
		</div>
		<div class="col">
			<img src="${root}/image/login_bg.jpg" id="login-bg" />
		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
// 	$(function(){
// 		$("#message").hide();
		
// 		var memberEmail = $("#memberEmail").val();
// 		var memberPw = $("#memberPw").val();
		
// 		var ready = memberEmail != null && memberPw != null
		
// 		if (ready) {
// 			$("#submit").on("click", function(){
				


// 			})
// 		}
// 		else{
			
// 			if(memberEmail == null){
				
// 			}
			
// 			if(memberPw == null){
				
// 			}
			
// 		}


// 	});

</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>