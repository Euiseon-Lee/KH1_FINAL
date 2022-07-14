package com.an.auctionara.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.vo.MonthlyNetSalesVO;

@Repository
public class MonthlyNetSalesDaoImpl implements MonthlyNetSalesDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertMonthlyTotalNetSales(int totalNetSales) {
		sqlSession.insert("monthlyNetSales.insert", totalNetSales);
	}
	
	@Override
	public int netSales() {
		return sqlSession.selectOne("monthlyNetSales.monthlyNetSales");
	}
	
	@Override
	public List<MonthlyNetSalesVO> monthlyNetSales() {
		return sqlSession.selectList("monthlyNetSales.monthlyList");
	}
}
