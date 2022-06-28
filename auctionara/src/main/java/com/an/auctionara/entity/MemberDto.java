package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberDto {
	private int member_no;
	private int attachment_no;
	private String member_email;
	private String member_pw;
	private String member_nick;
	private int member_holding_points;
	private String member_available_time;
	private String member_grade;
	private int member_red_count;
	private Date member_joindate;
	private Date member_logintime;
}
