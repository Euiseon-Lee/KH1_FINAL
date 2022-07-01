package com.an.auctionara.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.an.auctionara.entity.CashingPointsDto;
import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.CashingPointsDao;
import com.an.auctionara.repository.MemberDao;
import com.an.auctionara.vo.CashingPointsListVO;


@Controller
@RequestMapping("/admin/cashing")
public class AdminCashingController {
	
	@Autowired
	private CashingPointsDao cashingPointsDao;
	
	
	// 현금화 관련 전체 목록 
	@GetMapping("/list")
	public String list(
			@RequestParam(required = false) String type,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false, defaultValue = "1") int p,
			@RequestParam(required = false, defaultValue = "10") int s,
			Model model) {
		
		List<CashingPointsListVO> list = cashingPointsDao.list(type, keyword, p, s);
		model.addAttribute("list", list);
		
		
		boolean search = type != null && keyword != null;
		model.addAttribute("search", search);
		
		int count = cashingPointsDao.count(type, keyword);
		
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
		
		return "admin/cashing/list"; 
	}
	
	// 현금화 신청 목록 
	@GetMapping("/request_list")
	public String requestList(Model model) {
		List<CashingPointsListVO> requestList = cashingPointsDao.requestList();
		model.addAttribute("requestList", requestList);
		
		return "admin/cashing/request_list";
	}
	
	// 현금화 승인
	@GetMapping("/approve/{cashingNo}")
	public String approveCashing(@PathVariable int cashingNo) {
		CashingPointsDto cashingPointsDto = cashingPointsDao.approveCashing(cashingNo);
		
		return "redirect: /auctionara/admin/cashing/request_list";
	}
	
	// 현금화 거절 
	@GetMapping("/refuse/{cashingNo}")
	public String refuseCashing(@PathVariable int cashingNo) {
		CashingPointsDto cashingPointsDto = cashingPointsDao.refuseCashing(cashingNo);
		
		return "redirect: /auctionara/admin/cashing/request_list"; 
	}
}
