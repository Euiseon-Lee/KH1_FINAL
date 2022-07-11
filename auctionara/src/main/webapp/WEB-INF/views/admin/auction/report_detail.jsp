<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="/WEB-INF/views/admin/template/header.jsp" %>

<script>
	$(function(){
		$(".private-auction").click(function(e){
			var result = confirm("해당 경매 게시글을 비공개 처리하시겠습니까?")
			
			if(!result) {
				e.preventDefault();
			}
		});
		$(".open-auction").click(function(e){
			var result = confirm("해당 경매 게시글을 공개 처리하시겠습니까?")
			
			if(!result) {
				e.preventDefault();
			};
		});
		$("#history-back").click(function(){
			window.history.back(); 			
		});
	});
</script>

<div class="container">
	
	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<div class="col-1">
					<i id="history-back" class="fa-solid fa-arrow-left fa-2x" style="cursor:pointer;"></i>
				</div>
				<div class="col-11">
					<h1>신고 목록</h1>
					<h3 class="text-secondary">${auctionTitle} (
						<c:choose>
							<c:when test="${auctionPrivate == 0}">
								공개
							</c:when>
							<c:otherwise>
								비공개
							</c:otherwise>
						</c:choose>
					)</h3>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row p-2 mt-2">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>신고 번호</th>
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
	</div>
	
	<div class="row p-2 mt-2 text-end">
		<c:choose>
			<c:when test="${auctionPrivate == 0}">
				<a href="${root}/admin/auction/private/${auctionNo}" class="btn btn-danger private-auction">경매 비공개</a>
			</c:when>
			<c:otherwise>
				<a href="${root}/admin/auction/open/${auctionNo}" class="btn btn-primary open-auction">경매 공개</a>
			</c:otherwise>
		</c:choose>
	</div>
	
</div>

<%@include file="/WEB-INF/views/admin/template/footer.jsp" %>