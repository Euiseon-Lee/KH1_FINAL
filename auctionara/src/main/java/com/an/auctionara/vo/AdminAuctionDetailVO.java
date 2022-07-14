package com.an.auctionara.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AdminAuctionDetailVO {
	private int auctionNo;
	private int auctioneerNo;
	private String categoryName; 
	private String auctionTitle;
	private String auctionContent; 
	private String auctionUploadTime; 
	private int auctionOpeningBid;
	private int auctionClosingBid;
	private int auctionBidUnit; 
	private int auctionStatus;
	private int auctionPrivate;
	private String memberNick;
	private int maxBiddingPrice;
	private int photoAttachmentNo; 
}
