package com.an.auctionara.controller;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.an.auctionara.entity.AutologinDto;
import com.an.auctionara.entity.CertDto;
import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.AutologinDao;
import com.an.auctionara.repository.CertDao;
import com.an.auctionara.repository.MemberDao;
import com.an.auctionara.service.AutologinService;
import com.an.auctionara.service.CertService;
import com.an.auctionara.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private AutologinDao autologinDao;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CertService certService;
	
	@Autowired
	private AutologinService autologinService;
	
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	
	//@RequestParam MultipartFile attachmentNo 추가완료
	@PostMapping("/join")
	public String join(
			@ModelAttribute MemberDto memberDto,
			MultipartFile attachment,
			HttpServletRequest request
			) throws IllegalStateException, IOException {
		
		memberService.join(memberDto, attachment);
		
		return "redirect:/member/join_success";
	}
	
	@GetMapping("/join_success")
	public String joinSuccess() {
		return "member/join_success";
	}
	
	@GetMapping("/login")
	public String login() {
		
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(
				@RequestParam String memberEmail,
				@RequestParam String memberPw,
				@RequestParam(required=false) String remember,
				@RequestParam(required=false) String autologin,
				HttpSession session,
				HttpServletRequest request,
				HttpServletResponse response
			) {

		
		MemberDto memberDto = memberDao.login(memberEmail, memberPw);
		
		if(memberDto == null) {
			
			return "redirect:login?fail";
		}
		
		else {
			int memberNo = memberDto.getMemberNo();

			if(memberDto != null) {
				//세션에 로그인 정보 추가
				session.setAttribute("whoLogin", memberNo);
				session.setAttribute("auth", memberDto.getMemberGrade());
				
				
				
				//로그인한 사용자의 정보 추출			
				//String userAgent = request.getHeader("user-agent");
				//log.debug("userAgent={}", userAgent);
				

				//사용자의 IP 추출
				String ip = (String)request.getHeader("X-Forwarded-For");
					if(ip == null || ip.length() == 0 || ip.toLowerCase().equals("unknown"))
						ip = (String)request.getRemoteAddr();

				//log.debug("ip = {}", ip);

				
				//자동로그인 처리
				if(autologin != null) {
				    
				    //토큰 발행			    
				    autologinService.issueToken(memberNo, ip);
				    
				    //토큰 확인 후 가져오기
				    AutologinDto autologinDto = autologinDao.returnToken(memberNo);
				    
				    
				    //DB에서 가져온 회원 번호를 암호화처리
				    String targetNo = autologinDao.memberNoforCookie(memberNo);
				    
				    //DB에 들어있는 ip를 암호화처리
				    String autoIp = autologinDao.autoIpforCookie(autologinDto.getAutoIp());
				    
				    
				    //토큰관련 정보를 쿠키에 넣기
				    Cookie tn = new Cookie("tn", targetNo);
				    Cookie it = new Cookie("it", autologinDto.getAutoToken());
				    Cookie tp = new Cookie("tp", autoIp);
				    
				    tn.setMaxAge(4*7*24*60*60);
				    it.setMaxAge(4*7*24*60*60);
				    tp.setMaxAge(4*7*24*60*60);
				    
				    tn.setPath("/");
				    it.setPath("/");
				    tp.setPath("/");
				    
				    response.addCookie(tn);
				    response.addCookie(it);
				    response.addCookie(tp);
				    
				    
				    
				    //쿠키에 자동로그인 체크 넣어두기
				    Cookie ck = new Cookie("autologin", "true");
				    ck.setMaxAge(4*7*24*60*60);
				    ck.setPath("/");
				    response.addCookie(ck);
				     
				}
				
				
				
				else {		//자동로그인 해제하고 로그인 시
					
				    //토큰관련 정보를 쿠키에 넣기 (제거)
				    Cookie tn = new Cookie("tn", "");
				    Cookie it = new Cookie("it", "");
				    Cookie tp = new Cookie("tp", "");
				    
				    tn.setMaxAge(0);
				    it.setMaxAge(0);
				    tp.setMaxAge(0);
				    
				    tn.setPath("/");
				    it.setPath("/");
				    tp.setPath("/");
				    
				    response.addCookie(tn);
				    response.addCookie(it);
				    response.addCookie(tp);
				    
					
					//쿠키에 자동로그인 체크 빼기
					Cookie ck = new Cookie("autologin", "");
				    ck.setMaxAge(0);
				    ck.setPath("/");
				    response.addCookie(ck);
				}
				
				
				
				
				
				
				//아이디 저장
				if(remember != null) {
					Cookie ck = new Cookie("saveId", memberDto.getMemberEmail());
					ck.setMaxAge(4*7*24*60*60);
					ck.setPath("/");
					response.addCookie(ck);				
				}
				
				else {
					Cookie ck = new Cookie("saveId", "");
					ck.setMaxAge(0);
					ck.setPath("/");
					response.addCookie(ck);
				}
				
			}
				return "redirect:/";		
		}
		
	}
	
	
	
	
	@RequestMapping("/logout")
	public String logout(
			HttpSession session,
			HttpServletResponse response
		) {
	    
	    //자동로그인 관련 정보 제거 
	    Cookie tn = new Cookie("tn", "");
	    Cookie it = new Cookie("it", "");
	    Cookie tp = new Cookie("tp", "");
	    
	    tn.setMaxAge(0);
	    it.setMaxAge(0);
	    tp.setMaxAge(0);
	    
	    tn.setPath("/");
	    it.setPath("/");
	    tp.setPath("/");
	    
	    response.addCookie(tn);
	    response.addCookie(it);
	    response.addCookie(tp);
	    
		
		//쿠키에 자동로그인 체크 빼기
		Cookie ck = new Cookie("autologin", "");
	    ck.setMaxAge(0);
	    ck.setPath("/");
	    response.addCookie(ck);
		
	    //세션에 있는 회원 번호 가져오기
  		int memberNo = (int) session.getAttribute("whoLogin");

  		
  		//자동로그인 토큰을 DB에서 제거	    
  		autologinDao.deleteToken(memberNo);	
	    
  		
		//세션정보 제거
		session.removeAttribute("whoLogin");
		session.removeAttribute("auth");
		
		return "redirect:/member/login";
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
		int result = memberDao.checkEmail(memberEmail);
		model.addAttribute("checkedEmail", memberEmail);
		
		if(result != 1) {
			return "redirect:check_email?fail";
		}
		else {
			return "redirect:check_email?success";
		}		
		
	}
	
	@GetMapping("/change_pw")
	public String changePw() {
		return "member/change_pw";
	}
	
	@PostMapping("/change_pw")
	public String changePw(
			@ModelAttribute MemberDto targetDto
			) throws MessagingException {
		int isMember = memberDao.checkEmail(targetDto.getMemberEmail());	
		
		if(isMember == 0) {
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

			model.addAttribute("newCertNo", newCertNo);
			
			return "member/reset";
			
		}
		
		else {
			return "error/404";
		}
		
		
	}
	
	
	@PostMapping("/reset")
	public String reset(
					@ModelAttribute MemberDto memberDto,
					@RequestParam String newCertNo
					) {
		
		boolean isIdentical = certDao.certifyCert(CertDto.builder()
								.certTarget(memberDto.getMemberEmail())
								.certNo(newCertNo)
							.build());
		

		
		if(isIdentical) {			
			
			boolean result = memberDao.resetPw(memberDto);
			if(result) {
				return "member/reset_success";
			}			
		}
		
		return "error/404";
	}
	
	
	
	@GetMapping("/reset_success")
	public String resetSuccess() {
		return "member/reset_success";
	}
	
	
}
