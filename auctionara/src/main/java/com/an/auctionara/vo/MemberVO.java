package com.an.auctionara.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberVO {
	private int memberNo;
	private int attachmentNo;
	private String memberEmail;
	private String memberNick;
	private int memberHoldingPoints;
	private int memberRedCount;
	private String memberPreference;
	
	private int totalCount;
	private int normalCount;
	private int cancelCount;
	private int stopCount;
	
	private int succCount;
}
