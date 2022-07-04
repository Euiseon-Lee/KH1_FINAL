package com.an.auctionara.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AdminAuctionListVO {
	private int auctionNo;
	private String auctionTitle;
	private String auctionUploadTime;
	private int auctionPrivate; 
	private String memberName;
	private String memberNick;
	private String categoryName; 
	private int reportCount;
}
