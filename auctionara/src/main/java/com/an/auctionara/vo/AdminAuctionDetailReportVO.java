package com.an.auctionara.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class AdminAuctionDetailReportVO {
	private int auctionReportNo;
	private int auctionNo;
	private int auctioneerNo;
	private int auctionReporterNo;
	private String auctionReportReason;
	private String auctionReportTime; 
	private int auctionReportRestriction;
	private String memberNick; 
	private int auctionPrivate; 
	private String auctionTitle; 
}
