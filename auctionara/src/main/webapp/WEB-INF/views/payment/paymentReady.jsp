<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>
	<div>
		<div>
			<h1>${memberDto.memberNick }님의 현재 보유 포인트는 ${memberDto.memberHoldingPoints} P 입니다.</h1>
		</div>
		<div>
			충전은 결제 즉시 진행되며 1주일 이내에 포인트를 사용하지 않은 상태라면 결제 취소가 가능합니다.
		</div>
		
	</div>
    <div>
		<form action="charge" method="post">
			<input type="text" name="chargeMoney">
			<input type="submit" value="구매하기">
		</form>
    </div>
<%@include file="/WEB-INF/views/template/footer.jsp" %>