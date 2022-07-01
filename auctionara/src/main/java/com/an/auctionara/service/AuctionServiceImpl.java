package com.an.auctionara.service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.an.auctionara.repository.AuctionDao;
import com.an.auctionara.vo.AuctionListVO;

@Service
public class AuctionServiceImpl implements AuctionService {

	@Autowired
	AuctionDao auctionDao;
	
	@Override
	public List<AuctionListVO> list(int memberNo) {
		List<AuctionListVO> list = auctionDao.list(memberNo);
		
		// 마감 시간을 토대로 남은 시간 계산
		for(AuctionListVO auctionListVO : list) {
			LocalDateTime limit = Instant.ofEpochMilli(auctionListVO.getAuctionClosedTime().getTime()).atZone(ZoneId.systemDefault()).toLocalDateTime();
			LocalDateTime now = LocalDateTime.now();
			
			long days = ChronoUnit.DAYS.between(now, limit);
			if(days == 0) {
				long hours = ChronoUnit.HOURS.between(now, limit);
				if(hours == 0) {
					long minutes = ChronoUnit.MINUTES.between(now, limit);
					auctionListVO.setAuctionRemainTime(minutes + "분");
					if(minutes < 10) {
						auctionListVO.setDeadlineClosing(true); // 10분 이하로 남으면 마감임박 true	
					}
				} else {
					auctionListVO.setAuctionRemainTime(hours + "시간");
				}
			} else {
				auctionListVO.setAuctionRemainTime(days + "일");
			}
		}
		
		return list;
	}

}
