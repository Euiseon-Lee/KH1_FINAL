<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container-fluid">
	<div class="row mt-3">
		<div class="col-4 align-self-center mr-5">
			<h2 class="row fw-bold"><span class="border-bottom border-dark pb-4">비밀번호 재설정</span></h2>
			<form action="reset" method="post">
				<input type="hidden" name="memberEmail" value="${param.memberEmail}">
				<input type="hidden" name="newCertNo" value="${newCertNo}">
				<div class="row border-bottom mt-5">
					<input type="password" name="memberPw" class="form-control border-0" autocomplete="off" placeholder="알파벳 대소문자 및 숫자 8~16자" required>				
				</div>
				<div class="row">
					<p id="valid-pw" class="text-success mt-2">사용 가능한 비밀번호입니다</p>
					<p id="invalid-pw" class="text-primary mt-2">잘못된 비밀번호 양식입니다</p>
				</div>
				<div class="row mt-2">
					<button id="submit" type="submit" class="btn btn-primary btn-block" disabled>비밀번호 변경</button>	
				</div>	
			</form>
		</div>
		<div class="col">
			<img src="${root}/image/login_bg.jpg" id="login-bg" />
		</div>
	</div>	
</div>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){		
		
		$("#valid-pw").hide();
		$("#invalid-pw").hide();
		$("#submit").attr("disabled", true);
		

		$("input[name=memberPw]").click(function(){
			$("#valid-pw").hide();
			$("#invalid-pw").hide();
			$("#submit").attr("disabled", true);
			
			$(this).val("");
		});
		
		
		$("input[name=memberPw]").blur(function(){
			var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$/;
			var memberPw = $(this).val();
				
			if(memberPw != ""){
				var judge = regex.test(memberPw);
				
				if(judge){
					$("#valid-pw").show();
					$("#submit").attr("disabled", false);
				}
				else{
					$("#invalid-pw").show();
					$("#submit").attr("disabled", true);
				}
					
			}

		});

	});
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>