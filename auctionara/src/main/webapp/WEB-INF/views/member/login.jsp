<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="saveIdExists" value="${cookie.saveId != null}"></c:set>
<c:set var="autologinExists" value="${cookie.autologin != null}"></c:set>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container col-6 offset-3 form-group center-block">
	<div class="alert alert-info text-center" role="alert">
		<h1>경매나라:<br>
			우리 동네에서<br>
			간편한 중고 경매
		</h1>
	</div>

	<div>
	<form action="login" method="post">
	
		<div>
			<input type="email" name="memberEmail" id="memberEmail" value="${cookie.saveId.value}"
				class="form-control form-control-lg m-2" autocomplete="off" placeholder="name@example.com" >
		</div>
		
		<div>
			<input type="password" name="memberPw" 
				class="form-control form-control-lg m-2" autocomplete="off" placeholder="비밀번호를 입력해주세요">
		</div>

	
		<c:if test="${param.fail != null}">
			<div class="text-center mt-3 mb-3 alert alert-info" role="alert">
					<h5>로그인 정보가 일치하지 않습니다</h5>
			</div>	
		</c:if>


		
		<div class="mt-3 mb-2">
			<div class="float-left ml-5">
				<c:choose>
					<c:when test="${saveIdExists}">
						<input type="checkbox" name="remember" id="ck1" class="btn btn-outline-info" checked>
					</c:when>
					<c:otherwise>
						<input type="checkbox" name="remember" id="ck1" class="btn btn-outline-info">
					</c:otherwise>
				</c:choose>
				<label for="ck1">아이디 저장하기</label>		
			</div>
	
	
			<div class="float-right mr-5">
				<c:choose>
					<c:when test="${autologinExists}">
						<input type="checkbox" name="autologin" id="ck2" class="btn btn-outline-info" checked>
					</c:when>
					<c:otherwise>
						<input type="checkbox" name="autologin" id="ck2" class="btn btn-outline-info">
					</c:otherwise>
				</c:choose>
				<label for="ck2">자동 로그인 설정</label>	
			</div>
		</div>
		
		
		<div class="mt-3 m-2">
			<button type="submit" class="btn-submit btn-primary btn-block btn-lg" onkeydown="hitEnterkey(event);" id="submit">로그인</button>
		</div>	

	</form>	
	</div>


	
	<div class="mt-5 text-right">
		<div class="m-1">
			<a href="${root}/member/check_email" style="color: #6F75F6">이메일을 잊으셨나요?</a>
		</div>
		
		<div class="m-1">
			<a href="${root}/member/change_pw" style="color: #6F75F6">비밀번호를 잊으셨나요?</a>
		</div>
			
		<div class="m-1">
			<span><strong>아직 경매나라 계정이 없나요? </strong></span> &nbsp;&nbsp;
			<a href="${root}/member/join">회원가입</a>		
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