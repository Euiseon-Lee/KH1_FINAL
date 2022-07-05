<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Auction Detail</h2>

<div>
	<img src="${pageContext.request.contextPath}${profileUrl}">
</div>

<div>${adminAuctionDetailVO.auctionNo}</div>
<div>${adminAuctionDetailVO.memberName}</div>
<div>${adminAuctionDetailVO.memberNick}</div>
<div>${adminAuctionDetailVO.categoryName}</div>
<div>${adminAuctionDetailVO.auctionTitle}</div>
<div>${adminAuctionDetailVO.auctionContent}</div>
<div>${adminAuctionDetailVO.auctionUploadTime}</div>
<div>${adminAuctionDetailVO.auctionOpeningBid}원</div>
<div>${adminAuctionDetailVO.auctionClosingBid}원</div>
<div>${adminAuctionDetailVO.auctionBidUnit}원 단위</div>
<div>상태 : ${adminAuctionDetailVO.auctionStatus}</div>
<div>${adminAuctionDetailVO.auctionPrivate}</div>
<div>최고 입찰가 : ${adminAuctionDetailVO.maxBiddingPrice}원</div>
