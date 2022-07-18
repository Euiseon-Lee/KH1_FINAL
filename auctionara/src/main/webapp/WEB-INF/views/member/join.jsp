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
						<button type="button" class="btn btn-primary btn-block mt-2" data-bs-toggle="modal" data-bs-target="#Modal">이용약관 확인</button>
					</label>
				</div>	                	
				<div class="row">
					<button type="submit" id="submit" class="btn btn-primary btn-block mt-2">회원가입</button>
				</div>
				<div class="modal fade" id="Modal" aria-hidden="true" aria-labelledby="ModalLable" tabindex="-1">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="ModalLable">이용약관</h5>
								<div>	
									<button type="button" class="btn-close close btn-info" data-bs-dismiss="modal">
									<span aria-hidden="true">모두 동의합니다</span>
									</button>
								</div>
							</div>
							<div class="modal-body">

				        		<div class="modal-div">
				        			<h4>개인정보처리방침</h4>
				        			<p>
				        			<strong>1. 개인정보처리방침의 의의</strong><br>
									경매나라는 본 개인정보처리방침은 개인정보보호법을 기준으로 작성하되, 경매나라 내에서의 이용자 개인정보 처리 현황을 최대한 알기 쉽고 상세하게 설명하기 위해 노력하였습니다.<br><br>
									이는 쉬운 용어를 사용한 개인정보처리방침 작성 원칙인 ‘Plain Language Privacy Policy(쉬운 용어를 사용한 개인정보처리방침)’를 도입한 것입니다.<br><br>
									개인정보처리방침은 다음과 같은 중요한 의미를 가지고 있습니다.<br>
									경매나라가 어떤 정보를 수집하고, 수집한 정보를 어떻게 사용하며, 필요에 따라 누구와 이를 공유(‘위탁 또는 제공’)하며, 이용목적을 달성한 정보를 언제·어떻게 파기하는지 등 ‘개인정보의 한살이’와 관련한 정보를 투명하게 제공합니다.<br>
									정보주체로서 이용자는 자신의 개인정보에 대해 어떤 권리를 가지고 있으며, 이를 어떤 방법과 절차로 행사할 수 있는지를 알려드립니다.<br>
									개인정보 침해사고가 발생하는 경우, 추가적인 피해를 예방하고 이미 발생한 피해를 복구하기 위해 누구에게 연락하여 어떤 도움을 받을 수 있는지 알려드립니다.<br>
									그 무엇보다도, 개인정보와 관련하여 경매나라와 이용자간의 권리 및 의무 관계를 규정하여 이용자의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.<br>
				        			</p>
				        			<p>
									<strong>2. 수집하는 개인정보</strong><br>
									이용자는 회원가입을 하지 않을 시 전체 서비스 이용이 불가능합니다.<br>
									경매나라는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.<br>
									회원 가입 시에 경매나라는 ‘이메일, 비밀번호, 닉네임’를 필수항목으로 수집합니다.<br><br>
									
									서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.<br>									
									회원정보 또는 개별 서비스에서 프로필 정보(별명, 프로필 사진)를 설정할 수 있습니다. 회원정보에 별명을 입력하지 않은 경우에는 마스킹 처리된 아이디가 별명으로 자동 입력됩니다.<br>
									경매나라 내의 개별 서비스 이용, 이벤트 응모 및 경품 신청 과정에서 해당 서비스의 이용자에 한해 추가 개인정보 수집이 발생할 수 있습니다. 추가로 개인정보를 수집할 경우에는 해당 개인정보 수집 시점에서 이용자에게 ‘수집하는 개인정보 항목, 개인정보의 수집 및 이용목적, 개인정보의 보관기간’에 대해 안내 드리고 동의를 받습니다.<br>
									이용자 동의 후 개인정보를 추가 수집하는 경우‘개인정보 이용내역(내 정보)’ 확인하기<br>
									서비스 이용 과정에서 IP 주소, 쿠키, 서비스 이용 기록, 위치정보가 생성되어 수집될 수 있습니다.<br>
									<br>
									구체적으로 1) 서비스 이용 과정에서 이용자에 관한 정보를 자동화된 방법으로 생성하여 이를 저장(수집)하거나, 2) 이용자 기기의 고유한 정보를 원래의 값을 확인하지 못 하도록 안전하게 변환하여 수집합니다. 서비스 이용 과정에서 위치정보가 수집될 수 있으며, 경매나라에서 제공하는 위치기반 서비스에 대해서는 '경매나라 위치정보 이용약관'에서 자세하게 규정하고 있습니다.
									이와 같이 수집된 정보는 개인정보와의 연계 여부 등에 따라 개인정보에 해당할 수 있고, 개인정보에 해당하지 않을 수도 있습니다.<br>
									<br>
									경매나라는 아래의 방법을 통해 개인정보를 수집합니다.
									<br><br>
									회원가입 및 서비스 이용 과정에서 이용자가 개인정보 수집에 대해 동의를 하고 직접 정보를 입력하는 경우, 해당 개인정보를 수집합니다.<br>
									고객센터를 통한 상담 과정에서 웹페이지, 메일, 팩스, 전화 등을 통해 이용자의 개인정보가 수집될 수 있습니다.<br>
									오프라인에서 진행되는 이벤트, 세미나 등에서 서면을 통해 개인정보가 수집될 수 있습니다.<br>
									경매나라와 제휴한 외부 기업이나 단체로부터 개인정보를 제공받을 수 있으며, 이러한 경우에는 개인정보보호법에 따라 제휴사에서 이용자에게 개인정보 제공 동의 등을 받은 후에 경매나라에 제공합니다.<br>
									기기정보와 같은 생성정보는 PC웹, 모바일 웹/앱 이용 과정에서 자동으로 생성되어 수집될 수 있습니다.<br>
				        			</p>
				        			<p>
									<strong>3. 수집한 개인정보의 이용</strong><br>
									경매나라 및 경매나라 관련 제반 서비스(모바일 웹/앱 포함)의 회원관리, 서비스 개발·제공 및 향상, 안전한 인터넷 이용환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.<br><br>
									
									회원 가입 의사의 확인, 연령 확인 및 법정대리인 동의 진행, 이용자 및 법정대리인의 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.<br>
									콘텐츠 등 기존 서비스 제공(광고 포함)에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 이용자간 관계의 형성, 지인 및 관심사 등에 기반한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용합니다.<br>
									법령 및 경매나라 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.<br>
									유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제, 서비스의 이용을 위하여 개인정보를 이용합니다.<br>
									이벤트 정보 및 참여기회 제공, 광고성 정보 제공 등 마케팅 및 프로모션 목적으로 개인정보를 이용합니다.<br>
									서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.<br>
									보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.<br>
				        			</p>
				        			<p>
				        			<strong>4. 개인정보의 제공 및 위탁</strong><br>
									경매나라는 원칙적으로 이용자 동의 없이 개인정보를 외부에 제공하지 않습니다.<br>
									경매나라는 이용자의 사전 동의 없이 개인정보를 외부에 제공하지 않습니다. <br>
									단, 이용자가 외부 제휴사의 서비스를 이용하기 위하여 개인정보 제공에 직접 동의를 한 경우, 그리고 관련 법령에 의거해 경매나라에 개인정보 제출 의무가 발생한 경우, 이용자의 생명이나 안전에 급박한 위험이 확인되어 이를 해소하기 위한 경우에 한하여 개인정보를 제공하고 있습니다.
				        			</p>
				        			<p>
				        			<strong>5. 개인정보의 파기</strong><br>
									회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기하고 있습니다.<br>
									단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.<br>
									<br><br>
									회원탈퇴, 서비스 종료, 이용자에게 동의받은 개인정보 보유기간의 도래와 같이 개인정보의 수집 및 이용목적이 달성된 개인정보는 재생이 불가능한 방법으로 파기하고 있습니다.<br>
									법령에서 보존의무를 부과한 정보에 대해서도 해당 기간 경과 후 지체없이 재생이 불가능한 방법으로 파기합니다.
				        			
				        			</p>
				        		</div>
				        		<div class="modal-div mt-5">
				        			<h4>위치기반서비스 이용약관</h4>
				        			<p>
									<strong>제1조 (목적)</strong><br>
									본 약관은 회원(본 약관에 동의한 자를 말합니다. 이하 “회원”이라고 합니다)이 주식회사 경매나라(이하 “회사”라고 합니다)가 제공하는 위치기반서비스(이하 “서비스”라고 합니다)를 이용함에 있어 회사와 회원의 권리・의무 및 책임사항을 규정함을 목적으로 합니다.
				        			</p>
				        			<p>
				        			<strong>제2조 (약관의 효력 및 변경)</strong><br>
									본 약관은 서비스를 신청한 고객 또는 개인위치정보주체가 본 약관에 동의하고 회사가 정한 소정의 절차에 따라 서비스의 이용자로 등록함으로써 효력이 발생합니다.<br>
									회사는 본 약관의 내용을 회원이 쉽게 알 수 있도록 서비스 초기 화면에 게시하거나 기타의 방법으로 공지합니다.<br>
									회사는 필요하다고 인정되면 본 약관을 변경할 수 있으며, 회사가 약관을 개정할 경우에는 기존약관과 개정약관 및 개정약관의 적용일자와 개정사유를 명시하여 현행약관과 함께 그 적용일자 7일 전부터 적용일 이후 상당한 기간 동안 공지합니다. 다만, 개정 내용이 회원에게 불리한 경우에는 그 적용일자 30일 전부터 적용일 이후 상당한 기간 동안 각각 이를 서비스 홈페이지에 게시하여 고지합니다.<br>
									회사가 전항에 따라 회원에게 공지하거나 통지하면서 공지 또는 통지ㆍ고지일로부터 개정약관 시행일 7일 후까지 거부의사를 표시하지 아니하면 승인한 것으로 본다는 뜻을 명확하게 고지하였음에도 불구하고 거부의 의사표시가 없는 경우에는 변경된 약관에 승인한 것으로 봅니다. 회원이 개정약관에 동의하지 않을 경우 회원은 이용계약을 해지할 수 있습니다.<br>
				        			</p>
				        			<p>
				        			<strong>제3조 (약관 외 준칙)</strong><br>	
									본 약관에 규정되지 않은 사항에 대해서는 위치정보의 보호 및 이용 등에 관한 법률(이하 “위치정보법”이라고 합니다), 전기통신사업법, 정보통신망 이용촉진 및 보호 등에 관한 법률(이하 “정보통신망법”이라고 합니다), 개인정보보호법 등 관련법령 또는 회사가 정한 서비스의 운영정책 및 규칙 등(이하 “세부지침”이라고 합니다)의 규정에 따릅니다.
				        			</p>
				        			<p>
				        			<strong>제4조 (서비스의 가입)</strong><br>
									본회사는 아래와 같은 경우에는 여러분의 경매나라 계정 생성을 유보할 수 있습니다.<br>
									실제 이메일이 아니거나 다른 사람의 명의를 사용하는 등 허위로 신청하는 경우<br>
									회원 등록 사항을 빠뜨리거나 잘못 기재하여 신청하는 경우<br>
									기타 회사가 정한 이용신청 요건을 충족하지 않았을 경우<br>
				        			</p>
				        			<p>
				        			<strong>제5조 (서비스의 해지)</strong><br>
									회원이 서비스 이용을 해지하고자 할 경우 회원은 회사가 정한 절차(서비스 홈페이지 등을 통해 공지합니다)를 통해 서비스 해지를 신청할 수 있으며, 회사는 법령이 정하는 바에 따라 신속히 처리합니다.
				        			</p>
				        		</div>
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
		

// 		$(".modal-open").click(function(){
// 			$(".modal").modal({
// 				fadeDuration:300
// 			});
// 			event.preventDefault();
// 	        this.blur();
// 	        $(".modal").show();
// 			return false;
// 		});
		
		$(".btn-close").click(function(){
// 			$(".modal").hide();
			$("#ck").attr("checked", true);
			$("#submit").removeAttr("disabled");
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
	
	.modal-div	{
		height: 230px;
		overflow: scroll;
	}

</style>