package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BiddingDto {
	private int bidder_no;
	private int auction_no;
	private int bidding_price;
	private Date bidding_time; 
}
