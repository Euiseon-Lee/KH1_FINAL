package com.an.auctionara.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.MemberDao;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {

	@Autowired
	private MemberDao memberDao; 
	
	@GetMapping("/list")
	public String list(
			@RequestParam(required = false) String type,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false, defaultValue = "1") int p,  
			@RequestParam(required = false, defaultValue = "10") int s,
			Model model) {
		
		List<MemberDto> list = memberDao.list(type, keyword, p, s);
		model.addAttribute("list", list);
		
		boolean search = type != null && keyword != null;
		model.addAttribute("search", search);
		
		int count = memberDao.count(type, keyword);
		
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
		
		return "admin/member/list";
	}
	
	@GetMapping("detail/{memberNo}")
	public String detail(@PathVariable int memberNo, Model model) {
		MemberDto memberDto = memberDao.memberSearch(memberNo);
		model.addAttribute("memberDto", memberDto);
		
		return "/admin/member/detail";
	}
}
