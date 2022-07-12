package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.vo.AuctionDetailVO;
import com.an.auctionara.vo.ChatRoomListVO;

public interface ChatRoomDao {
	List<ChatRoomListVO> list(int memberNo);
	int newChat(int memberNo, int auctionNo, int auctioneerNo);
	int isJoin(int auctionNo, int memberNo, int auctioneerNo);
	AuctionDetailVO auctionDetail(int auctionNo);
}
