package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AuctionDto {
	private int auctionNo;
	private int auctioneerNo;
	private int categoryNo;
	private String auctionTitle;
	private String auctionContent;
	private Date auctionUploadTime;
	private Date auctionClosedTime;
	private int auctionOpeningBid;
	private int auctionClosingBid;
	private int auctionBidUnit;
	private int auctionCount;
	private int auctionStatus; 
}
