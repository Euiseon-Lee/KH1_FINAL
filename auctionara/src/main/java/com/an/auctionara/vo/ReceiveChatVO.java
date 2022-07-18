package com.an.auctionara.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@Builder@NoArgsConstructor@AllArgsConstructor
public class ReceiveChatVO {
	private int type, chatRoomNo, chatterNo, attachmentNo;
	private String message, messageType, chatTime, emojiNo;
}
