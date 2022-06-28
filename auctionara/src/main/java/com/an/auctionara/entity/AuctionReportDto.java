package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AuctionReportDto {
	private int auctionReportNo;
	private int auctionNo;
	private int auctionReporterNo;
	private String auctionReportReason;
	private Date auctionReportTime;
}
