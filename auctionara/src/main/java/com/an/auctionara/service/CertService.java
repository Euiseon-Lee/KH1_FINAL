package com.an.auctionara.service;

import javax.mail.MessagingException;

import com.an.auctionara.entity.MemberDto;

public interface CertService {
	//회원가입 시 email 인증위한 cert 발송
	void sendCert(String memberEmail);
	//로그인 시 비밀번호 찾기용 cert 발송
	void sendPwResetMail(MemberDto targetDto) throws MessagingException;
	//마이페이지 비밀번호 재설정용 cert 발송
	void sendPwResetMail(String memberEmail) throws MessagingException; 
	//기간이 초과된 cert 제거용 스케줄러 (한달에 한번 작동)
	void clearCertforEmail();
}
