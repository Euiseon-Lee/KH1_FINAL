<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	<div class="row flex-fill d-flex flex-column">
		<div class="col">
			<div class="row fw-bold my-4 pt-2">
				<h1>${memberDto.memberNick }님의 현재 보유 포인트는 ${memberDto.memberHoldingPoints} P 입니다.</h1>
			</div>
			<div>
				충전은 결제 즉시 진행되며 1주일 이내에 포인트를 사용하지 않은 상태라면 결제 취소가 가능합니다.
			</div>
		</div>
	    <div class="col-5 d-flex justify-content-end"">
			<form action="${root }/payment/charge" method="post">
				<input type="text" name="chargeMoney">
				<input type="submit" value="구매하기" class="btn">
			</form>
   		</div>
	</div>
</div>
<%@include file="/WEB-INF/views/template/footer.jsp" %>