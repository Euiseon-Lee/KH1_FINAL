package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.CashingPointsDto;

public interface CashingPointsDao {

	// 검색 + 페이징 List 
	List<CashingPointsDto> list(String type, String keyword, int p, int s);

	// 페이징용 count 
	int count(String type, String keyword);

	// 현금화 신청 list 
	List<CashingPointsDto> requestList();

}
