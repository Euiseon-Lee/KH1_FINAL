package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.ChatContentDto;
import com.an.auctionara.vo.ChatContentVO;

public interface ChatContentDao {
	List<ChatContentDto> list(int chatRoomNo);
	void save(ChatContentDto chatContentDto);
	List<ChatContentVO> content(int chatroomNo);
	void read(int chatterNo, int chatRoomNo);
}
