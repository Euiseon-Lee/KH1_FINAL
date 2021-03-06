package com.an.auctionara.vo;

import java.sql.Date;

import com.an.auctionara.entity.AuctionReportDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AuctionReportListVO {
	private int auctionReportNo;
	private int auctionNo;
	private int auctionReporterNo;
	private String auctionReportReason;
	private Date auctionReportTime;
	private String auctioneerNick;
	private int auctioneerNo; 
	private String reporterNick;
	
	// 컬럼 추가
	private int auctionReportRestriction;
	private String auctionTitle; 
}
