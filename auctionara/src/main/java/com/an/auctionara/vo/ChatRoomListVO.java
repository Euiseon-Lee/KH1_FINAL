	package com.an.auctionara.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data@AllArgsConstructor@NoArgsConstructor@Builder
public class ChatRoomListVO {
	private int chatRoomNo, auctionNo, memberNo, attachmentNo;
	private String memberNick, chatContent;
	private String chatTime;
}
