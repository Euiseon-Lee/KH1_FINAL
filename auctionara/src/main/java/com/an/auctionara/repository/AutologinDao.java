package com.an.auctionara.repository;

import com.an.auctionara.entity.AutologinDto;

public interface AutologinDao {

	void insertToken(int memberNo, String autoToken, String autoDeviceSerial);

	AutologinDto returnToken(int memberNo);
}
