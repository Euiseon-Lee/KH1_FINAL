package com.an.auctionara.ws;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;

import com.an.auctionara.vo.ReceiveChatVO;
import com.an.auctionara.ws.util.ChatRoomManager;
import com.fasterxml.jackson.databind.ObjectMapper;

public class ChatWebsocketServer extends BinaryWebSocketHandler {	
	
	private ChatRoomManager manager = new ChatRoomManager();
	public static final int JOIN=1, CHAT=2, IMAGE=3, EMOJI=4;
	
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
		Map<String, String> messageMap = new ConcurrentHashMap<>();
		messageMap.put("type", "string");
		messageMap.put("data", message.getPayload());
		ObjectMapper mapper = new ObjectMapper();
		try {
			ReceiveChatVO receiveChatVO = mapper.readValue(message.getPayload(), ReceiveChatVO.class);
			if(receiveChatVO.getType() == JOIN) {
				manager.enterChat(session, receiveChatVO.getChatRoomNo());
			}
			else if(receiveChatVO.getType() == CHAT) {
				manager.textBroadcastRoom(session, receiveChatVO.getChatRoomNo(), receiveChatVO.getChatterNo(), receiveChatVO.getChatTime(), receiveChatVO.getMessage(), messageMap.get("type"));
			} else if(receiveChatVO.getType() == IMAGE) {
				manager.textBroadcastRoom(session, receiveChatVO.getChatRoomNo(), receiveChatVO.getChatterNo(), receiveChatVO.getChatTime(), receiveChatVO.getAttachmentNo(), receiveChatVO.getMessage(), messageMap.get("type"));
			} else if(receiveChatVO.getType() == EMOJI) {
				manager.textBroadcastRoom(session, receiveChatVO.getChatRoomNo(), receiveChatVO.getChatterNo(), receiveChatVO.getChatTime(), receiveChatVO.getEmojiNo(), receiveChatVO.getMessage(), messageMap.get("type"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}