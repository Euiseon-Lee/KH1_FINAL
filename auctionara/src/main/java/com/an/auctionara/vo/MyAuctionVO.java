package com.an.auctionara.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MyAuctionVO {
	private Date auctionUploadTime;
	private int categoryNo; 
	private String categoryName; 
	private String auctionTitle;	
	private int auctionNo;	
	private int auctionProcess;
	private int succBidNo;
	private int succBidStatus;
	private Date succAuctioneerApprove;
	private Date succBidderApprove;
	private int succFinalBid;
	private int chatroomNo;
	private int ratingNo;
	private int auctionCount;
	private int totalPoint;
	private String auctionFinish;
}
