package com.an.auctionara.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.an.auctionara.entity.ChatContentDto;
import com.an.auctionara.entity.ChatReportDto;
import com.an.auctionara.entity.MemberRatingDto;
import com.an.auctionara.entity.RatingDto;
import com.an.auctionara.repository.ChatContentDao;
import com.an.auctionara.repository.ChatRoomDao;
import com.an.auctionara.repository.MemberRatingDao;
import com.an.auctionara.repository.RatingDao;
import com.an.auctionara.repository.SuccessfulBidDao;
import com.an.auctionara.vo.CheckRatingVO;

@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	private ChatRoomDao chatRoomDao;
	
	@Autowired
	private ChatContentDao chatContentDao;
	
	@Autowired
	private SuccessfulBidDao successfulBidDao;
	
	@Autowired
	private RatingDao ratingDao;
	
	@Autowired
	private MemberRatingDao memberRatingDao;

	// 채팅 메인
	@GetMapping
	public String chatIndex(Model model, HttpSession httpSession) {
		int memberNo = (int) httpSession.getAttribute("whoLogin");
		model.addAttribute("chatRoomList", chatRoomDao.list(memberNo)); // 채팅방 리스트 출력
		return "/chat/chat";
	}
	
	// 판매자와 채팅 시작
	@GetMapping("/{auctionNo}")
	public String startChat(@PathVariable("auctionNo") int auctionNo, Model model, HttpSession httpSession) {
		int memberNo = (int) httpSession.getAttribute("whoLogin");
		model.addAttribute("chatRoomNo", chatRoomDao.join(auctionNo, memberNo));
		model.addAttribute("chatRoomList", chatRoomDao.list(memberNo));
		return "/chat/chat";
	}
	
	// 낙찰자와 채팅 시작
	@GetMapping("/auctioneer/{auctionNo}")
	public String startSuccChat(@PathVariable("auctionNo") int auctionNo, Model model, HttpSession httpSession) {
		int memberNo = (int) httpSession.getAttribute("whoLogin");
		model.addAttribute("chatRoomNo", chatRoomDao.search(auctionNo));
		model.addAttribute("chatRoomList", chatRoomDao.list(memberNo));
		return "/chat/chat";
	}	
	
	// 채팅 이력 출력
	@GetMapping("/talk/{chatRoomNo}")
	@ResponseBody
	public List<ChatContentDto> talk(Model model, @PathVariable int chatRoomNo, HttpSession httpSession){
		int chatterNo = (int) httpSession.getAttribute("whoLogin");
		chatContentDao.read(chatterNo, chatRoomNo); // 상대방 채팅 읽음 처리
		model.addAttribute("chatRoomNo", chatRoomNo);
		return chatContentDao.list(chatRoomNo);
	}
	
	// 보낸 채팅 메세지 저장
	@PostMapping("/save")
	@ResponseBody
	public void save(@RequestBody ChatContentDto chatContentDto) {
		chatContentDao.save(chatContentDto);
	}
	
	// 결제 완료 및 거래완료 및 평가 여부 확인
	@GetMapping("/check/{auctionNo}")
	@ResponseBody
	public CheckRatingVO checkRating(@PathVariable("auctionNo") int auctionNo) {
		return successfulBidDao.checkRating(auctionNo);
	}
	
	// 판매자 거래 완료
	@GetMapping("/auctioneer/approve/{auctionNo}")
	@ResponseBody
	public void auctioneerApprove(@PathVariable("auctionNo") int auctionNo) {
		successfulBidDao.auctioneerApprove(auctionNo);
	}
	
	// 구매자 거래 완료
	@GetMapping("/bidder/approve/{auctionNo}")
	@ResponseBody
	public void bidderApprove(@PathVariable("auctionNo") int auctionNo) {
		successfulBidDao.bidderApprove(auctionNo);
	}
	
	// 평가 항목 출력
	@GetMapping("/rating/list")
	@ResponseBody
	public List<RatingDto> ratingList() {
		return ratingDao.list();
	}
	
	// 평가 저장
	@PostMapping("/rating/save")
	@ResponseBody
	public void saveRating(@RequestBody MemberRatingDto memberRatingDto) {
		memberRatingDao.save(memberRatingDto);
	}
	
	// 채팅 신고
	@PostMapping("/report")
	@ResponseBody
	public void report(@RequestBody ChatReportDto chatReportDto) {
		chatRoomDao.report(chatReportDto);
	}	
}
