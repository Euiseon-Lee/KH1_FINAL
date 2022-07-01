<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1>경매 신고 목록 테스트</h1>


<div>
	<table>
		<thead>
			<tr>
				<th>신고 번호</th>
				<th>신고 게시글 번호</th>
				<th>신고대상 이름</th>
				<th>신고자</th>
				<th>신고 내용</th>
				<th>신고 시각</th>
				<th>제재</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="auctionReportListVO" items="${list}">
				<tr>
					<td>${auctionReportListVO.auctionReportNo}</td>
					<td>${auctionReportListVO.auctionNo}</td>
					<td>${auctionReportListVO.auctioneerName}</td>
					<td>${auctionReportListVO.reporterName}</td>
					<td>${auctionReportListVO.auctionReportReason}</td>
					<td>${auctionReportListVO.auctionReportTime}</td>
					<td><a href="${pageContext.request.contextPath}/admin/restriction/restrict_member/${auctionReportListVO.auctioneerNo}">제재하기</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>