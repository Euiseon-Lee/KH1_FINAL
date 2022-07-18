<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
	<div class="nav flex-column text-center">
		<h1>총 충전 목록</h1>
<c:forEach var = "paymentInsertVO" items="${allList}">
	<div>
		<div>
			충전 금액: ${paymentInsertVO.paymentPrice } 원
		</div>
		<div>
			결제 시간: <fmt:formatDate value="${paymentInsertVO.paymentTime }" pattern="y년 M월 d일 E a h시 m분 s초"></fmt:formatDate>
		</div>
	</div>
	
</c:forEach>
<div>
	<h1>환불 가능 충전 목록</h1>
</div>
<div>
	<c:forEach var= "paymentInsertVOO" items="${refundList }">
		<div>
			충전 금액: ${paymentInsertVOO.paymentPrice} 원
			결제 시간: <fmt:formatDate value="${paymentInsertVOO.paymentTime }" pattern="y년 M월 d일 E a h시 m분 s초"></fmt:formatDate>
			<a href="${root}/payment/refund/${paymentInsertVOO.paymentNo}">취소하기</a>
		</div>
	</c:forEach>
	</div>
</div>

<%@include file="/WEB-INF/views/template/footer.jsp" %>