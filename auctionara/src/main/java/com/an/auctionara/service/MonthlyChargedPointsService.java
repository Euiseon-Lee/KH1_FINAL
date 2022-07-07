package com.an.auctionara.service;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.transaction.annotation.Transactional;

public interface MonthlyChargedPointsService {

	public void insertMonthlyChargedPoints();
	
}
