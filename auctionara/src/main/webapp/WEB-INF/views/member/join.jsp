<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container-fluid">
	<div class="row mt-3">
		<div class="col-4 align-self-center mr-5">
			<h2 class="row fw-bold"><span class="border-bottom border-dark pb-4">회원가입</span></h2>
			<form action="join" method="post" enctype="multipart/form-data">
				<div class="row mt-4">프로필 사진</div>
				<div class="row mt-3">
					<label id="profile-label" class="position-relative">
	                    <img id="profile" class="rounded-circle" src="${root}/image/default_attachment.jpg"/>
	                    <input class="form-control d-none" type="file" name="attachment" accept=".png, .jpg, .gif"/>
	                    <a id="profile-hover" class="d-none rounded-circle position-absolute fw-bold text-white">선택</a>
	                </label>
				</div>			
				<div class="row mt-3">
					<label>이메일</label>
					<div class="input-group">
						<input type="email" name="memberEmail" autocomplete="off" placeholder="name@example.com" 
							class="email-input form-control" aria-describedby="email-btn" required>
						<input type="button" value="인증 메일 발송" class="btn-send-email btn btn-outline-info"
							id="email-btn" disabled>	
					</div>
					<div id="valid-email" class="text-success mt-1">인증 가능한 이메일입니다</div>
					<div id="email-exists" class="text-primary mt-1">이미 가입된 계정입니다</div>
					<div id="invalid-email" class="text-primary mt-1">잘못된 이메일 양식입니다</div>
				</div>	
				<div class="row mt-3">
					<label>인증번호</label>
					<div class="input-group">
						<input type="text" name="certNo" placeholder="인증번호를 입력해주세요" 
							class="cert-no form-control" aria-describedby="cert-btn" autocomplete="off" required>
						<input type="button" value="메일 인증 완료" class="btn-cert-check btn btn-outline-info" 
							id="cert-btn" autocomplete="off" disabled>
					</div>
				</div>
				<div class="row mt-3">
					<label>비밀번호</label>
					<div class="input-group">
						<input type="password" name="memberPw" placeholder="알파벳 대소문자 및 숫자 8~16자" 
							class="form-control" autocomplete="off" required>
					</div>
					<div id="valid-pw" class="text-success mt-1">사용 가능한 비밀번호입니다</div>
					<div id="invalid-pw" class="text-primary mt-1">잘못된 비밀번호 양식입니다</div>
				</div>
				<div class="row mt-3">
					<label>닉네임</label>
					<div class="input-group">		
						<input type="text" name="memberNick" autocomplete="off" placeholder="한글 2~10자" 
							class="form-control" aria-describedby="nick-btn" required>
						<input type="button" value="중복 검사하기" class="btn-send-nick btn btn-outline-info" 
							id="nick-btn" disabled>
					</div>
					<div id="valid-nick" class="text-success mt-1">사용 가능한 닉네임입니다</div>
					<div id="nick-exists" class="text-primary mt-1">이미 존재하는 닉네임입니다</div>
					<div id="invalid-nick" class="text-primary mt-1">잘못된 닉네임 양식입니다</div>					
				</div>
				<div class="row my-4 form-check">
					<label class="form-check-label" for="ck">
						<input type="checkbox" class="form-check-input" id="ck">
						<button type="button" value="open" class="btn modal-open">이용약관 확인</button>
					</label>
				</div>
				<div class="row">
					<button type="button" class="btn btn-primary btn-block mt-2" data-bs-toggle="modal" data-bs-target="#Modal">이용약관 확인</button>
				</div>		                	
				<div class="row">
					<button type="submit" id="submit" class="btn btn-primary btn-block mt-2">회원가입</button>
				</div>
				<div class="modal fade" id="Modal" aria-hidden="true" aria-labelledby="ModalLable" tabindex="-1">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="ModalLable">이용약관 확인</h5>
								<button type="button" class="btn-close close" data-bs-dismiss="modal">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
				        		본문
				      		</div>
				    	</div>
				  	</div>
				</div>				
			</form>
		</div>
		<div class="col">
			<img src="${root}/image/login_bg.jpg" id="login-bg" />
		</div>
	</div>	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

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
		$("#submit").attr("disabled", true);
		

		$(".modal-open").click(function(){
			$(".modal").modal({
				fadeDuration:300
			});
			event.preventDefault();
	        this.blur();
	        $(".modal").show();
			return false;
		});
		
		$(".modal-close").click(function(){
			$(".modal").hide();
			$("#ck").attr("checked", true);
			$("#submit").removeAttr("disabled");
		});
		
		$(".modal-close").click(function(){

		});
		

		
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
		
		
		// 프로필 사진 선택
		$("#profile-label").mouseover(function(){
			$("#profile-hover").removeClass("d-none");
		});
		$("#profile-label").mouseleave(function(){
			$("#profile-hover").addClass("d-none");
		});
		$("input[name=attachment]").change(function(){
			const url = URL.createObjectURL($("input[name=attachment]")[0].files[0]); 
			$("#profile").attr("src", url);
		});
		
	});
	
</script>
<style scoped>

	#profile {
		object-fit: cover;
	    width: 100px;
	    height: 100px;
	}
	
	#profile-hover {
		top: 0;
	    left: 0;
	    background-color: rgba(111, 117, 246, 0.6);
	    width: 100px;
	    height: 100px;
	    line-height: 100px;
	    text-align: center;
	    cursor: pointer;
	}
	
	.modal-body {
		height: 500px;
    	overflow: scroll;
	}

</style>