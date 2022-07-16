package com.an.auctionara.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ChatContentVO {
	private int chatNo;
	private int chatRoomNo; 
	private int chatterNo;
	private String memberNick;
	private String chatContent;
	private String chatTime;
}
