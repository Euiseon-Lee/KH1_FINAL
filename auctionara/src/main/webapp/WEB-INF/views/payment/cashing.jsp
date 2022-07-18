<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container d-flex">
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
			<a href="${root}/mypage/paymentReady" class="nav-link btn-outline-info">포인트 충전</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root }/mypage/payment/list" class="nav-link btn-outline-info">포인트 충전 취소</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root }/mypage/cashing" class="nav-link btn-outline-info">현금화 신청</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root }/mypage/cashingList" class="nav-link btn-outline-info">현금화 신청 목록</a>
		  </li>		  
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/exit" class="nav-link btn-outline-secondary">회원 탈퇴</a>
		  </li>
		</ul>
	</div>
	<div class="nav flex-column text-center">
		<div>
	<h1>${memberDto.memberNick }님의 현재 보유 포인트는 ${memberDto.memberHoldingPoints } P 입니다.</h1>
</div>
<c:set var="point" value="${memberDto.memberHoldingPoints}" />
<c:if test="${ point>0}">
	<div>
		현재 출금 가능한 포인트는 ${memberDto.memberHoldingPoints } P 입니다.
		
		<form action="${root }/payment/cashingRequest" method="post" enctype="multipart/form-data">
			<div>
				<div>
					현금화할 포인트
				</div>
				<div>
					<input type="number" name="cashingMoney">			
				</div>
			</div>
			<div>
				<div>
					입금 은행명
				</div>
				<div>
					<input type="text" name="cashingBank">
				</div>
			</div>
			<div>
				<div>
					입금 계좌번호
				</div>
				<div>
					<input type="number" name="cashingAccount">
				</div>
			</div>
			<div>
				<input type="submit" class="btn" value="신청하기">
			</div>
		</form>
	</div>

</c:if>
	</div>
</div>

<%@include file="/WEB-INF/views/template/footer.jsp" %>