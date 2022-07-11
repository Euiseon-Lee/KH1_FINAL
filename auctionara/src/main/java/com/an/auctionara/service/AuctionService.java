package com.an.auctionara.service;

import java.io.IOException;
import java.util.List;

import com.an.auctionara.entity.BiddingDto;
import com.an.auctionara.vo.AuctionDetailRefreshVO;
import com.an.auctionara.vo.AuctionDetailVO;
import com.an.auctionara.vo.AuctionListVO;
import com.an.auctionara.vo.WriteAuctionVO;

public interface AuctionService {
	void write(int auctioneerNo, WriteAuctionVO writeAuctionVO) throws IllegalStateException, IOException;
	List<AuctionListVO> list(int memberNo, int page, int filter, int sort, Integer categoryNo, String keyword, Integer search);
	AuctionDetailVO detail(int bidderNo, int auctionNo);
	AuctionDetailRefreshVO bidding(BiddingDto biddingDto);
	public void successfulBid();
}
