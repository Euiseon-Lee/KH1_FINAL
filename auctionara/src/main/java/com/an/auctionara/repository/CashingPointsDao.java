package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.CashingPointsDto;
import com.an.auctionara.vo.CashingPointsListVO;

public interface CashingPointsDao {

	// 검색 + 페이징 List 
	List<CashingPointsListVO> list(String type, String keyword, int p, int s);

	// 페이징용 count 
	int count(String type, String keyword);

	// 현금화 신청 list 
	List<CashingPointsListVO> requestList();

	// 현금화 승인 
	CashingPointsDto approveCashing(int cashingNo);

	// 현금화 거절 
	CashingPointsDto refuseCashing(int cashingNo);

}
