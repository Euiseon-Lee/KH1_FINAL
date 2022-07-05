<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>해당 경매에 대한 신고 목록</h2>

<div>
	<table>
		<thead>
			<tr>
				<th>신고 번호</th>
				<th>신고 게시글 번호</th>
				<th>신고자</th>
				<th>신고 내용</th>
				<th>신고 시각</th>
				<th>제재</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="detailReportList" items="${detailReportList}">
				<tr>
					<td>${detailReportList.auctionReportNo}</td>
					<td>${detailReportList.auctionNo}</td>
					<td>${detailReportList.memberName}</td>
					<td>${detailReportList.auctionReportReason}</td>
					<td>${detailReportList.auctionReportTime}</td>
					<td>
						<c:choose>
							<c:when test="${detailReportList.auctionReportRestriction == 0}">
								<a href="${pageContext.request.contextPath}/admin/restriction/restrict_member/${detailReportList.auctioneerNo}/${detailReportList.auctionReportNo}">제재하기</a>
							</c:when>
							<c:otherwise>
								제재완료
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	