package com.an.auctionara.repository;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.BiddingDto;
import com.an.auctionara.vo.AuctionDetailRefreshVO;

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

	@Override
	public AuctionDetailRefreshVO refresh(int bidderNo, int auctionNo) {
		Map<String, Integer> info = new HashMap<>();
		info.put("bidderNo", bidderNo);
		info.put("auctionNo", auctionNo);
		AuctionDetailRefreshVO auctionDetailRefresh = sqlSession.selectOne("bidding.refresh", info);
		return auctionDetailRefresh;
	}

	@Override
	public void insert(BiddingDto biddingDto) {
		int biddingNo = sqlSession.selectOne("bidding.sequence");
		biddingDto.setBiddingNo(biddingNo);
		sqlSession.insert("bidding.insert", biddingDto);
	}
}
