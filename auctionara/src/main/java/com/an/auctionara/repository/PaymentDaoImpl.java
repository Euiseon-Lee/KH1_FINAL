package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PaymentDaoImpl implements PaymentDao{

	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public int getMonthlyTotalChargedPoints() {
		// 해당 월의 포인트 충전액 합계 
		return sqlSession.selectOne("payment.monthlyTotalPoints");
	}
	@Override
	public int paymentSequence() {
		return sqlSession.selectOne("payment.sequence");
	}
	
}
