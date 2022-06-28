package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberDto {
	private int memberNo;
	private int attachmentNo;
	private String memberEmail;
	private String memberPw;
	private String memberNick;
	private int memberHoldingPoints;
	private String memberAvailableTime;
	private String memberGrade;
	private int memberRedCount;
	private Date memberJoindate;
	private Date memberLogintime;
}
