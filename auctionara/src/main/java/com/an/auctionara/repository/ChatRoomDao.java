package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.ChatReportDto;
import com.an.auctionara.vo.AuctionDetailVO;
import com.an.auctionara.vo.ChatRoomListVO;

public interface ChatRoomDao {
	List<ChatRoomListVO> list(int memberNo);
	int join(int memberNo, int auctionNo);
	AuctionDetailVO auctionDetail(int auctionNo);
	void report(ChatReportDto chatReportDto);
	int search(int auctionNo);
}
