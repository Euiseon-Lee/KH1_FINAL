package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import lombok.Data;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CashingPointsDto {
	private int member_no;
	private int cashing_money;
	private String cashing_bank;
	private int cashing_account;
	private String cashing_type;
	private String cashing_status;
	private Date cashing_request_time;
	private Date cashing_success_time; 
}
