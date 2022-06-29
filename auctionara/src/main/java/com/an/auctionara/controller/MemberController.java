package com.an.auctionara.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.MemberDao;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/join_intro")
	public String intro() {
		return "member/join_intro";
	}
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	
	//프로필 없이 구현 후 @RequestParam MultipartFile attachmentNo <- 추가할것
	@PostMapping("/join")
	public String join(
			@ModelAttribute MemberDto memberDto) {
		memberDao.join(memberDto);
		
		return "redirect:/member/join_success";
	}
	
	@GetMapping("/join_success")
	public String joinSuccess() {
		return "member/join_success";
	}
	
}
