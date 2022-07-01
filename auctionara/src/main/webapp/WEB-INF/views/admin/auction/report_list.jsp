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
	
	<div class="row center pagination">
	
		<c:if test="${p > 1}">
			<c:choose>
				<c:when test="${search}">
					<a href="list?p=1&s=${s}&type=${type}&keyword=${keyword}">&laquo;</a>
				</c:when>
				<c:otherwise>
					<a href="list?p=1&s=${s}">&laquo;</a>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:if test="${startBlock > 1}">
			<c:choose>
				<c:when test="${search}">
					<a href="list?p=${startBlock-1}&s=${s}&type=${type}&keyword=${keyword}">&laquo;</a>
				</c:when>
				<c:otherwise>
					<a href="list?p=${startBlock-1}&s=${s}">&laquo;</a>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<!-- 숫자 링크 영역 -->
		<c:forEach var="i" begin="${startBlock}" end="${endBlock}" step="1">
			<c:choose>
				<c:when test="${search}">
					<c:choose>
						<c:when test="${i == p}">
							<a class="active" href="list?p=${i}&s=${s}&type=${type}&keyword=${keyword}">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="list?p=${i}&s=${s}&type=${type}&keyword=${keyword}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${i == p}">
							<a class="active" href="list?p=${i}&s=${s}">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="list?p=${i}&s=${s}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
		<!-- 다음 버튼 영역 -->
		<c:if test="${endBlock < lastPage}">
			<c:choose>
				<c:when test="${search}">
					<a href="list?p=${endBlock+1}&s=${s}&type=${type}&keyword=${keyword}">&gt;</a>
				</c:when>
				<c:otherwise>
					<a href="list?p=${endBlock+1}&s=${s}">&gt;</a>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:if test="${p < lastPage}">
			<c:choose>
				<c:when test="${search}">
					<a href="list?p=${lastPage}&s=${s}&type=${type}&keyword=${keyword}">&raquo;</a>
				</c:when>
				<c:otherwise>
					<a href="list?p=${lastPage}&s=${s}">&raquo;</a>
				</c:otherwise>
			</c:choose>
		</c:if>
	
	</div>
	
	<div class="row center">
		<!-- 검색창 -->
		<form action="report_list" method="get">
			<select name="type" class="form-input input-round">
				<option value="auction_report_reason" <c:if test="${type == 'auction_report_reason'}">selected</c:if>>신고 내용</option>
				<option value="m2.member_name" <c:if test="${type == 'm2.member_name'}">selected</c:if>>신고자명</option>
			</select>
			
			<input type="search" name="keyword" placeholder="검색어 입력" required class="form-input input-round" value="${keyword}">
			
			<input type="submit" value="검색" class="btn btn-primary">
		</form>
	</div>
</div>