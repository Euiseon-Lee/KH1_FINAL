package com.an.auctionara.repository;

import java.util.List;
import java.util.Map;

import com.an.auctionara.entity.AuctionDto;
import com.an.auctionara.vo.AuctionDetailVO;
import com.an.auctionara.vo.AuctionListVO;

public interface AuctionDao {
	int write(AuctionDto auctionDto);
	int recent(int auctioneerNo);
	List<AuctionListVO> list(int memberNo);
	AuctionDetailVO detail(Map<String, Integer> info);
}
