<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="/WEB-INF/views/template/header.jsp" %>
<div>
	<h1> ${memberDto.memberNick }님의 출금 신청 목록</h1>
</div>
<div>
	<table  width="100%">
		<tr align = "center" bgcolor="white">
			<th>출금 신청 일시</th>
			<th>출금 신청 은행</th>
			<th>출금 신청 계좌</th>
			<th>출금 진행 상태</th>
			<th>출금 완료 일시</th>
		</tr>
		<c:forEach var = "list" items="${cashingList}">
			<tr align = "center" bgcolor="white">
				<td><fmt:formatDate value="${list.cashingRequestTime }" pattern="y년 M월 d일 E a h시 m분 s초"></fmt:formatDate></td>
				<td>${list.cashingBank }</td>
				<td>${list.cashingAccount }</td>
				<td>${list.cashingStatus }</td>
				<td><fmt:formatDate value="${list.cashingSuccessTime }" pattern="y년 M월 d일 E a h시 m분 s초"></fmt:formatDate></td>
			</tr>
		</c:forEach>
	</table>
</div>

<%@include file="/WEB-INF/views/template/footer.jsp" %>