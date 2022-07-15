package com.an.auctionara.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ChatReportVO {
	private int chatReportNo;
	private int chatroomNo;
	private int memberNo;
	private String chatReportReason; 
	private String chatReportTime; 
	private int chatReportRestriction;
	private int auctionNo;
	private String auctionTitle; 
	// 신고자 닉네임 
	private String memberNick; 
}
