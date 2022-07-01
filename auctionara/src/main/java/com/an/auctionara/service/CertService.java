package com.an.auctionara.service;

import javax.mail.MessagingException;

import com.an.auctionara.entity.MemberDto;

public interface CertService {
	void sendCert(String memberEmail);
	void sendPwResetMail(MemberDto targetDto) throws MessagingException;
}
