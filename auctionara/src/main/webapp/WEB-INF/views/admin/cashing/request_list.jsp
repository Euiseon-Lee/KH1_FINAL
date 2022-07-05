<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1>테스트</h1>
<div>
	<table>
		<thead>
			<tr>
				<th>신청 번호</th>
				<th>회원 이름</th>
				<th>신청 금액</th>
				<th>신청 은행</th>
				<th>신청 계좌번호</th>
				<th>현금화 유형</th>
				<th>현금화 상태</th>
				<th>현금화 신청시간</th>
				<th>현금화 완료시간</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="cashingPointsVO" items="${requestList}">
				<tr>
					<td>${cashingPointsVO.cashingNo}</td>
					<td>${cashingPointsVO.memberName}</td>
					<td>${cashingPointsVO.cashingMoney}</td>
					<td>${cashingPointsVO.cashingBank}</td>
					<td>${cashingPointsVO.cashingAccount}</td>
					<td>${cashingPointsVO.cashingType}</td>
					<td>${cashingPointsVO.cashingStatus}</td>
					<td>${cashingPointsVO.cashingRequestTime}</td>
					<td>${cashingPointsVO.cashingSuccessTime}</td>
					<td><a href="approve/${cashingPointsVO.cashingNo}">승인</a>|<a href="refuse/${cashingPointsVO.cashingNo}">거절</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>