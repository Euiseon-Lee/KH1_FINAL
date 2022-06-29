<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div>
	<div>
		<h1>점보트론:우리 동네에서</h1><br>
		<h1>간편한 중고 경매</h1>
	</div>

	<form action="login" method="post">
		<div>
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
			
			</div>
	
			<div>
				<button type="submit">로그인</button>
			</div>	
		</div>
	</form>	
	
	<div>
		<div>
			<a href="">이메일을 잊으셨나요?</a>
		</div>
	
		<div>
			<a href="">비밀번호를 잊으셨나요?</a>
		</div>	
	</div>










</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>