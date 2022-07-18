package com.an.auctionara.controller;

import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.an.auctionara.entity.SuccessfulBidDto;
import com.an.auctionara.paymentvo.CashingPointsVO;
import com.an.auctionara.paymentvo.KakaoPayApproveRequestVO;
import com.an.auctionara.paymentvo.KakaoPayApproveResponseVO;
import com.an.auctionara.paymentvo.KakaoPayCancelRequestVO;
import com.an.auctionara.paymentvo.KakaoPayCancelResponseVO;
import com.an.auctionara.paymentvo.KakaoPayReadyRequestVO;
import com.an.auctionara.paymentvo.KakaoPayReadyResponseVO;
import com.an.auctionara.paymentvo.PaymentInsertVO;
import com.an.auctionara.paymentvo.PurchaseVO;
import com.an.auctionara.repository.MemberDao;
import com.an.auctionara.repository.PaymentDao;
import com.an.auctionara.service.KakaoPayService;
import com.an.auctionara.service.PaymentService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/payment")
public class PayController {

	
	@Autowired
	private KakaoPayService kakaoPayService;
	
	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private MemberDao memberDao;
	

	
	@PostMapping("/charge")
	public String pay1Purchase(
				@ModelAttribute PurchaseVO purchaseVO, HttpSession session
			) throws URISyntaxException {
		
		//결제 준비(ready) 요청을 진행
		int paymentNo = paymentDao.paymentSequence();
		KakaoPayReadyRequestVO requestVO = 
									KakaoPayReadyRequestVO.builder()
												.partner_order_id(String.valueOf(paymentNo))
												.partner_user_id(String.valueOf(session.getAttribute("whoLogin")))
												.item_name("경매나라 충전")
												.total_amount(purchaseVO.getChargeMoney())
											.build();
		KakaoPayReadyResponseVO responseVO = kakaoPayService.ready(requestVO);
		
		//결제성공 페이지에서 승인요청을 보내기 위해 알아야할 데이터 3개를 세션에 임시로 추가한다
		//-> 결제가 성공할지 실패할지 취소될지 모르기 때문에 모든 경우에 추가한 데이터를 지워야 한다
		session.setAttribute("pay", KakaoPayApproveRequestVO.builder()
																.tid(responseVO.getTid())
																.partner_order_id(requestVO.getPartner_order_id())
																.partner_user_id(requestVO.getPartner_user_id())
															.build());
		//추가적으로 결제성공 페이지에서 완료정보를 등록하기 위해 알아야 할 상품구매개수 정보를 같이 전달
		session.setAttribute("purchase", purchaseVO);//상품이 1개라면
		//session.setAttribute("purchase", Arrays.asList(purchaseVO));//1.8부터
		
		//결제 번호도 세션으로 전달
		session.setAttribute("paymentNo", paymentNo);
		
		return "redirect:"+responseVO.getNext_redirect_pc_url();
	}
	
	
	
	//승인/취소/실패 : 카카오 API에 신청한 URL로 처리
	@GetMapping("/approve")
	public String paySuccess(@RequestParam String pg_token, HttpSession session) throws URISyntaxException {
		//세션에 추가된 정보를 받고 세션에서 삭제한다(tid, partner_order_id, partner_user_id)
		// -> 취소 , 실패 , 성공 모두다 삭제하도록 처리
		KakaoPayApproveRequestVO requestVO = 
									(KakaoPayApproveRequestVO) session.getAttribute("pay");
		session.removeAttribute("pay");
		
		PurchaseVO purchaseVO = (PurchaseVO) session.getAttribute("purchase");
		
		int paymentNo = (int) session.getAttribute("paymentNo");
		
		//주어진 정보를 토대로 승인(approve) 요청을 보낸다
		requestVO.setPg_token(pg_token);
		KakaoPayApproveResponseVO responseVO = kakaoPayService.approve(requestVO);
		paymentService.insert(paymentNo, responseVO, purchaseVO);
		
//		return "redirect:/pay/finish";
		return "redirect:finish";
	}
	
	@GetMapping("/finish")
	public String payFinish(HttpSession session, Model model) {
		int paymentNo = (int) session.getAttribute("paymentNo");
		session.removeAttribute("paymentNo");
		model.addAttribute("success", paymentService.successOne(paymentNo));
		return "payment/finish";
	}
	
	@GetMapping("/cancel")
	public String payCancel(HttpSession session) {
		session.removeAttribute("pay");
		session.removeAttribute("purchase");
		session.removeAttribute("paymentNo");
		return "payment/cancel";
	}
	
	@GetMapping("/fail")
	public String payFail(HttpSession session) {
		session.removeAttribute("pay");
		session.removeAttribute("purchase");
		session.removeAttribute("paymentNo");
		return "payment/fail";
	}

	@GetMapping("/refund/{paymentNo}")
	public String refund(HttpSession session, @PathVariable int paymentNo) throws URISyntaxException {
		int memberNo = (int)session.getAttribute("whoLogin");
		
		PaymentInsertVO paymentInsertVO = paymentService.selectOne(paymentNo);
		
		//카카오페이에 취소 요청
		KakaoPayCancelRequestVO requestVO = KakaoPayCancelRequestVO.builder()
																					.tid(paymentInsertVO.getPaymentTid())
																					.cancel_amount(paymentInsertVO.getPaymentPrice())
																					.build();
		KakaoPayCancelResponseVO responseVO = kakaoPayService.cancel(requestVO);
		
		paymentService.refund(paymentNo);
		
		return "redirect:/mypage/payment/list";
	}

	@PostMapping("/cashingRequest")
	public String cashingRequest(HttpSession session,
			@ModelAttribute CashingPointsVO cashingPointsVO) {
		int memberNo = (int)session.getAttribute("whoLogin");
		cashingPointsVO.setMemberNo(memberNo);
		boolean success = paymentService.cashingRequest(cashingPointsVO);
		if(success) {
			return "redirect:cashingSuccess";
		}else {
			return "redirect:cashingFail";
		}
	}
	@GetMapping("/cashingSuccess")
	public String cashingSuccess() {
		return "payment/cashingSuccess";
	}
	@GetMapping("/cashingFail")
	public String cashingFail() {
		return "payment/cashingFail";
	}

	@GetMapping("/paying/{auctionNo}")
	public String paying(HttpSession session, @PathVariable int auctionNo) {
		log.info("======1=====");
		int memberNo = (int)session.getAttribute("whoLogin");
		boolean enoughPoint = paymentService.enoughPoint(memberNo, auctionNo);
		log.info("======2=====");
		if(enoughPoint) {
			paymentService.pointPaying(memberNo, auctionNo);
			log.info("======3=====");
			return "payment/auctionFinish";
		}else {
			log.info("======4=====");
			return"redirect:/payment/paymentReady/"+auctionNo;
		}
	}
	@GetMapping("/paymentReady/{auctionNo}")
	public String paymentReadyAuction(HttpSession session, Model model ,@PathVariable int auctionNo) {
		int memberNo = (int)session.getAttribute("whoLogin");
		model.addAttribute("memberDto", memberDao.selectOne(memberNo));
		model.addAttribute("bidDto", paymentService.bidSelect(auctionNo));
		model.addAttribute("auctionNo", auctionNo);
		return "payment/paymentReadyAuction";
	}
	
	@GetMapping("/paymentReady")
	public String pay1Purchase(HttpSession httpSession, Model model) {
		int memberNo = (int) httpSession.getAttribute("whoLogin");
		
		model.addAttribute("memberDto", memberDao.selectOne(memberNo));
		return "payment/paymentReady";
	}
	@GetMapping("/list")
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

	@GetMapping("/cashingList")
	public String cashingList(HttpSession session, Model model) {
		model.addAttribute("cashingList", paymentService.cashingList((int)session.getAttribute("whoLogin")));
		model.addAttribute("memberDto", memberDao.selectOne((int)session.getAttribute("whoLogin")));
		return "/payment/cashingList";
	}
}	