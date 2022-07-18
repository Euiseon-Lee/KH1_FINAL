package com.an.auctionara.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.an.auctionara.entity.ChatContentDto;
import com.an.auctionara.entity.ChatReportDto;
import com.an.auctionara.repository.ChatContentDao;
import com.an.auctionara.repository.ChatReportDao;
import com.an.auctionara.vo.ChatContentVO;
import com.an.auctionara.vo.ChatReportVO;
import com.an.auctionara.vo.ManagerRestrictionListVO;

@Controller
@RequestMapping("/admin/chat")
public class AdminChatController {
	
	@Autowired
	private ChatReportDao chatReportDao; 
	
	@Autowired
	private ChatContentDao chatContentDao; 

	@GetMapping("/bot")
	public String bot() {
		return "admin/chat/bot";
	}
	
	@GetMapping("/report_list")
	public String repost_list(
			@RequestParam(required = false) String type,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false, defaultValue = "1") int p,  
			@RequestParam(required = false, defaultValue = "10") int s,
			Model model) {
		List<ChatReportVO> list = chatReportDao.list(type, keyword, p, s);
		model.addAttribute("list", list);
		
		
		boolean search = type != null && keyword != null;
		model.addAttribute("search", search);
		
		int count = chatReportDao.count(type, keyword);
		
		int lastPage = (count + s -1) / s; 
		int blockSize = 10; 
		int endBlock = (p + blockSize -1) / blockSize * blockSize;
		int startBlock = endBlock - (blockSize -1);
		
		if(endBlock > lastPage) {
			endBlock = lastPage;
		}
		
		model.addAttribute("p", p);
		model.addAttribute("s", s);
		model.addAttribute("type", type);
		model.addAttribute("keyword",keyword);
		model.addAttribute("startBlock", startBlock);
		model.addAttribute("endBlock", endBlock);
		model.addAttribute("lastPage", lastPage);
		
		return "admin/chat/report_list"; 
	}
	
	@GetMapping("/report_detail/{chatReportNo}/{chatroomNo}/{auctioneerNo}/{chatReportRestriction}")
	public String report_detail(@PathVariable int chatReportNo, 
								@PathVariable int chatroomNo, 
								@PathVariable int auctioneerNo,
								@PathVariable int chatReportRestriction,
								Model model) {
		model.addAttribute("restriction", chatReportRestriction);
		model.addAttribute("auctioneerNo", auctioneerNo);
		model.addAttribute("chatReportNo", chatReportNo);
		
		ChatReportDto chatReportDto = chatReportDao.getReason(chatReportNo);
		model.addAttribute("reportReason", chatReportDto.getChatReportReason());
		
		List<ChatContentVO> content = chatContentDao.content(chatroomNo);
		model.addAttribute("content", content);
		
		
		return "admin/chat/report_detail"; 
	}
}
