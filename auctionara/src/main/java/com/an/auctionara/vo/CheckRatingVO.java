	package com.an.auctionara.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data@AllArgsConstructor@NoArgsConstructor@Builder
public class CheckRatingVO {
	private int auctionNo;
	private Date succAuctioneerApprove;
	private Date succBidderApprove;
	private int succBidStatus;
	private int ratingNo;
}
