package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SuccessfulBidDaoImpl implements SuccessfulBidDao{

	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public int getMonthlyTotalBid() {
		return sqlSession.selectOne("successfulBid.monthlyTotalSuccBid");
	}
}
