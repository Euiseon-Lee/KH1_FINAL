package com.an.auctionara.repository;

import com.an.auctionara.entity.AutologinDto;

public interface AutologinDao {

	void insertToken(AutologinDto autologinDto);

	AutologinDto returnToken(int memberNo);

	void deleteToken(AutologinDto autologinDto);
	

}
