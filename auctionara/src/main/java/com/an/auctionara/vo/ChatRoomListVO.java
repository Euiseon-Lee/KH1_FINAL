	package com.an.auctionara.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data@AllArgsConstructor@NoArgsConstructor@Builder
public class ChatRoomListVO {
	private int chatRoomNo;
	private int auctionNo; 
	private int auctioneerNo;
	private String memberNick;
	private int attachmentNo;
	private int photoAttachmentNo;
	private String auctionTitle;
	private String auctioneerNick;
	private int auctioneerAttachmentNo;
}
