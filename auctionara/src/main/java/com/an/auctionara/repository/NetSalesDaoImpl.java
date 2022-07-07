package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NetSalesDaoImpl implements NetSalesDao{

	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public int getMonthlyTotalNetSales() {
		return sqlSession.selectOne("netSales.monthlyTotalNetSales");
	}
}
