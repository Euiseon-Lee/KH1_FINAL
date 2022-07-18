package com.an.auctionara.controller;

import java.io.IOException;
import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.AutologinDao;
import com.an.auctionara.repository.MemberDao;
import com.an.auctionara.service.MemberService;
import com.an.auctionara.service.PaymentService;
import com.an.auctionara.vo.MemberVO;
import com.an.auctionara.vo.MyAuctionVO;
import com.an.auctionara.vo.MyBiddingVO;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AutologinDao autologinDao;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PaymentService paymentService;
	
	@GetMapping("/index")
	public String mypageIndex(HttpSession session, Model model) {
		int memberNo = (int) session.getAttribute("whoLogin");
		MemberVO memberVO = memberService.mypage(memberNo);
		model.addAttribute("memberVO", memberVO);
		
		int attachmentNo = memberVO.getAttachmentNo();
		
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
		int memberNo = (int) session.getAttribute("whoLogin");
		
		MemberDto memberDto = memberDao.memberSearch(memberNo);
		model.addAttribute("memberDto", memberDto);
		
		int attachmentNo = memberDto.getAttachmentNo();	
		model.addAttribute("profileUrl", "/attachment/download?attachmentNo=" + attachmentNo);
		
		
		return "mypage/info";
	}
	
	@PostMapping("/info")
	public String info(
			@ModelAttribute MemberDto memberDto,
			MultipartFile attachment,
			HttpServletRequest request
			) throws IllegalStateException, IOException {
		String week = request.getParameter("week");
		String begin = request.getParameter("begin");
		String end = request.getParameter("end");
		
		
		String memberPreference = week+", "+begin+" ~ "+end;
		memberDto.setMemberPreference(memberPreference);
		
		boolean success = memberService.info(memberDto, attachment);
		
		if(success) return "redirect:/mypage/info";
		else return "redirect:mypage/info?error";
		
	}
	
	
	@GetMapping("/exit")
	public String exit(HttpSession session, Model model) {
		int memberNo = (int) session.getAttribute("whoLogin");
		
		MemberDto memberDto = memberDao.memberSearchforExit(memberNo);
		model.addAttribute("memberDto", memberDto);
		
		return "mypage/exit";
	}
	
	@PostMapping("/exit")
	public String exit(
					@RequestParam String memberEmail,
					@RequestParam String memberPw,
					HttpServletResponse response,
					HttpSession session) {
		int memberNo = (int) session.getAttribute("whoLogin");
		boolean success = memberService.exit(memberNo, memberEmail, memberPw);
		if(success) {
			
			//아이디저장기능 제거
			Cookie ck = new Cookie("saveId","");
			ck.setMaxAge(0);
			ck.setPath("/");
			response.addCookie(ck);
			
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
			Cookie auto = new Cookie("autologin", "");
		    auto.setMaxAge(0);
		    auto.setPath("/");
		    response.addCookie(auto);
	  		
	  		//자동로그인 토큰을 DB에서 제거	    
	  		autologinDao.deleteToken(memberNo);	
		    
	  		
			//세션정보 제거
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
	
	// 내 경매 이력 리스트 출력
	@ResponseBody
	@GetMapping("/auction_history/list")
	public List<MyAuctionVO> auctionList(@RequestParam int page,
											@RequestParam Integer filter,
											@RequestParam Integer sort,
											@RequestParam(required = false) Integer categoryNo,
											@RequestParam(required = false) String keyword,
											HttpSession session) {
		int auctioneerNo = (int) session.getAttribute("whoLogin");
		List<MyAuctionVO> list = memberService.auctionList(auctioneerNo, page, filter, sort, categoryNo, keyword);
		return list;
	}
	
	// 내 입찰 이력 리스트 출력
	@ResponseBody
	@GetMapping("/pay_history/list")
	public List<MyBiddingVO> biddingList(@RequestParam int page,
											@RequestParam Integer filter,
											@RequestParam Integer sort,
											@RequestParam(required = false) Integer categoryNo,
											@RequestParam(required = false) String keyword,
											HttpSession session) {
		int bidderNo = (int) session.getAttribute("whoLogin");
		List<MyBiddingVO> list = memberService.biddingList(bidderNo, page, filter, sort, categoryNo, keyword);
		return list;
	}
	
	@GetMapping("/paymentReady")
	public String pay1Purchase(HttpSession httpSession, Model model) {
		int memberNo = (int) httpSession.getAttribute("whoLogin");
		
		model.addAttribute("memberDto", memberDao.selectOne(memberNo));
		return "payment/paymentReady";
	}
	@GetMapping("/payment/list")
	public String payList(HttpSession session, Model model) {
		int memberNo = (int) session.getAttribute("whoLogin");
		model.addAttribute("allList", paymentService.allList(memberNo));
		model.addAttribute("refundList", paymentService.refundList(memberNo));
		return "payment/list";
	}
	@GetMapping("/cashing")
	public String cashing(HttpSession session, Model model) {
		model.addAttribute("memberDto", memberDao.selectOne((int)session.getAttribute("whoLogin")));
		return "payment/cashing";
	}
}
