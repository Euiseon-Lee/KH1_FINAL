package com.an.auctionara.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@Builder@NoArgsConstructor@AllArgsConstructor
public class AuctionDetailVO {
	private int auctionNo;
	private int auctioneerNo;
	private int categoryNo;
	private String auctionTitle;
	private String auctionContent;
	private String auctionClosedTime;	
	private int auctionOpeningBid;
	private int auctionClosingBid;
	private int auctionBidUnit;
	private int auctionStatus;
	private String auctionRemainTime;
	private int maxBiddingPrice;
	private int myBiddingPrice;
}
