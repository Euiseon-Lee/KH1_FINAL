package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.vo.AuctionReportListVO;

public interface AuctionReportDao {

	List<AuctionReportListVO> reportList(int p, int s);

	int count();

}