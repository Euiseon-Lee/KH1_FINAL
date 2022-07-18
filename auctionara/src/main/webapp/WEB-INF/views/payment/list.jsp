<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="/WEB-INF/views/template/header.jsp" %>
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

<%@include file="/WEB-INF/views/template/footer.jsp" %>