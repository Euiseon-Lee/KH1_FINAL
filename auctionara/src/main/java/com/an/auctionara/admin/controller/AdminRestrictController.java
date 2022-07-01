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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.an.auctionara.entity.ManagerRestrictionDto;
import com.an.auctionara.repository.ManagerRestrictionDao;
import com.an.auctionara.vo.CashingPointsListVO;
import com.an.auctionara.vo.ManagerRestrictionListVO;
import com.fasterxml.jackson.databind.annotation.JsonAppend.Attr;

@Controller
@RequestMapping("/admin/restriction")
public class AdminRestrictController {

	@Autowired
	private ManagerRestrictionDao managerRestrictionDao; 
	
	// 회원 제재 입력 페이지 
	@GetMapping("/restrict_member/{memberNo}")
	public String restrictMember(@PathVariable int memberNo, Model model) {
		model.addAttribute("memberNo", memberNo);
		
		return "admin/restriction/restrict_member";
	}
	
	// 회원 제재 입력 
	@PostMapping("/restrict_member/{memberNo}")
	public String restrictMember(@ModelAttribute ManagerRestrictionDto managerRestrictionDto) {
		managerRestrictionDao.restrictMember(managerRestrictionDto);
		
		return "redirect: /auctionara/admin/restriction/list";
	}
	
	// 회원 제재 내역 페이지 
	@GetMapping("/list")
	public String list(
			@RequestParam(required = false) String type,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false, defaultValue = "1") int p,  
			@RequestParam(required = false, defaultValue = "10") int s,
			Model model) {
		List<ManagerRestrictionListVO> list = managerRestrictionDao.list(type, keyword, p, s);
		model.addAttribute("list", list);
		
		
		boolean search = type != null && keyword != null;
		model.addAttribute("search", search);
		
		int count = managerRestrictionDao.count(type, keyword);
		
		System.out.println(count);
		
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
		
		return "admin/restriction/list";
	}
}
