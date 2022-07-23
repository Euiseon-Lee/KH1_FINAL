package com.an.auctionara.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.an.auctionara.paymentvo.KakaoPayApproveRequestVO;
import com.an.auctionara.paymentvo.KakaoPayApproveResponseVO;
import com.an.auctionara.paymentvo.KakaoPayCancelRequestVO;
import com.an.auctionara.paymentvo.KakaoPayCancelResponseVO;
import com.an.auctionara.paymentvo.KakaoPayOrderRequestVO;
import com.an.auctionara.paymentvo.KakaoPayOrderResponseVO;
import com.an.auctionara.paymentvo.KakaoPayReadyRequestVO;
import com.an.auctionara.paymentvo.KakaoPayReadyResponseVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class KakaoPayServiceImpl implements KakaoPayService{
	@Autowired
	private SqlSession sqlSession;
	
	private String urlPrefix = "https://kapi.kakao.com/v1/payment";
	
	private RestTemplate template = new RestTemplate();
	
	private String authorization = "KakaoAK 1575260d71826690576ca2d961dd86cf";
	private String contentType = "application/x-www-form-urlencoded;charset=utf-8";
	
	private String cid = "TC0ONETIME";
	
	@Override
	public KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO requestVO) throws URISyntaxException {
		//header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", authorization);
		headers.add("Content-type", contentType);
		
		//body
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("cid", cid);
		body.add("partner_order_id", requestVO.getPartner_order_id());
		body.add("partner_user_id", requestVO.getPartner_user_id());
		body.add("item_name", requestVO.getItem_name());
		body.add("quantity", "1");
		body.add("total_amount", String.valueOf(requestVO.getTotal_amount()));
		body.add("tax_free_amount", "0");//무조건 0원
		

		String prefix = ServletUriComponentsBuilder
													.fromCurrentContextPath()
													.path("/payment")
													.toUriString();
//		String prefix = "${root}/payment";
		body.add("approval_url", prefix+"/approve");
		body.add("cancel_url", prefix+"/cancel");
		body.add("fail_url", prefix+"/fail");
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		URI uri = new URI(urlPrefix + "/ready");
		
		KakaoPayReadyResponseVO responseVO = 
				template.postForObject(uri, entity, KakaoPayReadyResponseVO.class);
		
		
		//테스트용 로그
		log.debug("tid = {}", responseVO.getTid());
		log.debug("partner_order_id = {}", requestVO.getPartner_order_id());
		log.debug("partner_user_id = {}", requestVO.getPartner_user_id());
		
		return responseVO;
	}
	
	@Override
	public KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO requestVO) throws URISyntaxException {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", authorization);
		headers.add("Content-type", contentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("cid", cid);
		body.add("tid", requestVO.getTid());//결제요청시의 거래번호
		body.add("partner_order_id", requestVO.getPartner_order_id());//결제요청시의 거래번호
		body.add("partner_user_id", requestVO.getPartner_user_id());//결제요청시의 회원번호
		body.add("pg_token", requestVO.getPg_token());//결제 성공 후 서버에서 반환되는 토큰(Token)
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		URI uri = new URI(urlPrefix + "/approve");
		
		KakaoPayApproveResponseVO responseVO = 
				template.postForObject(uri, entity, KakaoPayApproveResponseVO.class);
		
		return responseVO;
	}

	@Override
	public KakaoPayOrderResponseVO order(KakaoPayOrderRequestVO requestVO) throws URISyntaxException {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", authorization);
		headers.add("Content-type", contentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("cid", cid);
		body.add("tid", requestVO.getTid());
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		URI uri = new URI(urlPrefix + "/order");
		
		KakaoPayOrderResponseVO responseVO = 
				template.postForObject(uri, entity, KakaoPayOrderResponseVO.class);
		log.debug("responseVO = {}", responseVO);
		
		return responseVO;
	}
	
	@Override
	public KakaoPayCancelResponseVO cancel(KakaoPayCancelRequestVO requestVO) throws URISyntaxException {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", authorization);
		headers.add("Content-type", contentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		
		body.add("cid", cid);
		body.add("tid", requestVO.getTid());
		body.add("cancel_amount", String.valueOf(requestVO.getCancel_amount()));
		body.add("cancel_tax_free_amount", "0");
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		URI uri = new URI(urlPrefix + "/cancel");
		
		KakaoPayCancelResponseVO responseVO = template.postForObject(uri, entity, KakaoPayCancelResponseVO.class);
		
		log.debug("responseVO={}", responseVO);
		return responseVO;
	}
	
}
