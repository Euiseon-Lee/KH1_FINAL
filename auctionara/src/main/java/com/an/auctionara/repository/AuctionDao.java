package com.an.auctionara.repository;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.an.auctionara.entity.AuctionDto;
import com.an.auctionara.entity.SuccessfulBidDto;
import com.an.auctionara.vo.AdminAuctionDetailVO;
import com.an.auctionara.vo.AdminAuctionListVO;
import com.an.auctionara.vo.AuctionDetailVO;
import com.an.auctionara.vo.AuctionListVO;
import com.an.auctionara.vo.AuctioneerInfoVO;
import com.an.auctionara.vo.MyAuctionVO;
import com.an.auctionara.vo.MyBiddingAuctionListVO;
import com.an.auctionara.vo.MyBiddingVO;

public interface AuctionDao {
	int write(AuctionDto auctionDto);
	int recent(int auctioneerNo);
	List<AuctionListVO> list(Map<String, Object> info);
	List<MyBiddingAuctionListVO> myBiddingAuctionList(int bidderNo);
	AuctionDetailVO detail(Map<String, Integer> info);
	List<SuccessfulBidDto> finish(Date now);
	SuccessfulBidDto close(int auctionNo);
	Boolean checkPrivate(int auctionNo);
	AuctioneerInfoVO auctioneerInfo(int auctioneerNo);
	List<MyAuctionVO> myAuction(Map<String, Object> info);
	List<MyBiddingVO> myBidding(Map<String, Object> info);
	
	// 관리자 페이지 - 경매 list, count 메소드 
	List<AdminAuctionListVO> adminList(String type, String keyword, int p, int s);
	int adminListCount(String type, String keyword);
	// 관리자 페이지 - 경매 detail 
	AdminAuctionDetailVO adminAuctionDetail(int auctionNo);
	// 관리자 페이지 - 경매 게시글 공개 처리 
	AuctionDto setOpen(int auctionNo);
	// 관리자 페이지 - 경매 게시글 비공개 처리 
	AuctionDto setPrivate(int auctionNo);
	// 관리자 페이지 - 경매 게시글 수 
	int countAuction();
}
