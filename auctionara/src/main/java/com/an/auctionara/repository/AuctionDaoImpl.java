package com.an.auctionara.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.AuctionDto;
import com.an.auctionara.vo.AuctionListVO;

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
	public int recent(int auctioneerNo) {
		AuctionDto auctionDto = sqlSession.selectOne("auction.recent", auctioneerNo);
		return auctionDto.getAuctionNo();
	}

	@Override
	public List<AuctionListVO> list(int memberNo) {
		List<AuctionListVO> list = sqlSession.selectList("auction.list");
		return list;
	}
}
