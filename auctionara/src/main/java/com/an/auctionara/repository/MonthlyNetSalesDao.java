package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.vo.MonthlyNetSalesVO;

public interface MonthlyNetSalesDao {

	void insertMonthlyTotalNetSales(int totalNetSales);

	int netSales();

	List<MonthlyNetSalesVO> monthlyNetSales();

}
