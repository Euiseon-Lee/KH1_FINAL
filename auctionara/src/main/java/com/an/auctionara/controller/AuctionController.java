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
import com.an.auctionara.vo.AuctioneerInfoVO;
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
	
	// ?????? ?????? ?????????
	@GetMapping("/search")
	public String search(@RequestParam String keyword, Model model, HttpSession session) {
		int memberNo = (int) session.getAttribute("whoLogin");
		
		// ?????? ?????? ?????? ??????
		List<GpsAddressDto> address = gpsAddressDao.list(memberNo);
		if(address.size() == 2) {
			model.addAttribute("addressCount", true);
		} else {
			model.addAttribute("addressCount", false);
		}
		
		// ??? ?????? ??????
		model.addAttribute("address1", address.get(0));
		
		return "/auction/search";
	}
	
	// ??????????????? ?????? ?????????
	@GetMapping("/category")
	public String category(@RequestParam int categoryNo, Model model, HttpSession session) {
		int memberNo = (int) session.getAttribute("whoLogin");
		
		// ????????????
		List<CategoryDto> categoryList = categoryDao.list();
		model.addAttribute("categoryList", categoryList);
		
		// ?????? ?????? ?????? ??????
		List<GpsAddressDto> address = gpsAddressDao.list(memberNo);
		if(address.size() == 2) {
			model.addAttribute("addressCount", true);
		} else {
			model.addAttribute("addressCount", false);
		}
		
		return "/auction/category";
	}

	// ?????? ?????? ?????????
	@GetMapping("/write")
	public String write(Model model, HttpSession session) {
		int memberNo = (int) session.getAttribute("whoLogin");
		
		// ???????????? ??????
		List<CategoryDto> categoryList = categoryDao.list();
		model.addAttribute("categoryList", categoryList);	
		
		// ?????? ?????? ?????? ??????
		List<GpsAddressDto> addressList = gpsAddressDao.validList(memberNo);
		model.addAttribute("addressList", addressList);
		return "/auction/write";
	}
	
	// ?????? ??????
	@PostMapping("/write")
	@ResponseBody
	public int write2(@ModelAttribute WriteAuctionVO writeAuctionVO, HttpSession session) throws IllegalStateException, IOException {	
		int memberNo = (int) session.getAttribute("whoLogin");
		auctionService.write(memberNo, writeAuctionVO);
		
		return auctionDao.recent(memberNo);
	}
	
	// ?????? ?????? ??????
	@GetMapping("/detail/{auctionNo}")
	public String detail(@PathVariable int auctionNo, HttpSession session, Model model) {
		int memberNo = (int) session.getAttribute("whoLogin");
		session.setAttribute("auctionNo", auctionNo);
		
		// ?????? ?????? ?????? ??????
		AuctionDetailVO auctionDetail = auctionService.detail(memberNo, auctionNo);
		model.addAttribute("auctionDetail", auctionDetail);
		
		// ?????? ?????? ??????
		List<PhotoDto> photoList = photoDao.list(auctionNo);
		model.addAttribute("photoList", photoList);
		
		// ????????? ?????? ??????
		AuctioneerInfoVO auctioneerInfo = auctionDao.auctioneerInfo(auctionDetail.getAuctioneerNo());
		model.addAttribute("auctioneerInfo", auctioneerInfo);
		
		// ?????? ?????? ?????? ??????
		int succBidStatus = successfulBidDao.checkStatus(auctionNo);
		model.addAttribute("succBidStatus", succBidStatus);
		
		// ?????? ?????? ?????? ?????? (?????? ??????)
		Map<String, Integer> info = new HashMap<>();
		info.put("memberNo", memberNo);
		info.put("auctionNo", auctionNo);
		model.addAttribute("checkAddress", gpsAddressDao.checkBiddingAddress(info));
		
		return "/auction/detail";
	}

	// ?????? ?????? ?????? ????????????
	@ResponseBody
	@GetMapping("/detail/refresh")
	public AuctionDetailRefreshVO detailRefresh(@RequestParam int bidderNo, @RequestParam int auctionNo) {
		// ??????????????? ?????? ??????
		AuctionDetailRefreshVO refresh = biddingDao.refresh(bidderNo, auctionNo);
		return refresh;
	}	
	
	// ??????
	@ResponseBody
	@PostMapping("/detail/bidding")
	public AuctionDetailRefreshVO bidding(@RequestBody BiddingDto biddingDto)  {
		AuctionDetailRefreshVO refresh = auctionService.bidding(biddingDto);
		return refresh;
	}
	
	// ?????? ??????
	@ResponseBody
	@PostMapping("/detail/bidding/close")
	public AuctionDetailRefreshVO closeBidding(@RequestBody BiddingDto biddingDto)  {
		AuctionDetailRefreshVO refresh = auctionService.bidding(biddingDto);
		successfulBidDao.insert(auctionDao.close(biddingDto.getAuctionNo())); 
		return refresh;
	}
	
	// ?????? ??????
	@GetMapping("/detail/cancel/{auctionNo}")
	public String cancel(@PathVariable int auctionNo)  {
		auctionDao.auctionCancel(auctionNo); // ?????? ?????? & ?????????
		return "redirect:/mypage/auction_history";
	}
	
	// ?????? ??????
	@GetMapping("/detail/stop/{auctionNo}")
	public String stop(@PathVariable int auctionNo, HttpSession session)  {
		int memberNo = (int) session.getAttribute("whoLogin");
		memberDao.plusRedCount(memberNo); // ?????? ?????? ?????? +1
		auctionDao.auctionStop(auctionNo); // ?????? ?????? & ?????????
		return "redirect:/mypage/auction_history";
	}
	
	// ?????? ??????
	@ResponseBody
	@PostMapping("/detail/report")
	public void report(@RequestBody AuctionReportDto auctionReportDto)  {
		auctionReportDao.report(auctionReportDto); 
	}
	
}
