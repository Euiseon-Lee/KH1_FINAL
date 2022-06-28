package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PaymentDto {
	private int payment_no;
	private int member_no;
	private String payment_tid;
	private int payment_price;
	private Date payment_time;
	private String payment_status;
}
