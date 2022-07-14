package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.ChatContentDto;

public interface ChatContentDao {
	List<ChatContentDto> list(int chatRoomNo);
	void save(ChatContentDto chatContentDto);
}
