package com.an.auctionara.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MyBiddingVO {
	private Date auctionClosedTime;
	private String auctionTitle;	
	private int auctionNo;	
	private int auctionProcess;
	private int maxBiddingPrice;
	private String topBidder;
	private int succBidNo;
	private int succBidStatus;
	private Date succAuctioneerApprove;
	private Date succBidderApprove;
	private int ratingNo;
	private int categoryNo; 
	private String categoryName;
	private int auctionCount;
}
