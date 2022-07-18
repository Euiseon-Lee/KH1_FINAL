package com.an.auctionara.service;

import java.util.List;

import com.an.auctionara.entity.SuccessfulBidDto;
import com.an.auctionara.paymentvo.CashingListVO;
import com.an.auctionara.paymentvo.CashingPointsVO;
import com.an.auctionara.paymentvo.KakaoPayApproveResponseVO;
import com.an.auctionara.paymentvo.PaymentInsertVO;
import com.an.auctionara.paymentvo.PaymentSuccessVO;
import com.an.auctionara.paymentvo.PurchaseVO;

public interface PaymentService {

	void insert(int paymentNo, KakaoPayApproveResponseVO responseVO, PurchaseVO purchaseVO);
	PaymentInsertVO selectOne(int paymentNo);
	PaymentSuccessVO successOne(int paymentNo);
	List<PaymentInsertVO> allList(int memberNo);
	List<PaymentInsertVO> refundList(int memberNo);
	void refund(int paymentNo);
	boolean cashingRequest(CashingPointsVO vo);
	List<CashingListVO> cashingList(int memberNo);
	boolean enoughPoint(int memberNo, int auctionNo);
	void pointPaying(int memberNo, int auctionNo);
	SuccessfulBidDto bidSelect(int auctionNo);
}
