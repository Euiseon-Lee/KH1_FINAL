package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class SuccessfulBidDto {
	private int succBidNo;
	private int auctionNo;
	private int succBidderNo;
	private int succFinalBid;
	private Date succAuctioneerApprove;
	private Date succBidderApprove;
	private Date succDate;
	private int succBidStatus;
	private int succAuctionCount; 
}
