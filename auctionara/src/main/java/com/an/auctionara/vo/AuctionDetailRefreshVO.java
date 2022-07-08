package com.an.auctionara.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@Builder@NoArgsConstructor@AllArgsConstructor
public class AuctionDetailRefreshVO {
	private int maxBiddingPrice;
	private int myBiddingPrice;
	private int biddingCount;
	private String topBidder;
}
