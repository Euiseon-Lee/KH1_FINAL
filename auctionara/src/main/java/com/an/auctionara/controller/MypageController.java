package com.an.auctionara.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@GetMapping("/index")
	public String infoIndex() {
		return "mypage/index";
	}
	
	@GetMapping("/info")
	public String info(HttpSession session, Model Model) {
		return "mypage/info";
	}
	
	@GetMapping("/exit")
	public String exit() {
		return "mypage/exit";
	}
	
	@GetMapping("/auction_history")
	public String auctionHistory(HttpSession session, Model Model) {
		return "mypage/auction_history";
	}
	
	@GetMapping("/pay_history")
	public String payHistory(HttpSession session, Model Model) {
		return "mypage/pay_history";
	}
	
	@GetMapping("/cash_log")
	public String cashLog(HttpSession session, Model Model) {
		return "mypage/cash_log";
	}
	
	
}
