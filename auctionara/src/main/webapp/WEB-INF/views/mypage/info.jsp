<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>


<div class="container d-flex" >
<!-- 사이드바 -->

	<div class="row col-3 mt-4">
		<ul class="nav flex-column text-center">
		  <li class="nav-item border-bottom">
		  	<h4>
		  		<a href="${root}/mypage/index" class="nav-link btn-outline-dark">마이페이지</a>
		  	</h4>
		  </li>
		  <li class="nav-item border-bottom">
		  	<a href="${root}/mypage/info" class="nav-link btn-outline-info">정보수정</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/auction_history" class="nav-link btn-outline-info">경매내역</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/pay_history" class="nav-link btn-outline-info">입찰/낙찰내역</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/cash_log" class="nav-link btn-outline-info">포인트/현금화</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/exit" class="nav-link btn-outline-secondary">회원탈퇴</a>
		  </li>
		</ul>
	</div>
	
	
	<!-- 본문 -->
	<div class="row flex-fill d-flex flex-column">
		<h4 class="row fw-bold my-4 pt-2">내 정보 수정</h4>
		
		<form action="info" method="post" enctype="multipart/form-data">
			<div class="row mt-4">프로필 사진</div>
			<div class="input-group row center m-1 mb-3">
				<label id="profile-label" class="position-relative">
                    <img id="profile" class="rounded-circle" src="${pageContext.request.contextPath}${profileUrl}"/>
                    <input class="form-control d-none" type="file" name="attachment" accept=".png, .jpg, .gif"/>
                    <a id="profile-hover" class="d-none rounded-circle position-absolute fw-bold text-white">프로필 변경</a>
                </label>
			</div>
			
			<div class="row">
				<label> 이메일</label>
				<div class="input-group m-1">
					<input type="email" name="memberEmail" value="${memberDto.memberEmail}" aria-describedby="button-addon1" 
						class="email-input form-control-lg form-control-plaintext" readonly>
					<input type="button" value="인증이 완료되었습니다" class="btn-send-email btn-outline-info" id="button-addon1" disabled>
				</div>
			</div>
			
			<div class="row">			
				<div>
					<label>거래선호시간</label>					
					<div class="input-group row center m-1 mb-3">
					<select class="form-control" id="week" name="week" required>
						<option value="" selected>선택해주세요</option>
						<option value="요일무관">요일무관</option>
						<option value="평일">평일</option>
						<option value="주말">주말</option>
					</select>
					<div>&nbsp;&nbsp;</div>
					<select class="form-control" id="begin" name="begin" required>
						<option value="" selected>선택해주세요</option>
					</select>
					<div>부터&nbsp;&nbsp;</div>
					<select class="form-control" id="end" name="end" required>
						<option value="" selected>선택해주세요</option>
					</select>
					<div>까지</div>
					</div>
				</div>
			</div>
			<div class="row float-right">
				<strong>현재 설정된 거래 선호 시간: ${memberDto.memberPreference}</strong>
			</div>
			
			<div class="row mt-5">
				<label> 비밀번호</label>
				<div class="input-group row center m-1">
					<input type="button" value="비밀번호 재설정을 위한 링크를 메일 발송해드립니다" class="form-control-lg btn-send-email btn-info">
				</div>
			</div>
			
			<div class="row">
				<label> 닉네임</label>
				<div class="input-group row center m-1">		
					<input type="text" name="memberNick" value="${memberDto.memberNick}" placeholder="한글 2~10자" 
						class="form-control form-control-lg" aria-describedby="button-addon2"  required>
<!-- 					<input type="button" value="닉네임 재설정" class="btn-send-nick btn-outline-info btn-small"  -->
<!-- 						id="button-addon2" disabled>	 -->
				</div>
	
				<div class="mb-2">
					<span id="valid-nick" style="color:blue;">사용 가능한 닉네임입니다</span>
					<span id="nick-exists" style="color:#6F75F6">이미 존재하는 닉네임입니다</span>
					<span id="invalid-nick" style="color:red;">잘못된 닉네임 양식입니다</span>
				</div>		
			</div>
			
			<div class="mt-3">
				<button type="submit" onkeydown="hitEnterkey(event);" class="btn-submit btn-primary btn-block btn-lg">정보수정하기</button>
			</div>

			
	
		</form>
	
	</div>
	
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function(){
		for (i = 0; i < 24; i++) {
		    var hour = "시";
		    
		    hour = (Math.floor(i));
		    
	        if(hour < 12){
	        	hour = "오전 "+hour+"시";
	        }
	        else if(hour==12){
	        	hour = "정오 "+hour+"시";
	        }
	        else{
	        	hour = "오후 "+(hour-12)+"시";
	        } 

			//document.write("<option value=" + hour + min + ">" + hour + min + "</option>");
			$("<option>").val(hour).text(hour).appendTo("select[name=begin]");
			$("<option>").val(hour).text(hour).appendTo("select[name=end]");
		}
		
		
		$("#valid-nick").hide();
		$("#invalid-nick").hide();
		$("#nick-exists").hide();
		
		
		$(".btn-send-email").click(function(){
			var memberEmail = $(".email-input").val();

			$.ajax({
				url:"${pageContext.request.contextPath}/async/asyncPw",
				type: "post",
				data:{
					memberEmail: memberEmail
				},
				
				success:function(resp){					
					window.alert("비밀번호 재설정 메일이 발송되었습니다. 메일함을 확인해주세요.");
				},
				
				error: function(){
					window.alert("비밀번호 재설정 메일 전송에 실패하였습니다.");
				}
			});
		});
		
		
		$("input[name=memberNick]").change(function(){
			var regex = /^[가-힣0-9]{2,10}$/;
			var memberNick = $(this).val();
			
			if(memberNick != ""){
				var judge = regex.test(memberNick);	
				
				if(judge){
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
			
			$(this).val("");
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
	    width: 250px;
	    height: 250px;
	}
	
	#profile-hover {
		top: 0;
	    left: 0;
	    background-color: rgba(111, 117, 246, 0.6);
	    width: 250px;
	    height: 250px;
	    line-height: 250px;
	    text-align: center;
	    cursor: pointer;
	}

</style>