package com.an.auctionara.repository;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.AuctionDto;
import com.an.auctionara.entity.SuccessfulBidDto;
import com.an.auctionara.vo.AuctionDetailRefreshVO;
import com.an.auctionara.vo.AdminAuctionDetailVO;
import com.an.auctionara.vo.AdminAuctionListVO;
import com.an.auctionara.vo.AuctionDetailVO;
import com.an.auctionara.vo.AuctionListVO;
import com.an.auctionara.vo.AuctioneerInfoVO;
import com.an.auctionara.vo.MyBiddingAuctionListVO;

@Repository
public class AuctionDaoImpl implements AuctionDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int write(AuctionDto auctionDto) {
		int auctionNo = sqlSession.selectOne("auction.sequence");
		auctionDto.setAuctionNo(auctionNo);
		sqlSession.insert("auction.insert", auctionDto);
		return auctionNo;
	}

	@Override
	public int recent(int auctioneerNo) {
		AuctionDto auctionDto = sqlSession.selectOne("auction.recent", auctioneerNo);
		return auctionDto.getAuctionNo();
	}

	@Override
	public List<AuctionListVO> list(Map<String, Object> info) {
		List<AuctionListVO> list = sqlSession.selectList("auction.list", info);
		return list;
	}
	
	@Override
	public List<MyBiddingAuctionListVO> myBiddingAuctionList(int bidderNo) {
		List<MyBiddingAuctionListVO> list = sqlSession.selectList("auction.myBiddingList", bidderNo);
		return list;
	}
	
	@Override
	public AuctionDetailVO detail(Map<String, Integer> info) {
		AuctionDetailVO auctionDetail = sqlSession.selectOne("auction.detail", info);
		return auctionDetail;
	}

	@Override
	public List<SuccessfulBidDto> finish(Date now) {
		List<SuccessfulBidDto> list = sqlSession.selectList("auction.finish", now);
		return list;
   }
	
	@Override
	public SuccessfulBidDto close(int auctionNo) {
		SuccessfulBidDto successfulBidDto = sqlSession.selectOne("auction.close", auctionNo);
		return successfulBidDto;
   } 
	
	@Override
	public Boolean checkPrivate(int auctionNo) {
		int checkNum = sqlSession.selectOne("auction.checkPrivate", auctionNo);
		if(checkNum == 0) { // 공개
			return true;
		} else { // 비공개
			return false;
		}
	}
	
	@Override
	public AuctioneerInfoVO auctioneerInfo(int auctioneerNo) {
		return sqlSession.selectOne("auction.auctioneerInfo", auctioneerNo);
	}
	
	@Override
	public List<AdminAuctionListVO> adminList(String type, String keyword, int p, int s) {
		// 관리자 페이지 - 경매 list 메소드 
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		
		int end = p * s;
		int begin = end - (s - 1);
		
		param.put("begin", begin);
		param.put("end", end);
		
		return sqlSession.selectList("auction.adminList", param);
	}
	
	@Override
	public int adminListCount(String type, String keyword) {
		// 관리자 페이지 - 경매 list 관련 count 메소드 
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		return sqlSession.selectOne("auction.adminListCount", param);
	}
	
	@Override
	public AdminAuctionDetailVO adminAuctionDetail(int auctionNo) {
		// 관리자 페이지 - 경매 detail 메소드 
		return sqlSession.selectOne("auction.adminAuctionDetail", auctionNo);
	}
	
	@Override
	public AuctionDto setOpen(int auctionNo) {
		// 관리자 페이지 - 경매 게시글 공개 처리 
		int count = sqlSession.update("auction.setOpen", auctionNo);
//		if(count == 0) throw new CannotFindException();
		
		return sqlSession.selectOne("auction.one", auctionNo);
	}
	
	@Override
	public AuctionDto setPrivate(int auctionNo) {
		// 관리자 페이지 - 경매 게시글 비공개 처리 
		int count = sqlSession.update("auction.setPrivate", auctionNo);
//		if(count == 0) throw new CannotFindException();
		
		return sqlSession.selectOne("auction.one", auctionNo);
	}
	
	@Override
	public int countAuction() {
		// 관리자 페이지 - 경매 게시글 수 
		return sqlSession.selectOne("auction.countAuction");
	}
}
