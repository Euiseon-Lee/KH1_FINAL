package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.vo.MonthlyBidVO;

public interface MonthlyBidDao {

	void insertMonthlyTotalBid(int totalBid);

	List<MonthlyBidVO> monthlyBid();

}
