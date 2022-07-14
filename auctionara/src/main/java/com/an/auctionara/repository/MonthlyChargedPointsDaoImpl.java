package com.an.auctionara.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.vo.MonthlyChargedPointsVO;

@Repository
public class MonthlyChargedPointsDaoImpl implements MonthlyChargedPointsDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertMonthlyChargedPoints(int totalPoints) {
		// 해당 월의 포인트 총 충전액 insert 
		sqlSession.insert("monthlyChargedPoints.insert", totalPoints);
	}
	
	@Override
	public List<MonthlyChargedPointsVO> monthlyTotalPoints() {
		return sqlSession.selectList("monthlyChargedPoints.monthlyList");
	}
}
