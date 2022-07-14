package com.an.auctionara.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.MemberDao;
import com.an.auctionara.service.MemberService;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MemberService memberService;
	
	
	@GetMapping("/index")
	public String mypageIndex(HttpSession session, Model model) {
		int memberNo = (int) session.getAttribute("whoLogin");
		
		MemberDto memberDto = memberDao.memberSearch(memberNo);
		model.addAttribute("memberDto", memberDto);
		
		int attachmentNo = memberDto.getAttachmentNo();
		
		if(attachmentNo == 0) {
			model.addAttribute("profileUrl", "/image/user.png");
		}
		else {
			model.addAttribute("profileUrl", "/attachment/download?attachmentNo=" + attachmentNo);
		}
		
		
		return "mypage/index";
	}
	
	@GetMapping("/info")
	public String info(HttpSession session, Model model) {
		return "mypage/info";
	}
	
	
	
	@GetMapping("/exit")
	public String exit(HttpSession session, Model model) {
		int memberNo = (int) session.getAttribute("whoLogin");
		
		MemberDto memberDto = memberDao.memberSearch(memberNo);
		model.addAttribute("memberDto", memberDto);
		
		return "mypage/exit";
	}
	
	@PostMapping("/exit")
	public String exit(
					@RequestParam String memberEmail,
					@RequestParam String memberPw,
					HttpSession session) {
		
		boolean success = memberDao.exit(memberEmail, memberPw);
		if(success) {
			session.removeAttribute("whoLogin");
			session.removeAttribute("auth");
			return "redirect:exit_finish";
		}
		else {
			return "redirect:exit?error";
		}
	}
	
	@GetMapping("/exit_finish")
	public String exitFinish() {
		return "mypage/exit_finish";
	}
	
	
	
	@GetMapping("/auction_history")
	public String auctionHistory(HttpSession session, Model model) {
		return "mypage/auction_history";
	}
	
	@GetMapping("/pay_history")
	public String payHistory(HttpSession session, Model model) {
		return "mypage/pay_history";
	}
	
	@GetMapping("/cash_log")
	public String cashLog(HttpSession session, Model model) {
		return "mypage/cash_log";
	}
	
	
}
