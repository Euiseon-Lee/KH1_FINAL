package com.an.auctionara.ws;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;

import com.an.auctionara.vo.ReceiveChatVO;
import com.an.auctionara.vo.ReceiveFileVO;
import com.an.auctionara.ws.util.ChatRoomManager;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChatWebsocketServer extends BinaryWebSocketHandler {	
	
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
	protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) throws Exception {

		ByteBuffer buffer = message.getPayload();
		File dir = new File("C:/test");
		dir.mkdirs();

		//파일 이름: 보낸이+보낸년월일시분초
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = new Date();
		String data = dateFormat.format(date);
		
		String fileName = "auctionara"+data+".png";
		File target = new File(dir, fileName);
		FileOutputStream out = new FileOutputStream(target);
		FileChannel channel = out.getChannel();
		channel.write(buffer);
		out.close();

		Map<String, String> messageMap = new ConcurrentHashMap<>();
		messageMap.put("type", "binary");
		messageMap.put("data", "/auctionara/download?filename=" + fileName);
		
		ObjectMapper mapper = new ObjectMapper();
		
		TextMessage newMessage = new TextMessage(mapper.writeValueAsBytes(messageMap));
		ReceiveFileVO receiveFileVO = mapper.readValue(newMessage.getPayload(), ReceiveFileVO.class);
		
		if(receiveFileVO.getType()==JOIN) {
			manager.enterChat(session, receiveFileVO.getChatRoomNo());
		}else if(receiveFileVO.getType()==CHAT) {
			manager.fileBroadcastRoom(session, receiveFileVO.getChatRoomNo(), receiveFileVO.getMessage(), messageMap.get("type"));
		}
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
				manager.textBroadcastRoom(session, receiveChatVO.getChatRoomNo(), receiveChatVO.getMessage(), messageMap.get("type"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}