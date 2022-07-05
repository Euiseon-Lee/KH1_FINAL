package com.an.auctionara.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.AuctionDto;
import com.an.auctionara.vo.AdminAuctionDetailVO;
import com.an.auctionara.vo.AdminAuctionListVO;
import com.an.auctionara.vo.AuctionListVO;

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
	public List<AuctionListVO> list(int memberNo) {
		List<AuctionListVO> list = sqlSession.selectList("auction.list");
		return list;
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
}
