package com.an.auctionara.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.an.auctionara.entity.CategoryDto;
import com.an.auctionara.entity.GpsAddressDto;
import com.an.auctionara.repository.CategoryDao;
import com.an.auctionara.repository.GpsAddressDao;
import com.an.auctionara.service.AuctionService;
import com.an.auctionara.vo.AuctionListVO;
import com.an.auctionara.vo.MyBiddingAuctionListVO;

@Controller
public class HomeController {
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private GpsAddressDao gpsAddressDao;
	
	@Autowired
	private AuctionService auctionService;
	
	@GetMapping("/")
	public String home(Model model, HttpSession session) {
//		int memberNo = (int) session.getAttribute("login");
		
		// 카테고리
		List<CategoryDto> categoryList = categoryDao.list();
		model.addAttribute("categoryList", categoryList);
		
		// 내 최근 입찰 경매
		List<MyBiddingAuctionListVO> myBiddingAuctionList = auctionService.myBiddingAuctionList(9);
		model.addAttribute("myBiddingAuctionList", myBiddingAuctionList);
		
		// 주소 필터 표시 여부
		List<GpsAddressDto> address = gpsAddressDao.list(13); // 임시
		if(address.size() == 2) {
			model.addAttribute("addressCount", true);
		} else {
			model.addAttribute("addressCount", false);
		}
		
		// 내 대표 동네
		model.addAttribute("address1", address.get(0));	
				
		return "index";
	}
	
	@ResponseBody
	@GetMapping("/list")
	public List<AuctionListVO> auctionList(@RequestParam int page, 
											@RequestParam int filter, 
											@RequestParam int sort,
											@RequestParam(required = false) Integer categoryNo,
											@RequestParam(required = false) String keyword,
											@RequestParam(required = false) Integer search,
											HttpSession session) {
//		int memberNo = (int) session.getAttribute("login");
		
		// 우리 동네 경매
		List<AuctionListVO> auctionList = auctionService.list(6, page, filter, sort, categoryNo, keyword, search); // 임시
		return auctionList;
	}
}
