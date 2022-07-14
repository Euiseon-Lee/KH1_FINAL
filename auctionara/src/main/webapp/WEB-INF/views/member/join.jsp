<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/template/header.jsp" %>



<div class="container col-6 offset-3 form-group center-block">
	<form action="join" method="post" enctype="multipart/form-data">
	
		<div class="alert alert-info text-center" role="alert">
			<h1>회원 가입</h1>
		</div>
		
		<div class="row">
			<label> 이메일</label>
			<div class="input-group m-1">
				<input type="email" name="memberEmail" autocomplete="off" placeholder="name@example.com" 
					class="email-input form-control form-control-lg" aria-describedby="button-addon1" required>
				<input type="button" value="인증 메일 발송" class="btn-send-email btn-outline-info "
					id="button-addon1" disabled>
			</div>
			<div class="mb-3">
				<span id="valid-email" style="color:blue;">인증 가능한 이메일입니다</span>
				<span id="email-exists" style="color:#6F75F6">이미 가입된 계정입니다</span>
				<span id="invalid-email" style="color:red;">잘못된 이메일 양식입니다</span>
			</div>
		</div>
		
		<div class="row">
			<label>인증번호</label>
			<div class="input-group row center m-1 mb-3">
				<input type="text" name="certNo" placeholder="인증번호를 입력해주세요" 
					class="cert-no form-control form-control-lg" aria-describedby="button-addon2"  required>
				<input type="button" value="메일 인증 완료" class="btn-cert-check btn-outline-info" 
					id="button-addon2" disabled>
			</div>
		</div>
		
		<div class="row">
			<label> 비밀번호</label>
			<div class="input-group row center m-1">
				<input type="password" name="memberPw" placeholder="알파벳 대소문자 및 숫자 8~16자" 
					class="form-control form-control-lg" autocomplete="off" required>
			</div>
			<div class="mb-3">
				<span id="valid-pw" style="color:blue;">사용 가능한 비밀번호입니다</span>
				<span id="invalid-pw" style="color:red;">잘못된 비밀번호 양식입니다</span>
			</div>
		</div>
		
		<div class="row">
			<label> 닉네임</label>
			<div class="input-group row center m-1">		
				<input type="text" name="memberNick" autocomplete="off" placeholder="한글 2~10자" 
					class="form-control form-control-lg" aria-describedby="button-addon3"  required>
				<input type="button" value="중복 검사하기" class="btn-send-nick btn-outline-info btn-small" 
					id="button-addon3" disabled>	
			</div>

			<div class="mb-3">
				<span id="valid-nick" style="color:blue;">사용 가능한 닉네임입니다</span>
				<span id="nick-exists" style="color:#6F75F6">이미 존재하는 닉네임입니다</span>
				<span id="invalid-nick" style="color:red;">잘못된 닉네임 양식입니다</span>
			</div>		
		</div>
		
		<div class="row">
			<label>프로필</label>
			<div class="input-group row center m-1 mb-3">
	    		<input type="file" class="form-control form-control-lg" name="attachment">
		    </div>
		</div>
		
		<div class="row center m-2">
			<label>
				<input type="checkbox">전체 동의		
			</label>
		</div>
		
		<div class="row center m-2">
			<button type="submit" onkeydown="hitEnterkey(event);" class="btn-submit btn-primary btn-block btn-lg">회원가입</button>
		</div>

	</form>
</div>



<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){		
		
		$("#valid-email").hide();
		$("#invalid-email").hide();
		$("#email-exists").hide();
		$("#valid-nick").hide();
		$("#invalid-nick").hide();
		$("#nick-exists").hide();
		$("#valid-pw").hide();
		$("#invalid-pw").hide();
		
		
		$(".email-input").on("blur", function(){
			var regex = /^[\w\.]+@([\w]+\.)+[\w]{2,4}$/;
			var certTarget = $(".email-input").val();
			
			if(certTarget != ""){
				var judge = regex.test(certTarget);
				
				if(judge){
					
					$.ajax({
						url: "${pageContext.request.contextPath}/async/emailExists",
						type: "post",				
						data:{
							certTarget: certTarget
						},
						
						success: function(resp){
							if(resp == 0){
								$(".btn-send-email").attr("disabled", false);
								$("#valid-email").show();
							}
							
							else{
								$("#email-exists").show();
							}
						},
						
						
					});
					
				}
				
				else{
					$("#invalid-email").show();
				}
			}

		});
		
		$(".email-input").on("click", function(){
			$(".btn-send-email").attr("disabled", true);
			$("#valid-email").hide();
			$("#invalid-email").hide();
			$("#email-exists").hide();
			
			$(".email-input").val("");
		});
		
		
		$(".btn-send-email").click(function(){
		
			var certTarget = $(".email-input").val();
			
			$.ajax({
				url:"${pageContext.request.contextPath}/async/asyncSend",
				type: "post",
				data:{
					certTarget: certTarget
				},
				
				success:function(resp){
					$(".btn-send-email").attr("disabled", true);
					$(".email-input").prop('readonly', true);
					$(".btn-cert-check").attr("disabled", false);
					window.alert("인증 메일이 발송되었습니다. 메일함을 확인해주세요.");
				},
				
				error: function(){
					window.alert("인증 메일 전송에 실패하였습니다.");
				}
				
				
			});
			
			
		});
		
		
		
		
		$(".btn-cert-check").click(function(){
			var certTarget = $(".email-input").val();
			var certNo = $(".cert-no").val();
			
			$.ajax({
				url:"${pageContext.request.contextPath}/async/asyncCheck",
				type: "post",
				data:{
					certTarget: certTarget,
					certNo: certNo
				},
				
				success: function(resp){
					
					if(resp==true){
						$(".btn-cert-check").attr("disabled", true);
						$(".cert-no").prop('readonly', true);
						window.alert("메일 인증이 정상적으로 완료되었습니다.");						
					}
					
					else{
						window.alert("인증 번호가 일치하지 않습니다.");
					}

				},
				
				error: function(){

				}
				
			});
			
		});
		
		
		$("input[name=memberPw]").blur(function(){
			var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$/;
			var memberPw = $(this).val();
				
			if(memberPw != ""){
				var judge = regex.test(memberPw);
				
				if(judge){
					$("#valid-pw").show();
				}
				else{
					$("#invalid-pw").show();
				}
					
			}

		});
		
		
		$("input[name=memberPw]").click(function(){
			$("#valid-pw").hide();
			$("#invalid-pw").hide();
			
			$(this).val("");
		});
		
		
		
		
		
		$("input[name=memberNick]").blur(function(){
			var regex = /^[가-힣0-9]{2,10}$/;
			var memberNick = $(this).val();
			
			if(memberNick != ""){
				var judge = regex.test(memberNick);	
				
				if(judge){	
					$(".btn-send-nick").attr("disabled", false);	
				}
				else{
					$("#invalid-nick").show();
				}
			}
			
		});
		
		$("input[name=memberNick]").click(function(){
			$("#valid-nick").hide();
			$("#invalid-nick").hide();
			$("#nick-exists").hide();
			$(".btn-send-nick").attr("disabled", true);
			
			$(this).val("");
		});
		
		
		$(".btn-send-nick").click(function(){	
			var memberNick = $("input[name=memberNick]").val();
	
			$.ajax({
				url:"${pageContext.request.contextPath}/async/nickExists",
				type: "post",
				data:{
					memberNick: memberNick
				},
				success: function(resp){
					if(resp==true){
						$("#nick-exists").show();
					}
					
					else{
						$("#valid-nick").show();
					}
				},
				
			});
			
			
		});
		
		
	});
	
</script>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>