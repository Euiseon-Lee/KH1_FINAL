package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ChatContentDto {
	private int chat_no;
	private int chatroom_no;
	private int chatter_no;
	private String chat_content;
	private Date chat_time;
	private String chat_reported;
	private Date chat_read_time;
}
