package com.an.auctionara.ws.util;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.TextMessage;

import lombok.extern.slf4j.Slf4j;

//채팅방
@Slf4j
public class ChatRoom {
	
	//사용자
	private Set<Member> members = new CopyOnWriteArraySet<>();
	
	//기능
	public boolean enter(Member member) {
		return members.add(member);
	}
	
	public boolean leave(Member member) {
		return members.remove(member);
	}
	
	public boolean contains(Member member) {
		return members.contains(member);
	}
	
	public void broadcast(TextMessage message) throws IOException {
		for(Member member:members) {
			member.send(message);
		}
	}
}