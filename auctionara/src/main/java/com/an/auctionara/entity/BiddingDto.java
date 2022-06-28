package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BiddingDto {
	private int bidderNo;
	private int auctionNo;
	private int biddingPrice;
	private Date biddingTime; 
}
