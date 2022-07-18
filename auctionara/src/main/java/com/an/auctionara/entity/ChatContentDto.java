package com.an.auctionara.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ChatContentDto {
	private int chatNo;
	private int chatRoomNo;
	private int chatterNo;
	private String chatContent;
	private Date chatTime;
	private String chatReported;
	private Date chatReadTime;
	private String chatTimeFormat;
	
	private int chatType;
}
