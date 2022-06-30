package com.an.auctionara.controller;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestAttributes;
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
			@ModelAttribute MemberDto memberDto,
			HttpServletRequest request
			) {
		String year = request.getParameter("yy");
		String month = request.getParameter("mm");
		String day = request.getParameter("dd");
		String birth = year+month+day;
		
		memberDto.setMemberBirth(birth);
		
		memberDao.join(memberDto);
		
		return "redirect:/member/join_success";
	}
	
	@GetMapping("/join_success")
	public String joinSuccess() {
		return "member/join_success";
	}
	
	@GetMapping("/login")
	public String login(
				@RequestHeader(value="Referer", defaultValue="/") String referer,
				Model model
			) {
		
		model.addAttribute("referer", referer);
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(
				@RequestParam String memberEmail,
				@RequestParam String memberPw,
				@RequestParam String referer,
				HttpSession session
			) {
		MemberDto memberDto = memberDao.login(memberEmail, memberPw);
		
		if(memberDto != null) {
			session.setAttribute("whoLogin", memberDto.getMemberNo());
			session.setAttribute("auth", memberDto.getMemberGrade());
			
			
			return "redirect:"+referer;
		}
		else {
			return "redirect:login?fail";
		}	
		
	}
	
}
