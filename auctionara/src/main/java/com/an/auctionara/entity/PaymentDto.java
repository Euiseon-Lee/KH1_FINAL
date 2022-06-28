package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PaymentDto {
	private int paymentNo;
	private int memberNo;
	private String paymentTid;
	private int paymentPrice;
	private Date paymentTime;
	private String paymentStatus;
}
