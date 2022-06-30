package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.AuctionDto;

@Repository
public class AuctionDaoImpl implements AuctionDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int write(AuctionDto auctionDto) {
		int auctionNo = sqlSession.selectOne("auction.sequence");
		auctionDto.setAuctionNo(auctionNo);
		sqlSession.insert("auction.insert", auctionDto);
		return auctionNo;
	}

	@Override
	public int recent(int memberNo) {
		AuctionDto auctionDto = sqlSession.selectOne("auction.recent", memberNo);
		return auctionDto.getAuctionNo();
	}

}
