package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ChatReportDto {
	private int chatReportNo;
	private int chatRoomNo;
	private int memberNo;
	private String chatReportReason;
	private Date chatReportTime; 
}
