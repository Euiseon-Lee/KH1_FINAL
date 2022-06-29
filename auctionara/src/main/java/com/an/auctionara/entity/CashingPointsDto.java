package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import lombok.Data;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CashingPointsDto {
	private int cashingNo;
	private int memberNo;
	private int cashingMoney;
	private String cashingBank;
	private int cashingAccount;
	private String cashingType;
	private String cashingStatus;
	private Date cashingRequestTime;
	private Date cashingSuccessTime; 
}
