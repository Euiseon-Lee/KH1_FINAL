package com.an.auctionara.repository;

import com.an.auctionara.entity.SuccessfulBidDto;
import com.an.auctionara.vo.CheckRatingVO;

public interface SuccessfulBidDao {
	void insert(SuccessfulBidDto finish);
	int getMonthlyTotalBid();
	CheckRatingVO checkRating(int auctionNo);
	void auctioneerApprove(int auctionNo);
	void bidderApprove(int auctionNo);
	void autoApprove();
	void approveFinish(int auctionNo);
	void approveAutoFinish();
	int checkStatus(int auctionNo);
	
	//마이페이지 낙찰 성공한 총 개수 출력
	int succCount(int memberNo);
	
	//경매인 탈퇴 시 낙찰된 경매물품 중 결제완료된 물품있는지 조회
	int countPayment(int memberNo);
	
	//낙찰자 탈퇴 시 낙찰받은 경매물품 중 결제완료된 물품있는지 조회
	int countPaymentasBidder(int memberNo);
	
	//경매인 탈퇴 시 낙찰된 경매물품 중 결제예정인 물품은 상태 변경 (3번)
	void intoStatusThrid(int memberNo);
}
