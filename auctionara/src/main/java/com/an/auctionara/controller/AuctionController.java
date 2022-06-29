package com.an.auctionara.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/auction")
public class AuctionController {

	@GetMapping("/write")
	public String write() {
		return "/auction/write";
	}
	
	@GetMapping("/search")
	public String search() {
		
		return "/auction/search";
	}
	
	@GetMapping("/type/{categoryNo}")
	public String type(@PathVariable int categoryNo) {
		
		return "/auction/type";
	}
	
	@GetMapping("/detail/{auctionNo}")
	public String detail(@PathVariable int auctionNo) {
		
		return "/auction/detail";
	}
	
	@PostMapping("/write")
	public String write2() {
		
		return "redirect:/auction/detail";
	}
}
