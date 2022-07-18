<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%@include file="/WEB-INF/views/template/header.jsp" %>

	<div>
		<div>
			${memberDto.memberNick }님의 현재 보유 보인트는 ${memberDto.memberHoldingPoints }P 입니다.
		</div>
		<div>
			현재 결제하여야 할 포인트는 ${bidDto.succFinalBid } P 입니다.
		</div>
		<div>
			포인트를 충전한 후 결제를 다시 시도해주세요.
		</div>
	</div>

    <div>
		<form action="charge" method="post">
			<input type="text" name="chargeMoney">
			<input type="submit" value="구매하기">
		</form>
    </div>


<%@include file="/WEB-INF/views/template/footer.jsp" %>
