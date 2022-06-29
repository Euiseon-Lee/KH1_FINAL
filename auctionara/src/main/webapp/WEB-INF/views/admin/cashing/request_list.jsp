<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<div>
	<table>
		<thead>
			<tr>
				<th>신청 번호</th>
				<th>회원 번호</th>
				<th>신청 금액</th>
				<th>신청 은행</th>
				<th>신청 계좌번호</th>
				<th>현금화 유형</th>
				<th>현금화 상태</th>
				<th>현금화 신청시간</th>
				<th>현금화 완료시간</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="cashingPointsDto" items="${requestList}">
				<tr>
					<td>${cashingPointsDto.cashingNo}</td>
					<td>${cashingPointsDto.memberNo}</td>
					<td>${cashingPointsDto.cashingMoney}</td>
					<td>${cashingPointsDto.cashingBank}</td>
					<td>${cashingPointsDto.cashingAccount}</td>
					<td>${cashingPointsDto.cashingType}</td>
					<td>${cashingPointsDto.cashingStatus}</td>
					<td>${cashingPointsDto.cashingRequestTime}</td>
					<td>${cashingPointsDto.cashingSuccessTime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>