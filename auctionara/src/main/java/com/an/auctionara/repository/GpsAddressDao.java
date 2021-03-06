package com.an.auctionara.repository;

import java.util.List;
import java.util.Map;

import com.an.auctionara.entity.GpsAddressDto;

public interface GpsAddressDao {
	void insert(GpsAddressDto gpsAddressDto);
	void change1(GpsAddressDto gpsAddressDto);
	void change2(GpsAddressDto gpsAddressDto);
	void delete2(int memberNo);
	List<GpsAddressDto> list(int memberNo);
	List<GpsAddressDto> validList(int memberNo);
	GpsAddressDto one1(int memberNo);
	void changeGpsStaus();
	Boolean checkBiddingAddress(Map<String, Integer> info);
}
