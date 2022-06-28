package com.an.auctionara.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@Builder@NoArgsConstructor@AllArgsConstructor
public class MessageVO {
	private String memberId, text;
	private Date time;
}
