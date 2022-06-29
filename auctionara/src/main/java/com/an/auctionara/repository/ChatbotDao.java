package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.ChatbotDto;

public interface ChatbotDao {

	// 목록 출력 메소드 
	List<ChatbotDto> list();

	// 등록 메소드 
	ChatbotDto insert(ChatbotDto chatbotDto);

	// 삭제 메소드 
	void delete(int chatbotNo);

	// 수정 메소드 
	ChatbotDto update(ChatbotDto chatbotDto);
	
}
