package com.an.auctionara.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@Builder@NoArgsConstructor@AllArgsConstructor
public class AuctionDetailVO {
	private int auctionNo;
	private int auctioneerNo;
	private String categoryName;
	private int categoryNo;
	private String auctionTitle;
	private String auctionContent;
	private Date auctionClosedTime;	
	private int auctionOpeningBid;
	private int auctionClosingBid;
	private int auctionBidUnit;
	private int auctionStatus;
	private int maxBiddingPrice;
	private int myBiddingPrice;
	private int biddingCount;
	private String topBidder;
}
