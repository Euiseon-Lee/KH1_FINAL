package com.an.auctionara.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.an.auctionara.entity.AuctionDto;
import com.an.auctionara.repository.AuctionDao;

@RestController
@RequestMapping("/asyncMypage")
public class MypageRestController {
	
	@Autowired
	private AuctionDao auctionDao;
	
	@GetMapping("/")
	public List<AuctionDto> list(HttpSession session){
		int memberNo = (int) session.getAttribute("whoLogin");
		return auctionDao.mypageList(memberNo);
	}

	@PostMapping
	public int auctionExists(HttpSession session) {
		int memberNo = (int) session.getAttribute("whoLogin");
		int auction = auctionDao.countAuctionbyMemberNo(memberNo);
		
		return auction;
	}
}
