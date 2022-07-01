package com.an.auctionara.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.an.auctionara.repository.AuctionReportDao;
import com.an.auctionara.vo.AuctionReportListVO;

@Controller
@RequestMapping("/admin/auction")
public class AdminAuctionController {

	@Autowired
	private AuctionReportDao auctionReportDao;
	
	@GetMapping("/report_list")
	public String reportList(
			@RequestParam(required = false, defaultValue = "1") int p,  
			@RequestParam(required = false, defaultValue = "10") int s,
			Model model) {
		List<AuctionReportListVO> list = auctionReportDao.reportList(p, s); 
		model.addAttribute("list", list);
		
		int count = auctionReportDao.count();
		
		int lastPage = (count + s -1) / s; 
		int blockSize = 10; 
		int endBlock = (p + blockSize -1) / blockSize * blockSize;
		int startBlock = endBlock - (blockSize -1);
		
		if(endBlock > lastPage) {
			endBlock = lastPage;
		}
		
		model.addAttribute("p", p);
		model.addAttribute("s", s);
		model.addAttribute("startBlock", startBlock);
		model.addAttribute("endBlock", endBlock);
		model.addAttribute("lastPage", lastPage);
		
		return "admin/auction/report_list";
	}
}
