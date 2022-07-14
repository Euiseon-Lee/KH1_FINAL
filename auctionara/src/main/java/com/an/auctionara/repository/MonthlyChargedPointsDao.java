package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.vo.MonthlyChargedPointsVO;

public interface MonthlyChargedPointsDao {

	// 해당 월의 포인트 총 충전액 insert 
	void insertMonthlyChargedPoints(int totalPoints);

	List<MonthlyChargedPointsVO> monthlyTotalPoints();

}
