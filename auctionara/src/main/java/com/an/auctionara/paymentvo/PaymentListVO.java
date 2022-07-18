package com.an.auctionara.paymentvo;

import java.util.List;

import com.an.auctionara.entity.PaymentDetailDto;
import com.an.auctionara.entity.PaymentDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@NoArgsConstructor@AllArgsConstructor@Builder
public class PaymentListVO {
	private PaymentDto paymentDto;
	private List<PaymentDetailDto> paymentDetailList;
}
