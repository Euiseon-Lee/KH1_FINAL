package com.an.auctionara.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.vo.MonthlyBidVO;

@Repository
public class MonthlyBidDaoImpl implements MonthlyBidDao{

	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public void insertMonthlyTotalBid(int totalBid) {
		sqlSession.insert("monthlyBid.insert", totalBid);
	}
	
	@Override
	public List<MonthlyBidVO> monthlyBid() {
		return sqlSession.selectList("monthlyBid.monthlyList");
	}
}
