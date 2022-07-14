package com.an.auctionara.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/chat")
public class AdminChatController {

	@GetMapping("/bot")
	public String bot() {
		return "admin/chat/bot";
	}
}
