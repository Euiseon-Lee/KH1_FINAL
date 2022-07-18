package com.an.auctionara.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@AllArgsConstructor@NoArgsConstructor@Builder
public class ChatParticipatorDto {
	private int chatRoomNo, memberNo, chatRoomReport, chatRoomStatus;
}
