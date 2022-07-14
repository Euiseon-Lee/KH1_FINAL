package com.an.auctionara.repository;

import com.an.auctionara.entity.SuccessfulBidDto;
import com.an.auctionara.vo.CheckRatingVO;

public interface SuccessfulBidDao {
	void insert(SuccessfulBidDto finish);
	int getMonthlyTotalBid();
	CheckRatingVO checkRating(int auctionNo);
	void auctioneerApprove(int auctionNo);
	void bidderApprove(int auctionNo);
}
