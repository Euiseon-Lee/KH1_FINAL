package com.an.auctionara.service;

import java.util.List;

import com.an.auctionara.vo.AuctionListVO;

public interface AuctionService {
	List<AuctionListVO> list(int memberNo);
}
