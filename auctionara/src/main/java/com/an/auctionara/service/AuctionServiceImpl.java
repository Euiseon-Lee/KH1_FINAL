package com.an.auctionara.service;

import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.an.auctionara.entity.AuctionDto;
import com.an.auctionara.entity.PhotoDto;
import com.an.auctionara.repository.AttachmentDao;
import com.an.auctionara.repository.AuctionDao;
import com.an.auctionara.repository.BiddingDao;
import com.an.auctionara.repository.PhotoDao;
import com.an.auctionara.vo.AuctionDetailVO;
import com.an.auctionara.vo.AuctionListVO;
import com.an.auctionara.vo.WriteAuctionVO;

@Service
public class AuctionServiceImpl implements AuctionService {

	@Autowired
	private AuctionDao auctionDao;
	
	@Autowired
	private BiddingDao biddingDao;
	
	@Autowired
	private PhotoDao photoDao;
	
	@Autowired
	private AttachmentDao attachmentDao;	

	@Override
	public void write(int auctioneerNo, WriteAuctionVO writeAuctionVO) throws IllegalStateException, IOException {
		// 날짜 형식 가공 ('T' 삭제)
		writeAuctionVO.setAuctionClosedTime(writeAuctionVO.getAuctionClosedTime().replace("T", " "));
		
		AuctionDto auctionDto = AuctionDto.builder()
									.auctioneerNo(auctioneerNo)
									.categoryNo(writeAuctionVO.getCategoryNo())
									.auctionTitle(writeAuctionVO.getAuctionTitle())
									.auctionContent(writeAuctionVO.getAuctionContent())
									.auctionClosedTime(writeAuctionVO.getAuctionClosedTime())
									.auctionOpeningBid(writeAuctionVO.getAuctionOpeningBid())
									.auctionClosingBid(writeAuctionVO.getAuctionClosingBid())
									.auctionBidUnit(writeAuctionVO.getAuctionBidUnit())
									.auctionStatus(writeAuctionVO.getAuctionStatus())
									.build();
		
		// 경매 정보 저장
		int auctionNo = auctionDao.write(auctionDto);
		
		// 사진 저장
		for(int i = 0; i < writeAuctionVO.getAttachment().size(); i++) {
			int attachmentNo = attachmentDao.save(writeAuctionVO.getAttachment().get(i));
			
			PhotoDto photoDto = PhotoDto.builder() 
					.photoAuctionNo(auctionNo)
					.photoAttachmentNo(attachmentNo)
					.build();
			photoDao.insert(photoDto);
		}		
	}		
	
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

	@Override
	public AuctionDetailVO detail(int bidderNo, int auctionNo) {		
		Map<String, Integer> info = new HashMap<>();
		info.put("bidderNo", bidderNo);
		info.put("auctionNo", auctionNo);	
		
		// 입찰하지 않았다면 bidderNo 삭제
		if(!biddingDao.biddingExist(info)) {
			info.remove("bidderNo");
		}
		
		AuctionDetailVO auctionDetail = auctionDao.detail(info);
		
		// 마감 시간을 토대로 남은 시간 계산
		LocalDateTime limit = Instant.ofEpochMilli(auctionDetail.getAuctionClosedTime().getTime()).atZone(ZoneId.systemDefault()).toLocalDateTime();
		LocalDateTime now = LocalDateTime.now();
		
		long days = ChronoUnit.DAYS.between(now, limit);
		if(days == 0) {
			long hours = ChronoUnit.HOURS.between(now, limit);
			if(hours == 0) {
				long minutes = ChronoUnit.MINUTES.between(now, limit);
				auctionDetail.setAuctionRemainTime(minutes + "분");
			} else {
				auctionDetail.setAuctionRemainTime(hours + "시간");
			}
		} else {
			auctionDetail.setAuctionRemainTime(days + "일");
		}
		
		return auctionDetail;
	}
}
