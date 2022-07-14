package com.an.auctionara.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.an.auctionara.entity.ChatContentDto;
import com.an.auctionara.repository.ChatDao;
import com.an.auctionara.repository.ChatRoomDao;
import com.an.auctionara.vo.ChatRoomListVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ChatController {
	private final String path = "C:/test";
	private final ChatRoomDao chatRoomDao;
	private final ChatDao chatDao;
	//view 컨트롤러에도 뽑아갈 거 있다 잊지말자
	
	@GetMapping("/chat/download")
	public ResponseEntity<ByteArrayResource> download(@RequestParam String fileName) throws IOException{
		File target = new File(path, fileName);
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource  byteArrayResource = new ByteArrayResource(data);
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(target.length())
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment()
						.filename(fileName, StandardCharsets.UTF_8)
						.build().toString())
				.body(byteArrayResource);
	
	}
	
	@GetMapping("/chat")
	public String chatIndex(HttpSession httpSession, Model model) {
		//int memberNo = (int)httpSession.getAttribute("whoLogin");
//		model.addAttribute("chatRoomListVO", chatRoomDao.list(memberNo));

		return "chat/chat";
	}
	//post로 바꾸기
	@GetMapping("/chat/{auctionNo}/{auctioneerNo}")
	public String chatTry(HttpSession httpSession, Model model, 
			@PathVariable("auctionNo") int auctionNo, 
			@PathVariable("auctioneerNo") int auctioneerNo) {
		int memberNo = (int)httpSession.getAttribute("whoLogin");
		
		int chatRoomNo = chatRoomDao.isJoin(auctionNo, memberNo, auctioneerNo);
		model.addAttribute("chatRoomNo", chatRoomNo);			
		return "chat/chat";
	}
	
	@ResponseBody
	@GetMapping("/chat/list")
	@CrossOrigin(origins = "*")
	public List<ChatRoomListVO> list(HttpSession httpSession) {
		return chatRoomDao.list((int) httpSession.getAttribute("whoLogin"));
	}
	@ResponseBody
	@GetMapping("/chat/talk/{chatRoomNo}")
	@CrossOrigin(origins = "*")
	public List<ChatContentDto> talk(Model model, @PathVariable int chatRoomNo){
		model.addAttribute("chatRoomNo", chatRoomNo);
		return chatDao.list(chatRoomNo);
	}
	
	
//	@GetMapping("/chat/{auctionNo}")
//	public String channel(Model model, HttpSession session, @PathVariable int auctionNo) {
//		int memberNo = (int) session.getAttribute("whoLogin");
//		
//		List<>
//		model.addAttribute(chatRoomDto);
//		return "chat/chat";
//	}
			
}
