<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>


<div class="container col-6 offset-3 form-group center-block">

	<div class="alert alert-info text-center" role="alert">
		<h1>비밀번호 재설정</h1>
	</div>

	<div>
	<form action="reset" method="post">
		<input type="hidden" name="memberEmail" value="${param.memberEmail}">
		<input type="hidden" name="newCertNo" value="${newCertNo}">
		
		<div class="row">
			<label>비밀번호</label>
			<div class="input-group row center m-1">
				<input type="password" name="memberPw" required placeholder="알파벳 대소문자 및 숫자 8~16자" 
					class="form-control form-control-lg" autocomplete="off" required>
			</div>
			<div class="mb-3">
				<span id="valid-pw" style="color:blue;">사용 가능한 비밀번호입니다</span>
				<span id="invalid-pw" style="color:red;">잘못된 비밀번호 양식입니다</span>
			</div>
		</div>
		
		<div class="row">
			<input type="submit" id="submit" value="비밀번호 변경" 
				class="btn-submit btn-primary btn-block btn-lg" disabled>
		</div>

	</form>
	</div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>




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