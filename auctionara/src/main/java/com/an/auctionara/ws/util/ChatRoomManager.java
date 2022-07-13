package com.an.auctionara.ws.util;

import java.io.IOException;
import java.util.Collections;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.ibatis.javassist.bytecode.ByteArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.an.auctionara.repository.ChatContentDao;
import com.an.auctionara.vo.ReceiveChatVO;
import com.an.auctionara.vo.ReceiveFileVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChatRoomManager {
	
	private Map<Integer, ChatRoom> rooms = Collections.synchronizedMap(new ConcurrentHashMap<>());

	private ChatRoom waitingRoom = new ChatRoom();

	private ObjectMapper mapper = new ObjectMapper();
	
	@Autowired
	private ChatContentDao chatContentDao;
	
	public void login(WebSocketSession session) {
		Member member = new Member(session);
		waitingRoom.enter(member);
	}
	public void enterChat(WebSocketSession session, int chatRoomNo) {
		Member member = new Member(session);
		waitingRoom.leave(member);
		
		if(notExist(chatRoomNo)) {
			createRoom(chatRoomNo);
		}
		log.info("chatRoomNo={}",chatRoomNo);
		getRoom(chatRoomNo).enter(member);
	}
	public void leave(WebSocketSession session) {
		Member member = new Member(session);
		if(waitingRoom.contains(member)) {
			waitingRoom.leave(member);
		}
		for(int chatRoomNo:rooms.keySet()) {
			ChatRoom chatRoom = getRoom(chatRoomNo);
			if(chatRoom.contains(member)) {
				chatRoom.leave(member);
			}
		}
	}
	public ChatRoom getRoom(int chatRoomNo) {
		return rooms.get(chatRoomNo);
	}
	public void createRoom(int chatRoomNo) {
		ChatRoom chatroom = new ChatRoom();
		rooms.put(chatRoomNo, chatroom);
	}
	public boolean notExist(int chatRoomNo) {
		return rooms.containsKey(chatRoomNo)==false;
	}
	public void textBroadcastRoom(WebSocketSession session, int chatRoomNo, String message, String type) throws IOException {
		Member member = new Member(session);
		if(!member.isMember()) return;
		//memberNo로 닉네임 뽑기

//		ChatContentDto chatContentDto = ChatContentDto.builder()
//				.chatterNo(member.getMemberNo())
//				.chatRoomNo(chatRoomNo)
//				.chatContent(message)
//				.chatTime(new Date())
//				.build();
			ReceiveChatVO vo = ReceiveChatVO.builder()
					.chatRoomNo(chatRoomNo)
					.message(String.valueOf(message))
					.messageType(type)
					.build();			
		log.info("chatContentDto={}", vo);
//		chatContentDao.insert(chatContentDto);
		System.out.println(chatRoomNo);

		System.out.println("broadcastRoom3");
		String json = mapper.writeValueAsString(vo);
		log.info("json={}",json);
		System.out.println("broadcastRoom4");
		TextMessage textMessage = new TextMessage(json);
		log.info("textMessage={}",textMessage.getPayload());
		getRoom(chatRoomNo).broadcast(textMessage);
	}
	public void fileBroadcastRoom(WebSocketSession session, int chatRoomNo, ByteArray message, String type) throws IOException {
		Member member = new Member(session);
		if(!member.isMember()) return;
		//memberNo로 닉네임 뽑기

//		ChatContentDto chatContentDto = ChatContentDto.builder()
//				.chatterNo(member.getMemberNo())
//				.chatRoomNo(chatRoomNo)
//				.chatContent(message)
//				.chatTime(new Date())
//				.build();
			ReceiveFileVO vo = ReceiveFileVO.builder()
					.chatRoomNo(chatRoomNo)
					.message(message)
					.messageType(type)
					.build();			
		log.info("chatContentDto={}", vo);
//		chatContentDao.insert(chatContentDto);

		System.out.println("broadcastRoom3");
		String json = mapper.writeValueAsString(vo);

		System.out.println("broadcastRoom4");
		TextMessage textMessage = new TextMessage(json);
		getRoom(chatRoomNo).broadcast(textMessage);
	}
	
}