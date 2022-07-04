package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.AuctionDto;
import com.an.auctionara.vo.AdminAuctionListVO;
import com.an.auctionara.vo.AuctionListVO;

public interface AuctionDao {
	int write(AuctionDto auctionDto);
	int recent(int auctioneerNo);
	List<AuctionListVO> list(int memberNo);
	
	// 관리자 페이지 - 경매 list, count 메소드 
	List<AdminAuctionListVO> adminList(String type, String keyword, int p, int s);
	int adminListCount(String type, String keyword);
}
