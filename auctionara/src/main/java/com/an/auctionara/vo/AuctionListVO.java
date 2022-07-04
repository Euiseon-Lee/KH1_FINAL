package com.an.auctionara.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@Builder@NoArgsConstructor@AllArgsConstructor
public class AuctionListVO {
	private int photoAttachmentNo;
	private int auctionNo;
	private String auctionTitle;
	private int auctionOpeningBid;
	private int biddingPrice;
	private Date auctionClosedTime;
	private String auctionRemainTime;
	private boolean deadlineClosing;
	
	// 컬럼 추가
	private int auctionPrivate; 
}
