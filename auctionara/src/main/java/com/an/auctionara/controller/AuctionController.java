package com.an.auctionara.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.an.auctionara.entity.BiddingDto;
import com.an.auctionara.entity.CategoryDto;
import com.an.auctionara.entity.PhotoDto;
import com.an.auctionara.repository.AuctionDao;
import com.an.auctionara.repository.BiddingDao;
import com.an.auctionara.repository.CategoryDao;
import com.an.auctionara.repository.PhotoDao;
import com.an.auctionara.service.AuctionService;
import com.an.auctionara.vo.AuctionDetailRefreshVO;
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
	private BiddingDao biddingDao;
	
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
	
	// 카테고리별 경매 페이지
	@GetMapping("/category/{categoryNo}")
	public String category(@PathVariable int categoryNo) {
		
		return "/auction/category";
	}
	
	// 경매 물품 상세
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

	// 경매 물품 정보 리프레쉬
	@ResponseBody
	@GetMapping("/detail/refresh")
	public AuctionDetailRefreshVO detailRefresh(@RequestParam int bidderNo, @RequestParam int auctionNo) {
		// 새로고침할 정보 조회
		AuctionDetailRefreshVO refresh = biddingDao.refresh(bidderNo, auctionNo);
		return refresh;
	}
	
	// 경매 등록
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
	
	// 입찰
	@ResponseBody
	@PostMapping("/detail/bidding")
	public AuctionDetailRefreshVO bidding(@RequestBody BiddingDto biddingDto)  {
		AuctionDetailRefreshVO refresh = biddingDao.insert(biddingDto);
		return refresh;
	} 
}
