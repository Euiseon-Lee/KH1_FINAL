package com.an.auctionara.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.entity.NetSalesDto;
import com.an.auctionara.entity.SuccessfulBidDto;
import com.an.auctionara.paymentvo.CashingListVO;
import com.an.auctionara.paymentvo.CashingPointsVO;
import com.an.auctionara.paymentvo.KakaoPayApproveResponseVO;
import com.an.auctionara.paymentvo.PayingVO;
import com.an.auctionara.paymentvo.PaymentInsertVO;
import com.an.auctionara.paymentvo.PaymentSuccessVO;
import com.an.auctionara.paymentvo.PurchaseVO;

@Service
public class PaymentServiceImpl implements PaymentService{
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@Transactional
	@Override
	public void insert(int paymentNo, KakaoPayApproveResponseVO responseVO, PurchaseVO purchaseVO) {
		PaymentInsertVO vo = PaymentInsertVO.builder()
			.paymentNo(paymentNo)
			.memberNo(Integer.parseInt(responseVO.getPartner_user_id()))
			.paymentTid(responseVO.getTid())
			.paymentPrice(purchaseVO.getChargeMoney())
			.build();
		
		sqlSession.insert("payment.insert", vo);
		sqlSession.update("payment.charge", vo);
	}
	@Override
	public PaymentInsertVO selectOne(int paymentNo) {
		return sqlSession.selectOne("payment.one", paymentNo);
	}
	@Override
	public PaymentSuccessVO successOne(int paymentNo) {
		return sqlSession.selectOne("payment.success", paymentNo);
	}
	@Override
	public List<PaymentInsertVO> allList(int memberNo) {
		return sqlSession.selectList("payment.allList", memberNo);
	}
	@Override
	public List<PaymentInsertVO> refundList(int memberNo) {
		return sqlSession.selectList("payment.refundList", memberNo);
	}
	@Override
	@Transactional
	public void refund(int paymentNo) {
		sqlSession.update("payment.refund", paymentNo);
		PaymentInsertVO vo = sqlSession.selectOne("payment.one", paymentNo);
		sqlSession.update("payment.refundMember", vo);
	}
	@Override
	@Transactional
	public boolean cashingRequest(CashingPointsVO vo) {
		int cashingSeq = sqlSession.selectOne("payment.cashingSequence");
		MemberDto memberDto = sqlSession.selectOne("member.one", vo.getMemberNo());
		if(memberDto.getMemberHoldingPoints()>=vo.getCashingMoney()) {
			vo.setCashingType("0");
			vo.setCashingNo(cashingSeq);
			if(memberDto.getMemberHoldingPoints()==vo.getCashingMoney()) {
				vo.setCashingType("1");
			}
			sqlSession.insert("payment.cashingInsert", vo);
			boolean success = sqlSession.update("payment.cashing", vo)>0;			
			return success;
		}else {
			return false;
		}
	}
	@Override
	public List<CashingListVO> cashingList(int memberNo) {
		return sqlSession.selectList("payment.cashingList", memberNo);
	}
	@Override
	@Transactional
	public boolean enoughPoint(int memberNo, int auctionNo) {
		MemberDto memberDto = sqlSession.selectOne("member.one", memberNo);
		SuccessfulBidDto successfulBidDto = sqlSession.selectOne("successful_bid.one", auctionNo);
		if(memberDto.getMemberHoldingPoints() >= successfulBidDto.getSuccFinalBid()) {
			return true;
		}else {
			return false;
		}
	}
	@Override
	@Transactional
	public void pointPaying(int memberNo, int auctionNo) {
		SuccessfulBidDto successfulBidDto = sqlSession.selectOne("successful_bid.one", auctionNo);
		PayingVO payingVO = PayingVO.builder().memberNo(memberNo).price(successfulBidDto.getSuccFinalBid()).build();
		sqlSession.update("member.paying", payingVO);
		sqlSession.update("successful_bid.paying", auctionNo);
		NetSalesDto nsDto = NetSalesDto.builder().commission(successfulBidDto.getSuccFinalBid()/10).succBidNo(successfulBidDto.getSuccFinalBid()/10).build();
		sqlSession.update("netSales.insert", nsDto);
	}
	@Override
	public SuccessfulBidDto bidSelect(int auctionNo) {
		return sqlSession.selectOne("successful_bid.one", auctionNo);
	}
}
