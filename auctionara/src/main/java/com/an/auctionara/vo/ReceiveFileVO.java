package com.an.auctionara.vo;

import org.apache.ibatis.javassist.bytecode.ByteArray;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@Builder@NoArgsConstructor@AllArgsConstructor
public class ReceiveFileVO {
	private int type, chatRoomNo;
	private String messageType;
	private ByteArray message;
	
}
