package com.an.auctionara.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CashingPointsListVO {
	private int cashingNo;
	private int memberNo;
	private int cashingMoney;
	private String cashingBank;
	private int cashingAccount;
	private String cashingType;
	private String cashingStatus;
	private Date cashingRequestTime;
	private Date cashingSuccessTime; 
	private String memberName; 
}
