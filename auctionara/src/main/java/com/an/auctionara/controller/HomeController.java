package com.an.auctionara.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.an.auctionara.service.AuctionService;
import com.an.auctionara.vo.AuctionListVO;

@Controller
public class HomeController {
	
	@Autowired
	AuctionService auctionService;
	
	@GetMapping("/")
	public String home(Model model, HttpSession session) {
//		int memberNo = (int) session.getAttribute("login");
		
		// 우리 동네 경매
		List<AuctionListVO> auctionList = auctionService.list(13);
		model.addAttribute("auctionList", auctionList);		
		
		return "index";
	}
}
