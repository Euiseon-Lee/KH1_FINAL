<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/template/header.jsp" %>




<form action="join" method="post" enctype="multipart/form-data">
	
	<div class="container-fluid col-lg-6 offset-lg-3 col-md-8 offset-md-2">
	
		<div class="row jumbotron jumbotron-fluid">
			<h1>회원 가입</h1>
		</div>
		
		<div class="row">
			<div>
				<label> 이메일
					<input type="email" name="memberEmail" autocomplete="off" placeholder="email" class="email-input">
				</label>
				<div>
					<span id="valid-email">인증 가능한 이메일입니다</span>
					<span id="email-exists" style="color:blue;">이미 가입된 계정입니다</span>
					<span id="invalid-email" style="color:red;">잘못된 이메일 양식입니다</span>
				</div>
			</div>
			<div>
				<input type="button" value="인증메일 발송"class="btn-send-email" disabled>
			</div>
		</div>
		
		<div class="row">
			<div>
				<label> 인증번호
					<input type="text" name="certNo" placeholder="certNumber" class="cert-no" required>
				</label>
			</div>
			<div>
				<input type="button" value="인증하기" class="btn-cert-check" disabled>
			</div>
		</div>
		
		<div class="row">
			<div>
				<label> 비밀번호
					<input type="password" name="memberPw" autocomplete="off" placeholder="password" required>
				</label>
			</div>

		</div>
		
		<div class="row">
			<label> 이름
				<input type="text" name="memberName" autocomplete="off" placeholder="name" required>
			</label>
		</div>		

		<div class="row">
			<label> 성별
				<select name="memberSex" required>
					<option selected>==선택==</option>
					<option value="f">여자</option>
					<option value="m">남자</option>
				</select>
			</label>
		</div>	

		<div class="row">
			<label> 생년월일
				<select name="yy" id="year" required></select>
				<select name="mm" id="month" required></select>
				<select name="dd" id="day" required></select>
			</label>
		</div>
		
		<div class="row">
			<label> 닉네임
				<input type="text" name="memberNick" autocomplete="off" placeholder="nickname" required>
			</label>
			<span id="valid-nick">사용 가능한 닉네임입니다</span>
			<span id="nick-exists" style="color:blue;">이미 존재하는 닉네임입니다</span>
			<span id="invalid-nick" style="color:red;">잘못된 닉네임 양식입니다</span>
			<div>
				<input type="button" value="닉네임 중복 검사"class="btn-send-nick" disabled>
			</div>			
		</div>
		
		<div class="row">
	    	<label>프로필
	    		<input type="file" name="attachment">
	    	</label>
	    </div>
		
		<div class="row">
			<label>
				<input type="checkbox">전체 동의		
			</label>
		</div>
		
		<div class="row">
			<button type="submit" onkeydown="hitEnterkey(event);" class="btn-submit">회원가입</button>
		</div>
	
	</div>

</form>




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
		
		
		$(".email-input").on("blur", function(){
			var regex = /^[\w\.]+@([\w]+\.)+[\w]{2,4}$/;
			var certTarget = $(".email-input").val();
				
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
// 							window.alert("이미 있는 계정입니다");
						}
					},
					
// 					error: function(){}
					
				});
				
			}
			
			else{
				$("#invalid-email").show();
// 				window.alert("이메일 양식을 지켜서 입력해주세요");
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
				
				error:function(){
					window.alert("인증 메일 전송에 실패하였습니다.");
				},
				
			});
			
			
		});
		
		
		
		
		$(".btn-cert-check").click(function(){
			var certTarget = $(".email-input").val();
			var certNo = $(".cert-no").val();
			
			$.ajax({
				url:"${pageContext.request.contextPath}/async/emailExists",
				type: "post",
				data:{
					certTarget: certTarget,
					certNo: certNo
				},
				
				success: function(resp){
					$(".btn-cert-check").attr("disabled", true);
					$(".cert-no").prop('readonly', true);
					window.alert("메일 인증이 정상적으로 완료되었습니다.");
				},
				
				error: function(){
					window.alert("인증 번호가 일치하지 않습니다.");
				}
				
			});
			
		});
		
		
		
		$("input[name=memberNick]").blur(function(){
			var regex = /^[가-힣0-9]{2,10}$/;
			var memberNick = $(this).val();
			
			var judge = regex.test(memberNick);
			
			if(judge){
				
				$(".btn-send-nick").attr("disabled", false);
				
			}
			else{
				$("#invalid-nick").show();
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


<script>
	$(document).ready(function(){            
	    var now = new Date();
	    var year = now.getFullYear();
	    var mon = (now.getMonth() + 1) > 9 ? ''+(now.getMonth() + 1) : '0'+(now.getMonth() + 1); 
	    var day = (now.getDate()) > 9 ? ''+(now.getDate()) : '0'+(now.getDate());           
	    // 연도 selectbox             
	    for(var i = 1900 ; i <= year ; i++) {
	        $('#year').append('<option value="' + i + '">' + i + '년</option>');    
	    }
	
	    // 월별 selectbox          
	    for(var i=1; i <= 12; i++) {
	        var mm = i > 9 ? i : "0"+i ;            
	        $('#month').append('<option value="' + mm + '">' + mm + '월</option>');    
	    }
	    
	    // 일별 selectbox
	    for(var i=1; i <= 31; i++) {
	        var dd = i > 9 ? i : "0"+i ;            
	        $('#day').append('<option value="' + dd + '">' + dd+ '일</option>');    
	    }
	    $("#year > option[value="+year+"]").attr("selected", "true");        
	    $("#month > option[value="+mon+"]").attr("selected", "true");    
	    $("#day > option[value="+day+"]").attr("selected", "true");       
	  
	})
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
