package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ManagerRestrictionDto {
	private int restrictionNo;
	private int memberNo;
	private String restrictionReason;
	private String restrictionType;
	private Date restrictionTime;
}
