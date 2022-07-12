<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%@include file="/WEB-INF/views/admin/template/header.jsp" %>

<script>
	$(function(){
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
					<h1>경매 게시글 상세</h1>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-4">
			<div class="card">
				<div class="card-body">
					<div class="row p-5">
						<img src="${pageContext.request.contextPath}${profileUrl}" class="img-fluid" style="width:100%; height:250px; border-radius:15%;">
					</div>
					<div class="row p-1">
						<h2>${adminAuctionDetailVO.auctionTitle}</h2>
					</div>
					<div class="row p-1">
						<p>${adminAuctionDetailVO.auctionContent}</p>
					</div>
				</div>
			</div>
		</div>
		<div class="col-8">
			<div class="card">
				<div class="card-body">
					<ul class="list-group list-group-flush">
						<li class="list-group-item">
						  	<h2 class="card-title">업로드 이미지</h2>
						  	<c:forEach var="photoList" items="${photoList}">
								<img src="${pageContext.request.contextPath}/attachment/download?attachmentNo=${photoList.photoAttachmentNo}" class="img-fluid float-start p-1" style="width:170px; height:170px; border-radius:20%;">
							</c:forEach>
						</li>
						<li class="list-group-item">
						  	<h2 class="card-title">카테고리</h2>
						  	<p class="card-text">${adminAuctionDetailVO.categoryName}</p>
						</li>
						<li class="list-group-item">
						  	<h2 class="card-title">판매자</h2>
						  	<p class="card-text">${adminAuctionDetailVO.memberName} (${adminAuctionDetailVO.memberNick})</p>
						</li>
						<li class="list-group-item">
						  	<h2 class="card-title">게시글 등록 시간</h2>
						  	<p class="card-text">${adminAuctionDetailVO.auctionUploadTime}</p>
						</li>
						<li class="list-group-item">
						  	<h2 class="card-title">최소 입찰 가격</h2>
						  	<p class="card-text">
						  		<fmt:formatNumber value="${adminAuctionDetailVO.auctionOpeningBid}" pattern="#,###" />원
						  	</p>
						</li>
						<li class="list-group-item">
						  	<h2 class="card-title">즉시 낙찰 가격</h2>
						  	<p class="card-text">
						  		<fmt:formatNumber value="${adminAuctionDetailVO.auctionClosingBid}" pattern="#,###" />원
						  	</p>
						</li>
						<li class="list-group-item">
						  	<h2 class="card-title">입찰 단위</h2>
						  	<p class="card-text">
						  		<fmt:formatNumber value="${adminAuctionDetailVO.auctionBidUnit}" pattern="#,###" />원
						  	</p>
						</li>
						<li class="list-group-item">
						  	<h2 class="card-title">현재 최고 입찰가</h2>
						  	<p class="card-text">
						  		<fmt:formatNumber value="${adminAuctionDetailVO.maxBiddingPrice}" pattern="#,###" />원
						  	</p>
						</li>
						<li class="list-group-item">
						  	<h2 class="card-title">물품 상태</h2>
						  	<c:choose>
						  		<c:when test="${adminAuctionDetailVO.auctionStatus == 5}">
						  			<p class="card-text">상</p>
						  		</c:when>
						  		<c:when test="${adminAuctionDetailVO.auctionStatus == 4}">
						  			<p class="card-text">중상</p>
						  		</c:when>
						  		<c:when test="${adminAuctionDetailVO.auctionStatus == 3}">
						  			<p class="card-text">중</p>
						  		</c:when>
						  		<c:when test="${adminAuctionDetailVO.auctionStatus == 2}">
						  			<p class="card-text">중하</p>
						  		</c:when>
						  		<c:when test="${adminAuctionDetailVO.auctionStatus == 1}">
						  			<p class="card-text">하</p>
						  		</c:when>
						  	</c:choose>
						</li>
						<li class="list-group-item">
						  	<h2 class="card-title">공개 상태</h2>
						  	<c:choose>
						  		<c:when test="${adminAuctionDetailVO.auctionPrivate == 0}">
						  			<p class="card-text">공개</p>
						  		</c:when>
						  		<c:when test="${adminAuctionDetailVO.auctionPrivate == 1}">
						  			<p class="card-text">비공개</p>
						  		</c:when>
						  	</c:choose>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>

</div>

<%@include file="/WEB-INF/views/admin/template/footer.jsp" %>