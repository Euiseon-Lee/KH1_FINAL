package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MonthlyBidDaoImpl implements MonthlyBidDao{

	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public void insertMonthlyTotalBid(int totalBid) {
		sqlSession.insert("monthlyBid.insert", totalBid);
	}
}
