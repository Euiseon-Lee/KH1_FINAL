package com.an.auctionara.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ManagerRestrictionListVO {
	private int restrictionNo;
	private String memberNick;
	private String restrictionReason;
	private String restrictionType;
	private Date restrictionTime;
}
