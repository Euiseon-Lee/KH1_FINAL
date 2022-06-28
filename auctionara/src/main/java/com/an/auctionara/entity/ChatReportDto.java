package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ChatReportDto {
	private int chat_report_no;
	private int chat_no;
	private int chat_reporter_no;
	private String chat_report_reason;
	private Date chat_report_time; 
}
