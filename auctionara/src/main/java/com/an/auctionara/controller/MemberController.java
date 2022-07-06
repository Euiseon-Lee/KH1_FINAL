package com.an.auctionara.controller;

import java.text.DecimalFormat;
import java.text.Format;
import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.an.auctionara.entity.CertDto;
import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.CertDao;
import com.an.auctionara.repository.MemberDao;
import com.an.auctionara.service.CertService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private CertService certService;
	
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
				@RequestParam(required=false) String remember,
				HttpSession session,
				HttpServletResponse response
			) {
		MemberDto memberDto = memberDao.login(memberEmail, memberPw);
		
		if(memberDto != null) {
			session.setAttribute("whoLogin", memberDto.getMemberNo());
			session.setAttribute("auth", memberDto.getMemberGrade());
			
			if(remember != null) {
				Cookie ck = new Cookie("saveId", memberDto.getMemberEmail());
				ck.setMaxAge(4*7*24*60*60);
				response.addCookie(ck);				
			}
			
			else {
				Cookie ck = new Cookie("saveId", memberDto.getMemberEmail());
				ck.setMaxAge(0);
				response.addCookie(ck);
			}			
			
			return "redirect:"+referer;
		}
		else {
			return "redirect:login?fail";
		}	
		
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("whoLogin");
		session.removeAttribute("auth");
		return "redirect:/";
	}
	
	@GetMapping("/check_email")
	public String checkEmail() {
		return "member/check_email";
	}
	
	
	
	@PostMapping("/check_email")
	public String checkEmail(
					@RequestParam String memberEmail,
					Model model
			) {
		int result = memberDao.checkEmailNum(memberEmail);
		model.addAttribute("memberEmailResult", memberEmail);
		
		if(result != 1) {
			return "member/check_email_result_fail";
		}
		else {
			return "member/check_email_result";
		}		
		
	}
	
	@GetMapping("/change_pw")
	public String changePw() {
		return "member/change_pw";
	}
	
	@PostMapping("/change_pw")
	public String changePw(@ModelAttribute MemberDto targetDto) throws MessagingException {
		boolean isMember = memberDao.checkMemberNo(targetDto.getMemberEmail());
		
		if(!isMember) {
			return "redirect:change_pw?fail";
		}
		
		else {
			certService.sendPwResetMail(targetDto);
			return "redirect:change_pw?success";
		}
	}
	
	
	private Random r = new Random();
	private Format f = new DecimalFormat("000000");	
	
	@GetMapping("/reset")
	public String resetPw(
				@RequestParam String memberEmail,
				@RequestParam String certNo,
				Model model) {
		
		CertDto certDto = CertDto.builder()
							.certTarget(memberEmail)
							.certNo(certNo)
							.build();
		
		boolean isIdentical = certDao.certifyCert(certDto);
		
		if(isIdentical) {
			
			String newCertNo = f.format(r.nextInt(1000000));
			certDao.makeCert(CertDto.builder()
								.certTarget(memberEmail)
								.certNo(newCertNo)
							.build()
					);
			
			model.addAttribute("certNo", newCertNo);
			
			return "member/reset";
			
		}
		
		else {
			return "member/check_email_result?error";		//추가 수정이 필요 (에러 처리)
		}
		
		
	}
	
	
	@PostMapping("/reset")
	public String reset(
					@ModelAttribute MemberDto memberDto,
					@RequestParam String certNo) {
		boolean isIdentical = certDao.certifyCert(CertDto.builder()
								.certTarget(memberDto.getMemberEmail())
								.certNo(certNo)
							.build());
		

		
		if(isIdentical == false) {
			
			boolean result = memberDao.resetPw(memberDto);
			if(result) {
				return "redirect:reset_success";
			}			
		}
		
		return "redirect:reset_fail";
	}
	
	
	
	@GetMapping("/reset_success")
	public String resetSuccess() {
		return "member/reset_success";
	}
	
	
}
