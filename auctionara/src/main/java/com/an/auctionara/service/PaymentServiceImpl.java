package com.an.auctionara.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.an.auctionara.vo.AuctionListVO;

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
	public List<PaymentInsertVO> allList(int memberNo, int page, int filter, int sort) {
		Map<String, Object> info = new HashMap<>();
		info.put("memberNo", memberNo);
		info.put("begin", (page * 10) - (10 - 1)); // 10개씩 불러오기
		info.put("end", page * 10);
		info.put("filter", filter);
		info.put("sort", sort);
		return sqlSession.selectList("payment.allList", info);
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
			boolean success = memberDto.getMemberHoldingPoints() >= vo.getCashingMoney();
			return success;
		}else {
			return false;
		}
	}
	@Override
	public List<CashingListVO> cashingList(int memberNo, int page, int filter, int sort) {
		Map<String, Object> info = new HashMap<>();
		info.put("memberNo", memberNo);
		info.put("begin", (page * 10) - (10 - 1)); // 10개씩 불러오기
		info.put("end", page * 10);
		info.put("filter", filter);
		info.put("sort", sort);		
		return sqlSession.selectList("payment.cashingList", info);
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
		int comission = successfulBidDto.getSuccFinalBid()/10;
		NetSalesDto nsDto = NetSalesDto.builder().commission(comission).succBidNo(successfulBidDto.getSuccBidNo()).build();
		sqlSession.insert("netSales.insert", nsDto);
	}
	@Override
	public SuccessfulBidDto bidSelect(int auctionNo) {
		return sqlSession.selectOne("successful_bid.one", auctionNo);
	}
}
