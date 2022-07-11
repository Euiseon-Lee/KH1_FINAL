package com.an.auctionara.repository;

public interface MonthlyChargedPointsDao {

	// 해당 월의 포인트 총 충전액 insert 
	void insertMonthlyChargedPoints(int totalPoints);

}
