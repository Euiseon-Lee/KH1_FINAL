package com.an.auctionara.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.an.auctionara.entity.ChatbotDto;
import com.an.auctionara.repository.ChatbotDao;

@RestController
@RequestMapping("/rest/chatbot")
public class ChatbotRestController {

	@Autowired
	private ChatbotDao chatbotDao;
	
	
	// 목록 
	@GetMapping("/")
	public List<ChatbotDto> list() {
		return chatbotDao.list();
	}
	
	// 등록 
	@PostMapping("/")
	public ChatbotDto insert(@RequestBody ChatbotDto chatbotDto) {
		return chatbotDao.insert(chatbotDto);
	}

	// 삭제 
	@DeleteMapping("/{chatbotNo}")
	public void delete(@PathVariable int chatbotNo) {
		chatbotDao.delete(chatbotNo);
	}
	
	// 수정 
	@PutMapping("/")
	public ChatbotDto update(@RequestBody ChatbotDto chatbotDto) {
		return chatbotDao.update(chatbotDto);
	}
}
