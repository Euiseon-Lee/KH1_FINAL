package com.an.auctionara.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberVO {
	private int auctionNo;
	private int auctioneerNo;
	private String categoryName; 
	private String auctionTitle;
	private String auctionUploadTime; 
	private int auctionOpeningBid;
	private int auctionClosingBid;
	
	
	private String memberNo;
	private String memberNick;
	
	private int succ_bid_no;
	private int succ_final_bid;
	private int succBidStatus;
}
