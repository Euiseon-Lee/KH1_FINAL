<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/template/header.jsp" %>

<form action="join" method="post">
	
	<div>
	
		<div>
			<h1>점보트론: 회원 가입</h1>
		</div>
		
		<div>
			<div>
				<label> 이메일
					<input type="email" name="memberEmail" autocomplete="off" placeholder="email">
				</label>
			</div>
			<div>
				<button>인증하기</button>
			</div>
		</div>
		
		<div>
			<div>
				<label> 비밀번호
					<input type="password" name="memberPw" autocomplete="off" placeholder="password">
				</label>
			</div>
			<div>
				<label> 비밀번호 확인
					<input type="password" name="memberPwCheck" autocomplete="off" placeholder="pwCheck">
				</label>
			</div>

		</div>
		
		<div>
			<label> 닉네임
				<input type="text" name="memberNick" autocomplete="off" placeholder="nickname">
			</label>
		</div>
		
		<div>
	    	<label>프로필
	    		<input type="file" name="attachmentNo">
	    	</label>
	    </div>
		
		<div>
			<label>
				<input type="checkbox">전체 동의		
			</label>
		</div>
		
		<div>
			<button type="submit">회원가입</button>
		</div>
	
	</div>

</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
