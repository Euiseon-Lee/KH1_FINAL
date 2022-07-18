package com.an.auctionara.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@Builder@NoArgsConstructor@AllArgsConstructor
public class MyBiddingAuctionListVO {
	private int photoAttachmentNo;
	private int auctionNo;
	private String auctionTitle;
	private int biddingPrice;
	private int myBiddingPrice;
	private int myBiddingNo;
	private Date auctionClosedTime;
	private String auctionRemainTime;
	private boolean deadlineClosing;	
}
