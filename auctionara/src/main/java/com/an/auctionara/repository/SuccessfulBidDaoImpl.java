package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.SuccessfulBidDto;
import com.an.auctionara.vo.CheckRatingVO;

@Repository
public class SuccessfulBidDaoImpl implements SuccessfulBidDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(SuccessfulBidDto finish) {
		int succBidNo = sqlSession.selectOne("successful_bid.sequence");
		finish.setSuccBidNo(succBidNo);
		sqlSession.insert("successful_bid.insert", finish);
	}
	
	@Override
	public int getMonthlyTotalBid() {
		return sqlSession.selectOne("successful_bid.monthlyTotalSuccBid");
	}

	@Override
	public CheckRatingVO checkRating(int auctionNo) {
		CheckRatingVO checkRatingVO = sqlSession.selectOne("successful_bid.checkRating", auctionNo);
		return checkRatingVO;
	}

	@Override
	public void auctioneerApprove(int auctionNo) {
		sqlSession.update("successful_bid.auctioneerApprove", auctionNo);
	}

	@Override
	public void bidderApprove(int auctionNo) {
		sqlSession.update("successful_bid.bidderApprove", auctionNo);
	}

	@Override
	public void autoApprove() {
		sqlSession.update("successful_bid.autoApprove");
	}
}
