<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/template/header.jsp" %>
<div>
	<H1>결제가 완료되었습니다.</H1>
</div>
<div>
	<h2>충전한 포인트는 ${success.paymentPrice } 입니다.</h2>
</div>
<div>
	<h2>현재 보유 포인트는 ${success.memberHoldingPoints } P 입니다.</h2>
</div>

<a href="${root}/mypage/list">충전 내역 보기</a>
<%@include file="/WEB-INF/views/template/footer.jsp" %>