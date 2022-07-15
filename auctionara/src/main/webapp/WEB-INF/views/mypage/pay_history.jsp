<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>


<div class="container d-flex">
<!-- 사이드바 -->

	<div class="row col-3 mt-4">
		<ul class="nav flex-column text-center">
		  <li class="nav-item border-bottom">
		  	<h4>
		  		<a href="${root}/mypage/index" class="nav-link btn-outline-secondary">마이페이지</a>
		  	</h4>
		  </li>
		  <li class="nav-item border-bottom">
		  	<a href="${root}/mypage/info" class="nav-link btn-outline-info">정보수정</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/exit" class="nav-link btn-outline-info">회원탈퇴</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/auction_history" class="nav-link btn-outline-info">경매내역</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/pay_history" class="nav-link btn-outline-info">결제완료내역</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/cash_log" class="nav-link btn-outline-info">포인트/현금화</a>
		  </li>
		</ul>
	</div>

	<!-- 본문 -->
	<div class="row flex-fill d-flex flex-column">
		<div class="row m-2 p-2">
			<button type="button" class="btn btn-info">포인트 충전</button>
		</div>
	
		<div class="row m-2 p-2">
			<button type="button" class="btn btn-info">현금화 신청</button>
		</div>
		
		<div>
		</div>
	
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>