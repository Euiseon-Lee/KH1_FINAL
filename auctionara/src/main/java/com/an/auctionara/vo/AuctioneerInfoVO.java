package com.an.auctionara.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@Builder@NoArgsConstructor@AllArgsConstructor
public class AuctioneerInfoVO {
	private int auctioneerNo;
	private int dislikeCount;
	private int likeCount;
	private String memberNick;
	private int attachmentNo;
	private String memberPreference;	
	private Date memberLogintime;
	private int memberRedCount;
}
