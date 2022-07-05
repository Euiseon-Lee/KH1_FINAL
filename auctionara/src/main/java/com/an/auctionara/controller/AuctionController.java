package com.an.auctionara.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.an.auctionara.entity.AuctionDto;
import com.an.auctionara.entity.CategoryDto;
import com.an.auctionara.entity.PhotoDto;
import com.an.auctionara.repository.AttachmentDao;
import com.an.auctionara.repository.AuctionDao;
import com.an.auctionara.repository.BiddingDao;
import com.an.auctionara.repository.CategoryDao;
import com.an.auctionara.repository.PhotoDao;
import com.an.auctionara.service.AuctionService;
import com.an.auctionara.vo.AuctionDetailVO;
import com.an.auctionara.vo.WriteAuctionVO;

@Controller
@RequestMapping("/auction")
public class AuctionController {
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private AuctionDao auctionDao;
	
	@Autowired
	private PhotoDao photoDao;
	
	@Autowired
	private AuctionService auctionService;

	@GetMapping("/write")
	public String write(Model model) {
		List<CategoryDto> categoryList = categoryDao.list();
		model.addAttribute("categoryList", categoryList);		
		return "/auction/write";
	}
	
	@GetMapping("/search")
	public String search() {
		
		return "/auction/search";
	}
	
	@GetMapping("/category/{categoryNo}")
	public String category(@PathVariable int categoryNo) {
		
		return "/auction/category";
	}

	@GetMapping("/detail/{auctionNo}")
	public String detail(@PathVariable int auctionNo, HttpSession session, Model model) {
//		int memberNo = (int) session.getAttribute("whoLogin");
		
		// 경매 상세 정보 조회
		AuctionDetailVO auctionDetail = auctionService.detail(9, auctionNo); // 임시
		model.addAttribute("auctionDetail", auctionDetail);
		
		// 경매 사진 조회
		List<PhotoDto> photoList = photoDao.list(auctionNo);
		model.addAttribute("photoList", photoList);
		
		return "/auction/detail";
	}

	@PostMapping("/write")
	public void write2(@ModelAttribute WriteAuctionVO writeAuctionVO, HttpSession session) throws IllegalStateException, IOException {	
//		int memberNo = (int) session.getAttribute("whoLogin");
		auctionService.write(13, writeAuctionVO); // 임시
	}
	
	@PostMapping("/submit")
	public String submit(HttpSession session) {
//		int memberNo = (int) session.getAttribute("whoLogin");
		return "redirect:/auction/detail/" + auctionDao.recent(13); // 임시
	}
}
