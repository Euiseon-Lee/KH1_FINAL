package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.ChatContentDto;

public interface ChatDao {
	List<ChatContentDto> list(int chatRoomNo);
}
