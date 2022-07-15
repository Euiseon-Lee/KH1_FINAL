package com.an.auctionara.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.an.auctionara.entity.AttachmentDto;
import com.an.auctionara.entity.AuctionDto;
import com.an.auctionara.entity.PhotoDto;
import com.an.auctionara.repository.AttachmentDao;
import com.an.auctionara.repository.AuctionDao;
import com.an.auctionara.repository.AuctionReportDao;
import com.an.auctionara.repository.PhotoDao;
import com.an.auctionara.vo.AdminAuctionDetailReportVO;
import com.an.auctionara.vo.AdminAuctionDetailVO;
import com.an.auctionara.vo.AdminAuctionListVO;
import com.an.auctionara.vo.AuctionReportListVO;
import com.an.auctionara.vo.CashingPointsListVO;

@Controller
@RequestMapping("/admin/auction")
public class AdminAuctionController {

	@Autowired
	private AuctionReportDao auctionReportDao;
	
	@Autowired
	private AuctionDao auctionDao; 
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	@Autowired
	private PhotoDao photoDao; 
	
	
	@GetMapping("/report_list")
	public String reportList(
			@RequestParam(required = false) String type,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false, defaultValue = "1") int p,  
			@RequestParam(required = false, defaultValue = "10") int s,
			Model model) {
		List<AuctionReportListVO> list = auctionReportDao.reportList(type, keyword, p, s); 
		model.addAttribute("list", list);
		
		boolean search = type != null && keyword != null;
		model.addAttribute("search", search);
		
		int count = auctionReportDao.count(type, keyword);
		
		int lastPage = (count + s -1) / s; 
		int blockSize = 10; 
		int endBlock = (p + blockSize -1) / blockSize * blockSize;
		int startBlock = endBlock - (blockSize -1);
		
		if(endBlock > lastPage) {
			endBlock = lastPage;
		}
		
		model.addAttribute("p", p);
		model.addAttribute("s", s);
		model.addAttribute("type", type);
		model.addAttribute("keyword",keyword);
		model.addAttribute("startBlock", startBlock);
		model.addAttribute("endBlock", endBlock);
		model.addAttribute("lastPage", lastPage);
		
		return "admin/auction/report_list";
	}
	
	@GetMapping("/list")
	public String list(
			@RequestParam(required = false) String type,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false, defaultValue = "1") int p,  
			@RequestParam(required = false, defaultValue = "10") int s,
			Model model) {
		List<AdminAuctionListVO> list = auctionDao.adminList(type, keyword, p, s);
		model.addAttribute("list", list);
		
		
		boolean search = type != null && keyword != null;
		model.addAttribute("search", search);
		
		int count = auctionDao.adminListCount(type, keyword);
		
		int lastPage = (count + s -1) / s; 
		int blockSize = 10; 
		int endBlock = (p + blockSize -1) / blockSize * blockSize;
		int startBlock = endBlock - (blockSize -1);
		
		if(endBlock > lastPage) {
			endBlock = lastPage;
		}
		
		model.addAttribute("p", p);
		model.addAttribute("s", s);
		model.addAttribute("type", type);
		model.addAttribute("keyword",keyword);
		model.addAttribute("startBlock", startBlock);
		model.addAttribute("endBlock", endBlock);
		model.addAttribute("lastPage", lastPage);
		
		return "admin/auction/list";
	}
	
	@GetMapping("/detail/{auctionNo}")
	public String detail(
			@PathVariable int auctionNo,
			Model model) {
		AdminAuctionDetailVO adminAuctionDetailVO = auctionDao.adminAuctionDetail(auctionNo);
		model.addAttribute("adminAuctionDetailVO", adminAuctionDetailVO);
		model.addAttribute("profileUrl", "/attachment/download?attachmentNo=" + adminAuctionDetailVO.getPhotoAttachmentNo());
		
		List<PhotoDto> photoList = photoDao.list(auctionNo);
		model.addAttribute("photoList", photoList);
		
		return "admin/auction/detail";
	}
	
	@GetMapping("/report_detail")
	public String reportDetail(
			@RequestParam int auctionNo,
			Model model) {
		List<AdminAuctionDetailReportVO> list = auctionReportDao.detailReportList(auctionNo);
		model.addAttribute("detailReportList", list);
		
		AdminAuctionDetailVO vo = auctionDao.adminAuctionDetail(auctionNo);
		model.addAttribute("auctionTitle", vo.getAuctionTitle());
		model.addAttribute("auctionPrivate", vo.getAuctionPrivate());
		model.addAttribute("auctionNo", auctionNo);
		
		return "admin/auction/report_detail"; 
	}
	
	@GetMapping("/open/{auctionNo}")
	public String openAuction(@PathVariable int auctionNo) {
		AuctionDto auctionDto = auctionDao.setOpen(auctionNo);
		
		return "redirect: /auctionara/admin/auction/report_detail?auctionNo=" + auctionNo;
	}
	
	@GetMapping("/private/{auctionNo}")
	public String privateAuction(@PathVariable int auctionNo) {
		AuctionDto auctionDto = auctionDao.setPrivate(auctionNo);
		
		return "redirect: /auctionara/admin/auction/report_detail?auctionNo=" + auctionNo; 
	}
}
