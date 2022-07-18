package com.an.auctionara.ws.util;

import java.io.IOException;
import java.util.Collections;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.an.auctionara.vo.ReceiveChatVO;
import com.fasterxml.jackson.databind.ObjectMapper;

public class ChatRoomManager {
	
	private Map<Integer, ChatRoom> rooms = Collections.synchronizedMap(new ConcurrentHashMap<>());
	private ChatRoom waitingRoom = new ChatRoom();
	private ObjectMapper mapper = new ObjectMapper();

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
		return rooms.containsKey(chatRoomNo) == false;
	}
	
	public void textBroadcastRoom(WebSocketSession session, int chatRoomNo, int chatterNo, String chatTime, String message, String type) throws IOException {
		Member member = new Member(session);
		if(!member.isMember()) return;
		ReceiveChatVO vo = ReceiveChatVO.builder()
					.chatRoomNo(chatRoomNo)
					.chatterNo(chatterNo)
					.chatTime(String.valueOf(chatTime))
					.message(String.valueOf(message))
					.messageType(type)
					.build();			
		
		String json = mapper.writeValueAsString(vo);
		TextMessage textMessage = new TextMessage(json);
		getRoom(chatRoomNo).broadcast(textMessage);
	}
	
	public void textBroadcastRoom(WebSocketSession session, int chatRoomNo, int chatterNo, String chatTime, int attachmentNo, String message, String type) throws IOException {
		Member member = new Member(session);
		if(!member.isMember()) return;
		ReceiveChatVO vo = ReceiveChatVO.builder()
					.chatRoomNo(chatRoomNo)
					.chatterNo(chatterNo)
					.chatTime(String.valueOf(chatTime))
					.attachmentNo(attachmentNo)
					.message(String.valueOf(message))
					.messageType(type)
					.build();			
		
		String json = mapper.writeValueAsString(vo);
		TextMessage textMessage = new TextMessage(json);
		getRoom(chatRoomNo).broadcast(textMessage);
	}
	
	public void textBroadcastRoom(WebSocketSession session, int chatRoomNo, int chatterNo, String chatTime, String emojiNo, String message, String type) throws IOException {
		Member member = new Member(session);
		if(!member.isMember()) return;
		ReceiveChatVO vo = ReceiveChatVO.builder()
					.chatRoomNo(chatRoomNo)
					.chatterNo(chatterNo)
					.chatTime(String.valueOf(chatTime))
					.emojiNo(String.valueOf(emojiNo))
					.message(String.valueOf(message))
					.messageType(type)
					.build();			
		
		String json = mapper.writeValueAsString(vo);
		TextMessage textMessage = new TextMessage(json);
		getRoom(chatRoomNo).broadcast(textMessage);
	}	
}
