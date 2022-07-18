<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/views/template/header.jsp" %>
<div>
	<h1>${memberDto.memberNick }님의 현재 보유 포인트는 ${memberDto.memberHoldingPoints } P 입니다.</h1>
</div>
<c:set var="point" value="${memberDto.memberHoldingPoints}" />
<c:if test="${ point>0}">
	<div>
		현재 출금 가능한 포인트는 ${memberDto.memberHoldingPoints } P 입니다.
		
		<form action="cashingRequest" method="post" enctype="multipart/form-data">
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
<%@include file="/WEB-INF/views/template/footer.jsp" %>