package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AuctionReportDto {
	private int auction_report_no;
	private int auction_no;
	private int auction_reporter_no;
	private String auction_report_reason;
	private Date auction_report_time;
}
