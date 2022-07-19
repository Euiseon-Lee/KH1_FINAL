package com.an.auctionara.service;

import java.io.IOException;
import java.sql.Date;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.an.auctionara.entity.AuctionDto;
import com.an.auctionara.entity.BiddingDto;
import com.an.auctionara.entity.PhotoDto;
import com.an.auctionara.entity.SuccessfulBidDto;
import com.an.auctionara.repository.AttachmentDao;
import com.an.auctionara.repository.AuctionDao;
import com.an.auctionara.repository.BiddingDao;
import com.an.auctionara.repository.PhotoDao;
import com.an.auctionara.repository.SuccessfulBidDao;
import com.an.auctionara.vo.AuctionDetailRefreshVO;
import com.an.auctionara.vo.AuctionDetailVO;
import com.an.auctionara.vo.AuctionListVO;
import com.an.auctionara.vo.MyBiddingAuctionListVO;
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
	
	@Autowired
	private SuccessfulBidDao successfulBidDao;

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
									.auctionLatitude1(writeAuctionVO.getAuctionLatitude1())
									.auctionLongitude1(writeAuctionVO.getAuctionLongitude1())
									.auctionCircle1(writeAuctionVO.getAuctionCircle1())
									.auctionLatitude2(writeAuctionVO.getAuctionLatitude2())
									.auctionLongitude2(writeAuctionVO.getAuctionLongitude2())
									.auctionCircle2(writeAuctionVO.getAuctionCircle2())
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
	public List<AuctionListVO> list(int memberNo, int page, int filter, int sort, Integer categoryNo, String keyword, Integer search) {
		Map<String, Object> info = new HashMap<>();
		info.put("memberNo", memberNo);
		info.put("begin", (page * 12) - (12 - 1)); // 12개씩 불러오기
		info.put("end", page * 12);
		info.put("filter", filter);
		info.put("sort", sort);
		info.put("categoryNo", categoryNo);
		info.put("keyword", keyword);
		info.put("search", search);
		List<AuctionListVO> list = auctionDao.list(info);
		for(AuctionListVO auctionListVO : list) {
			String gap = auctionListVO.getAuctionRemainTime();
			if(gap.contains("분") && Integer.parseInt(gap.substring(0, gap.length() - 1)) <= 10) {
				auctionListVO.setDeadlineClosing(true);
			};
		}
		return list;
	}
	
	@Override
	public List<MyBiddingAuctionListVO> myBiddingAuctionList(int bidderNo) {
		List<MyBiddingAuctionListVO> list = auctionDao.myBiddingAuctionList(bidderNo);
		for(MyBiddingAuctionListVO myBiddingAuctionListVO : list) {
			String gap = myBiddingAuctionListVO.getAuctionRemainTime();
			if(gap.contains("분") && Integer.parseInt(gap.substring(0, gap.length() - 1)) <= 10) {
				myBiddingAuctionListVO.setDeadlineClosing(true);
			};
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
		
		AuctionDetailVO detail = auctionDao.detail(info);
		
		// 마감 10분 이하 ~ 마감 전까지 블라인드
		LocalDateTime limit = LocalDateTime.of(2021, 1, 1, 1, 0, 0);
		LocalDateTime now = LocalDateTime.of(2021, 1, 1, 0, 0, 0);
		long millis = ChronoUnit.MILLIS.between(now, limit);
		if(millis > 0 && millis <= 600000) { 
			detail.setMaxBiddingPrice(detail.getMyBiddingPrice()); // 최고 입찰가를 내 입찰가로 보내기
			detail.setTopBidder("0"); // 최고 입찰자 숨기기
		}	
		
		return detail;
	}
	
	@Override
	public AuctionDetailRefreshVO bidding(BiddingDto biddingDto) {
		biddingDao.insert(biddingDto);
		AuctionDetailRefreshVO auctionDetailRefresh = biddingDao.refresh(biddingDto.getBidderNo(), biddingDto.getAuctionNo());
		return auctionDetailRefresh;
	}
	
	@Scheduled(cron = "0 * * * * *") // 1분마다 낙찰 테이블에 낙찰 데이터 추가
	@Override
	public void successfulBid() {
		Date now = new java.sql.Date(System.currentTimeMillis());
		List<SuccessfulBidDto> finishList = auctionDao.finish(now);
		
		if(!finishList.isEmpty()) {
			 for(SuccessfulBidDto finish : finishList) {
					successfulBidDao.insert(finish); 
			}			
		}
	}
	
	@Scheduled(cron = "0 0 12 * * *") // 매일 오후 12시마다 낙찰 후 7일이 지났고 거래완료 안한 낙찰자 자동 거래완료 처리
	@Override
	public void autoApprove() {
		successfulBidDao.autoApprove();
		successfulBidDao.approveAutoFinish();
	}
}
