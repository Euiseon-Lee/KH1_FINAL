package com.an.auctionara.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@AllArgsConstructor@NoArgsConstructor@Builder
public class ChatListVO {
	private String otherNick, auctionNo;
	private int chatRoomNo, otherMemberNo, memberNo;
}
