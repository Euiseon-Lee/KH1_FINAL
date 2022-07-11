package com.an.auctionara.repository;

import com.an.auctionara.entity.AutologinDto;

public interface AutologinDao {

	void insertToken(AutologinDto autologinDto);

	AutologinDto returnToken(int memberNo);

	void deleteToken(int memberNo);
	
	String memberNoforCookie (int memberNo);
	
	String autoIpforCookie (String autoIp);
}
