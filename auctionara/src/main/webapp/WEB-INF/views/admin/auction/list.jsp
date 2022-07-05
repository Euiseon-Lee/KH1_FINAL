<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Auction List Sample Page</h2>

<div>
	<table>
		<thead>
			<tr>
				<th>경매 번호</th>
				<th>판매인</th>
				<th>카테고리</th>
				<th>경매제목</th>
				<th>등록일</th>
				<th>신고횟수</th>
				<th>상세</th>
				<th>관리</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="adminAuctionListVO" items="${list}">
				<tr>
					<td>${adminAuctionListVO.auctionNo}</td>
					<td>${adminAuctionListVO.memberName}(${adminAuctionListVO.memberNick})</td>
					<td>${adminAuctionListVO.categoryName}</td>
					<td>${adminAuctionListVO.auctionTitle}</td>
					<td>${adminAuctionListVO.auctionUploadTime}</td>
					<td>${adminAuctionListVO.reportCount}</td>
					<td><a href="${pageContext.request.contextPath}/admin/auction/detail/${adminAuctionListVO.auctionNo}">상세보기</a></td>
					<td><a href="${pageContext.request.contextPath}/admin/auction/report_detail?auctionNo=${adminAuctionListVO.auctionNo}">신고목록</a></td>
					
					<td>
						<c:choose>
							<c:when test="${adminAuctionListVO.auctionPrivate == 0}">
								<a href="${pageContext.request.contextPath}/admin/auction/private/${adminAuctionListVO.auctionNo}">비공개 처리</a>
							</c:when>
							<c:otherwise>
								<a href="${pageContext.request.contextPath}/admin/auction/open/${adminAuctionListVO.auctionNo}">공개 처리</a>
							</c:otherwise>
						</c:choose>
					</td>
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
		<form action="list" method="get">
			<select name="type" class="form-input input-round">
				<option value="member_name" <c:if test="${type == 'member_name'}">selected</c:if>>회원명</option>
				<option value="member_nick" <c:if test="${type == 'member_nick'}">selected</c:if>>닉네임</option>
				<option value="auction_title" <c:if test="${type == 'auction_title'}">selected</c:if>>경매 제목</option>
			</select>
			
			<input type="search" name="keyword" placeholder="검색어 입력" required class="form-input input-round" value="${keyword}">
			
			<input type="submit" value="검색" class="btn btn-primary">
		</form>
	</div>
</div>
