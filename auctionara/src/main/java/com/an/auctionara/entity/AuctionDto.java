package com.an.auctionara.entity;

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
	private String auctionUploadTime;
	private String auctionClosedTime;	
	private int auctionOpeningBid;
	private int auctionClosingBid;
	private int auctionBidUnit;
	private int auctionStatus;
	
	// 컬럼 추가
	private int auctionPrivate;
	private double auctionLatitude1;
	private double auctionLongitude1;
	private int auctionCircle1;
	private double auctionLatitude2;
	private double auctionLongitude2;
	private int auctionCircle2;
	
	//경매진행상태 컬럼 추가
	private int auction_process;
}
