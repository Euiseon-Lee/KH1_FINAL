package com.an.auctionara.service;

import java.net.URISyntaxException;

import com.an.auctionara.paymentvo.KakaoPayApproveRequestVO;
import com.an.auctionara.paymentvo.KakaoPayApproveResponseVO;
import com.an.auctionara.paymentvo.KakaoPayCancelRequestVO;
import com.an.auctionara.paymentvo.KakaoPayCancelResponseVO;
import com.an.auctionara.paymentvo.KakaoPayOrderRequestVO;
import com.an.auctionara.paymentvo.KakaoPayOrderResponseVO;
import com.an.auctionara.paymentvo.KakaoPayReadyRequestVO;
import com.an.auctionara.paymentvo.KakaoPayReadyResponseVO;

public interface KakaoPayService {
	KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO requestVO) throws URISyntaxException;
	KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO requestVO) throws URISyntaxException;
	KakaoPayOrderResponseVO order(KakaoPayOrderRequestVO kakaoPayOrderRequestVO) throws URISyntaxException;
	KakaoPayCancelResponseVO cancel(KakaoPayCancelRequestVO requestVO) throws URISyntaxException;
}
