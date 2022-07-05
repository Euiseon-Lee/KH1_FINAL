package com.an.auctionara.repository;

import java.util.Map;

public interface BiddingDao {
	Boolean biddingExist(Map<String, Integer> info);
}
