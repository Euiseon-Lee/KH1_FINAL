package com.an.auctionara.repository;

public interface PaymentDao {

	// 해당 월의 포인트 충전액 합계 
	int getMonthlyTotalChargedPoints();

}
