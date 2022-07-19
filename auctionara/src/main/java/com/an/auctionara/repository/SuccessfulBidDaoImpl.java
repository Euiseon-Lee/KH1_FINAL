package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.SuccessfulBidDto;
import com.an.auctionara.vo.CheckRatingVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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

	@Override
	public int succCount(int memberNo) {
		return sqlSession.selectOne("successful_bid.countSuccbidbyMemberNo", memberNo);
	}
	
	@Override
	public int countPayment(int memberNo) {
		return sqlSession.selectOne("successful_bid.countPaymentbyAuctioneerNo", memberNo);
	}

	@Override
	public int countPaymentasBidder(int memberNo) {
		return sqlSession.selectOne("successful_bid.countPaymentbybidderNo", memberNo);
	}
	
	@Override
	public void intoStatusThrid(int memberNo) {
		sqlSession.update("successful_bid.intoStatusThrid", memberNo);
		
	}

	@Override
	public void approveFinish(int auctionNo) {
		sqlSession.update("successful_bid.approveFinish", auctionNo);
	}

	@Override
	public void approveAutoFinish() {
		sqlSession.update("successful_bid.approveAutoFinish");
	}

	@Override
	public int checkStatus(int auctionNo) {
		if(sqlSession.selectOne("successful_bid.checkStatus", auctionNo) == null) {
			return 3;
		} else {
			return sqlSession.selectOne("successful_bid.checkStatus", auctionNo);
		}
	}

	@Override
	public void checkCashing() {
		sqlSession.update("successful_bid.autoRedCount");
		sqlSession.update("successful_bid.checkCashing");
	}

}
