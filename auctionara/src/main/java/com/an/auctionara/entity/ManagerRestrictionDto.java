package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ManagerRestrictionDto {
	private int restriction_no;
	private int member_no;
	private String restriction_reason;
	private int restriction_type;
	private Date restriction_time;
}
