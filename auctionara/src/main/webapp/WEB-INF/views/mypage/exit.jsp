<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>


<div class="container d-flex">
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
		<div class="alert alert-info text-center" role="alert">
			<h1>정말 저희와<br>
				헤어지실 건가요?
			</h1>
		</div>
		
		<div class="text-center m-2">
			<p>탈퇴를 원하신다면<br> 
				현재 비밀번호를 입력해주세요</p>
		</div>
	
		<div class="mb-5">

			<form action="exit" method="post">
				<div class="form-group">
					<label for="email">이메일 계정</label>
					<input type="email" name="memberEmail" value="${memberDto.memberEmail}" readonly id="email"
						class="form-control-plaintext">
				</div>
				<div class="mt-2">
					<label for="pw">비밀번호</label>
					<input type="password" name="memberPw" required placeholder="현재 비밀번호를 입력해주세요" id="pw"
						class="form-control form-control-lg mb-4">
				</div>
				<div class="mb-5">
					<button type="submit" class="btn btn-secondary btn-block">탈퇴하겠습니다</button>
				</div>
			</form>
		</div>
	
	
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
