package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MonthlyNetSalesDaoImpl implements MonthlyNetSalesDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertMonthlyTotalNetSales(int totalNetSales) {
		sqlSession.insert("monthlyNetSales.insert", totalNetSales);
	}
}
