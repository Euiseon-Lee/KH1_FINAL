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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.an.auctionara.entity.AuctionReportDto;
import com.an.auctionara.entity.BiddingDto;
import com.an.auctionara.entity.CategoryDto;
import com.an.auctionara.entity.GpsAddressDto;
import com.an.auctionara.entity.PhotoDto;
import com.an.auctionara.repository.AuctionDao;
import com.an.auctionara.repository.AuctionReportDao;
import com.an.auctionara.repository.BiddingDao;
import com.an.auctionara.repository.CategoryDao;
import com.an.auctionara.repository.GpsAddressDao;
import com.an.auctionara.repository.MemberDao;
import com.an.auctionara.repository.PhotoDao;
import com.an.auctionara.repository.SuccessfulBidDao;
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
	private MemberDao memberDao;
	
	@Autowired
	private SuccessfulBidDao successfulBidDao;
	
	@Autowired
	private GpsAddressDao gpsAddressDao;	
	
	@Autowired
	private AuctionService auctionService;
	
	@Autowired
	private AuctionReportDao auctionReportDao;
	
	// 경매 검색 페이지
	@GetMapping("/search")
	public String search(@RequestParam String keyword, Model model, HttpSession session) {
		int memberNo = (int) session.getAttribute("whoLogin");
		
		// 주소 필터 표시 여부
		List<GpsAddressDto> address = gpsAddressDao.list(memberNo);
		if(address.size() == 2) {
			model.addAttribute("addressCount", true);
		} else {
			model.addAttribute("addressCount", false);
		}
		
		// 내 대표 동네
		model.addAttribute("address1", address.get(0));
		
		return "/auction/search";
	}
	
	// 카테고리별 경매 페이지
	@GetMapping("/category")
	public String category(@RequestParam int categoryNo, Model model, HttpSession session) {
		int memberNo = (int) session.getAttribute("whoLogin");
		
		// 카테고리
		List<CategoryDto> categoryList = categoryDao.list();
		model.addAttribute("categoryList", categoryList);
		
		// 주소 필터 표시 여부
		List<GpsAddressDto> address = gpsAddressDao.list(memberNo);
		if(address.size() == 2) {
			model.addAttribute("addressCount", true);
		} else {
			model.addAttribute("addressCount", false);
		}
		
		return "/auction/category";
	}

	// 경매 등록 페이지
	@GetMapping("/write")
	public String write(Model model, HttpSession session) {
		int memberNo = (int) session.getAttribute("whoLogin");
		
		// 카테고리 목록
		List<CategoryDto> categoryList = categoryDao.list();
		model.addAttribute("categoryList", categoryList);	
		
		// 회원 인증 주소 목록
		List<GpsAddressDto> addressList = gpsAddressDao.validList(memberNo);
		model.addAttribute("addressList", addressList);
		return "/auction/write";
	}
	
	// 경매 등록
	@PostMapping("/write")
	@ResponseBody
	public int write2(@ModelAttribute WriteAuctionVO writeAuctionVO, HttpSession session) throws IllegalStateException, IOException {	
		int memberNo = (int) session.getAttribute("whoLogin");
		auctionService.write(memberNo, writeAuctionVO);
		
		return auctionDao.recent(memberNo);
	}
	
	// 경매 물품 상세
	@GetMapping("/detail/{auctionNo}")
	public String detail(@PathVariable int auctionNo, HttpSession session, Model model) {
		int memberNo = (int) session.getAttribute("whoLogin");
		session.setAttribute("auctionNo", auctionNo);
		
		// 경매 상세 정보 조회
		AuctionDetailVO auctionDetail = auctionService.detail(memberNo, auctionNo);
		model.addAttribute("auctionDetail", auctionDetail);
		
		// 경매 사진 조회
		List<PhotoDto> photoList = photoDao.list(auctionNo);
		model.addAttribute("photoList", photoList);
		
		// 입찰 가능 여부 확인 (인증 주소)
		Map<String, Integer> info = new HashMap<>();
		info.put("memberNo", memberNo);
		info.put("auctionNo", auctionNo);
		model.addAttribute("checkAddress", gpsAddressDao.checkBiddingAddress(info));
		
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
	
	// 입찰
	@ResponseBody
	@PostMapping("/detail/bidding")
	public AuctionDetailRefreshVO bidding(@RequestBody BiddingDto biddingDto)  {
		AuctionDetailRefreshVO refresh = auctionService.bidding(biddingDto);
		return refresh;
	}
	
	// 즉시 낙찰
	@ResponseBody
	@PostMapping("/detail/bidding/close")
	public AuctionDetailRefreshVO closeBidding(@RequestBody BiddingDto biddingDto)  {
		AuctionDetailRefreshVO refresh = auctionService.bidding(biddingDto);
		successfulBidDao.insert(auctionDao.close(biddingDto.getAuctionNo())); 
		return refresh;
	}
	
	// 경매 취소
	@GetMapping("/detail/cancel/{auctionNo}")
	public String cancel(@PathVariable int auctionNo)  {
		auctionDao.setPrivate(auctionNo); // 경매 비공개
		return "redirect:/"; // 임시 // 추후 마이페이로 이동
	}
	
	// 경매 정지
	@GetMapping("/detail/stop/{auctionNo}")
	public String stop(@PathVariable int auctionNo, HttpSession session)  {
		int memberNo = (int) session.getAttribute("whoLogin");
		memberDao.plusRedCount(memberNo); // 회원 경고 횟수 +1
		auctionDao.setPrivate(auctionNo); // 경매 비공개
		return "redirect:/"; // 임시 // 추후 마이페이로 이동
	}
	
	// 경매 신고
	@ResponseBody
	@PostMapping("/detail/report")
	public void report(@RequestBody AuctionReportDto auctionReportDto)  {
		auctionReportDao.report(auctionReportDto); 
	}
	
}
