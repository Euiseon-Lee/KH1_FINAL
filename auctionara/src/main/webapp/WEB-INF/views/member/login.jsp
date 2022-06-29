<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container-fluid">
	<div class="row">
		<h1>점보트론:<br>
			우리 동네에서<br>
			간편한 중고 경매</h1>
	</div>

	<form action="login" method="post">
		<div class="row">
			<div>
				<label>이메일
					<input type="email" name="memberEmail" autocomplete="off" placeholder="email">
				</label>
			</div>
			
			<div>
				<label>비밀번호
					<input type="password" name="memberPw" autocomplete="off" placeholder="password">
				</label>
			</div>
			
			<div>
				<div>
					<label>
							<input type="checkbox">	
					</label> 이메일 기억하기		
				</div>

				<div>
					<label>
							<input type="checkbox">	
					</label> 자동 로그인 설정
				</div>
			</div>
	
			<div>
				<button type="submit">로그인</button>
			</div>	
		</div>
	</form>	
	
	<div class="row">
		<div>
			<a href="${root}/member/find_email">이메일을 잊으셨나요?</a>
		</div>
	
		<div>
			<a href="${root}/member/find_pw">비밀번호를 잊으셨나요?</a>
		</div>	
	</div>










</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>