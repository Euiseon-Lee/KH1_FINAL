package com.an.auctionara.repository;

import com.an.auctionara.entity.AuctionDto;

public interface AuctionDao {
	int write(AuctionDto auctionDto);
	int recent(int memberNo);
}
