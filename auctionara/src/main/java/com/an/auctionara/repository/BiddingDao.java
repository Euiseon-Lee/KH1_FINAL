package com.an.auctionara.repository;

import java.util.Map;

import com.an.auctionara.entity.BiddingDto;
import com.an.auctionara.vo.AuctionDetailRefreshVO;

public interface BiddingDao {
	Boolean biddingExist(Map<String, Integer> info);
	AuctionDetailRefreshVO refresh(int bidderNo, int auctionNo);
	void insert(BiddingDto biddingDto);
}
