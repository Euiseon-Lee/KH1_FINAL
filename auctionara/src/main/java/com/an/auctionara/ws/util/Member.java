package com.an.auctionara.ws.util;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

//사용자
@Slf4j
@EqualsAndHashCode(of = {"webSocketSession"})
public class Member {
	
	@Getter
	private WebSocketSession webSocketSession;
	public void setWebSocketSession(WebSocketSession webSocketSession) {
		this.webSocketSession = webSocketSession;
		Map<String, Object> attr = webSocketSession.getAttributes();
		//Integer로 나오는 지 String으로 나오는 지 모르겠다
		int memberNo = (int)attr.get("whoLogin");
		this.memberNo = memberNo;
	}
	
	@Getter
	private int memberNo;
	
	public Member(WebSocketSession webSocketSession) {
		this.setWebSocketSession(webSocketSession);
	}
	public boolean isMember() {
		return this.memberNo > 0;
	}
	public void send(TextMessage message) throws IOException {
		webSocketSession.sendMessage(message);
	}
}