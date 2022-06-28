package com.an.auctionara.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ChatbotDto {
	private int chatbot_no;
	private String chatbot_content;
	private int chatbot_super_no; 
}
