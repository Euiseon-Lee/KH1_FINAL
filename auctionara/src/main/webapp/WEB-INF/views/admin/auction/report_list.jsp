<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="/WEB-INF/views/admin/template/header.jsp" %>

<div class="container">
	
	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<h1>경매 신고 내역</h1>
			</div>
		</div>
	</div>
	
	<div class="row p-2 mt-2">
		<table class="table table-hover">
			<thead>
				<tr>
					<th style="width:10%;">신고 번호</th>
					<th style="width:50%;">신고 내용</th>
					<th>신고자</th>
					<th>신고 시각</th>
					<th>보기</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="auctionReportListVO" items="${list}">
					<tr>
						<td>${auctionReportListVO.auctionReportNo}</td>
						<td>${auctionReportListVO.auctionReportReason}</td>
						<td>${auctionReportListVO.reporterNick}</td>
						<td>${auctionReportListVO.auctionReportTime}</td>
						<td>
							<a href="${pageContext.request.contextPath}/admin/auction/detail/${auctionReportListVO.auctionNo}">보기</a>
						</td>
						<td>
							<c:choose>
								<c:when test="${auctionReportListVO.auctionReportRestriction == 0}">
									<a href="${pageContext.request.contextPath}/admin/restriction/restrict_auction/${auctionReportListVO.auctioneerNo}/${auctionReportListVO.auctionReportNo}">제재하기</a>
								</c:when>
								<c:when test="${auctionReportListVO.auctionReportRestriction == 1}">
									제재 완료
								</c:when>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="p-2 mt-2 text-center pagination">
		<c:if test="${p > 1}">
			<c:choose>
				<c:when test="${search}">
					<a href="report_list?p=1&s=${s}&type=${type}&keyword=${keyword}">&laquo;</a>
				</c:when>
				<c:otherwise>
					<a href="report_list?p=1&s=${s}">&laquo;</a>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:if test="${startBlock > 1}">
			<c:choose>
				<c:when test="${search}">
					<a href="report_list?p=${startBlock-1}&s=${s}&type=${type}&keyword=${keyword}">&laquo;</a>
				</c:when>
				<c:otherwise>
					<a href="report_list?p=${startBlock-1}&s=${s}">&laquo;</a>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<!-- 숫자 링크 영역 -->
		<c:forEach var="i" begin="${startBlock}" end="${endBlock}" step="1">
			<c:choose>
				<c:when test="${search}">
					<c:choose>
						<c:when test="${i == p}">
							<a class="active" href="report_list?p=${i}&s=${s}&type=${type}&keyword=${keyword}">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="report_list?p=${i}&s=${s}&type=${type}&keyword=${keyword}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${i == p}">
							<a class="active" href="report_list?p=${i}&s=${s}">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="report_list?p=${i}&s=${s}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
		<!-- 다음 버튼 영역 -->
		<c:if test="${endBlock < lastPage}">
			<c:choose>
				<c:when test="${search}">
					<a href="report_list?p=${endBlock+1}&s=${s}&type=${type}&keyword=${keyword}">&gt;</a>
				</c:when>
				<c:otherwise>
					<a href="report_list?p=${endBlock+1}&s=${s}">&gt;</a>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:if test="${p < lastPage}">
			<c:choose>
				<c:when test="${search}">
					<a href="report_list?p=${lastPage}&s=${s}&type=${type}&keyword=${keyword}">&raquo;</a>
				</c:when>
				<c:otherwise>
					<a href="report_list?p=${lastPage}&s=${s}">&raquo;</a>
				</c:otherwise>
			</c:choose>
		</c:if>
	</div>
	
	<div class="row p-2 mt-2">
		<!-- 검색창 -->
		<form action="report_list" method="get">
			<div class="row justify-content-md-center">
				<div class="col-2">
					<select name="type" class="form-select">
						<option value="auction_report_reason" <c:if test="${type == 'auction_report_reason'}">selected</c:if>>내용</option>
						<option value="m2.member_nick" <c:if test="${type == 'm2.member_nick'}">selected</c:if>>신고자</option>
					</select>
				</div>
				<div class="col-3">
					<input type="search" name="keyword" placeholder="검색어 입력" required class="form-control" value="${keyword}" autocomplete="off">
				</div>
				<div class="col-2">
					<input type="submit" value="검색" class="btn btn-primary">
				</div>
			</div>
		</form>
	</div>
	
</div>

<%@include file="/WEB-INF/views/admin/template/footer.jsp" %>