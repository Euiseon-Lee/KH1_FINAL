<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>


<div class="container d-flex">
<!-- 사이드바 -->

	<div class="row col-3 mt-3">
		<ul class="nav flex-column text-center">
		  <li class="nav-item border-bottom">
		  	<a href="${root}/mypage/index" class="nav-link btn-outline-dark fw-bold fs-large">마이페이지</a>
		  </li>
		  <li class="nav-item border-bottom">
		  	<a href="${root}/mypage/info" class="nav-link btn-outline-info">내 정보 수정</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/auction_history" class="nav-link btn-outline-info">내 경매</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/pay_history" class="nav-link btn-outline-info">내 입찰</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root}/payment/paymentReady" class="nav-link btn-outline-info">포인트 충전</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root }/payment/list" class="nav-link btn-outline-info">포인트 충전 취소</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root }/payment/cashing" class="nav-link btn-outline-info">현금화 신청</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root }/payment/cashingList" class="nav-link btn-outline-info">현금화 신청 목록</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/exit" class="nav-link btn-outline-secondary">회원 탈퇴</a>
		  </li>
		</ul>
	</div>
	
	
	<!-- 본문 -->
	<div class="row flex-fill d-flex flex-column">
		<h4 class="row fw-bold my-4 pt-2">회원 탈퇴</h4>
		<div class="alert alert-info text-center" role="alert">
			<h5>정말 저희와<br>
				헤어지실 건가요?
			</h5>
		</div>
		
		<div class="text-center m-2">

			<c:choose>
				<c:when test="${memberDto.memberHoldingPoints == 0}">
					<p>현재 보유 중인 포인트: ${memberDto.memberHoldingPoints}p</p>
				</c:when>
				<c:otherwise>
					<p>
						현재 보유 중인 포인트  
						<strong><a href="#">
						<i class="fa-solid fa-angles-right"></i> ${memberDto.memberHoldingPoints}p</a>
						</strong>
					</p>
					<p>보유포인트는 탈퇴 시 사라지며 복구가 불가능합니다<br>
						<strong>탈퇴하기 전에 반드시 현금화 신청을 해주세요</strong>
					</p>
				</c:otherwise>
			</c:choose>	
				
			<p></p>
				
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
						class="form-control mb-4">
				</div>
				<div class="mb-5">
					<button type="submit" class="btn btn-secondary btn-block py-2">탈퇴하겠습니다</button>
				</div>
			</form>
		</div>
	
	
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
