package com.an.auctionara.ws;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.an.auctionara.vo.MessageVO;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class MemberOnlyWebsocketServer extends TextWebSocketHandler{
	
	//사용자 저장소
	private Set<WebSocketSession> users = new CopyOnWriteArraySet<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.debug("접속");
		Map<String, Object> map = session.getAttributes();
		log.debug("http session={}", session.getAttributes());
		
		users.add(session);
		
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.debug("종료");
		users.remove(session);
	}
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.debug("수신");
		Map<String, Object> map = session.getAttributes();
		String memberId = (String) map.get("login");
		String auth = (String) map.get("auth");
		if(memberId==null || auth==null) return;
		
		MessageVO vo = MessageVO.builder()
								.memberId(memberId)
								.text(message.getPayload())
								.time(new Date())
								.build();
		
		//메세지 JSON 변환
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(vo);
		TextMessage newMessage = new TextMessage(json);
		
		for(WebSocketSession user : users) {
			user.sendMessage(newMessage);
		}
	}
}
