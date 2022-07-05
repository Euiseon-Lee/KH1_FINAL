package com.an.auctionara.repository;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BiddingDaoImpl implements BiddingDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public Boolean biddingExist(Map<String, Integer> info) {
		Boolean result;
		if(sqlSession.selectList("bidding.exist", info).isEmpty()) {
			result = false;
		} else {
			result = true;
		}
		return result;
	}
}
