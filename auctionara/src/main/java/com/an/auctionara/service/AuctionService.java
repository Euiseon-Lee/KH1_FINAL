package com.an.auctionara.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.an.auctionara.vo.AuctionDetailVO;
import com.an.auctionara.vo.AuctionListVO;
import com.an.auctionara.vo.WriteAuctionVO;

public interface AuctionService {
	void write(int auctioneerNo, WriteAuctionVO writeAuctionVO) throws IllegalStateException, IOException;
	List<AuctionListVO> list(int memberNo);
	AuctionDetailVO detail(int bidderNo, int auctionNo);
}
