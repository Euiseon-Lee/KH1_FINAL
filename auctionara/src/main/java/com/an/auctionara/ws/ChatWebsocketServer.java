package com.an.auctionara.ws;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.an.auctionara.vo.ReceiveChatVO;
import com.an.auctionara.ws.util.ChatRoomManager;
import com.an.auctionara.ws.util.Member;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChatWebsocketServer extends TextWebSocketHandler {	
	
	private ChatRoomManager manager = new ChatRoomManager();

	private ObjectMapper mapper = new ObjectMapper();

	public static final int JOIN=1, CHAT=2;

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		manager.login(session);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		manager.leave(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message){

		Member member = new Member(session);
		try {
			ReceiveChatVO receiveChatVO = mapper.readValue(message.getPayload(), ReceiveChatVO.class);
			log.info("receiveChatVO:{}", receiveChatVO);
			log.info("session:{}", session);
//			TextMessage newMessage = new TextMessage(mapper.writeValueAsBytes(messageMap)); 
			if(receiveChatVO.getType() == JOIN) {
				manager.enterChat(session, receiveChatVO.getChatRoomNo());
			}
			else if(receiveChatVO.getType() == CHAT) {
				manager.broadCastRoom(session, receiveChatVO.getChatRoomNo(), receiveChatVO.getMessage());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}