package com.an.auctionara.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.AuctionReportDto;
import com.an.auctionara.vo.AuctionReportListVO;

@Repository
public class AuctionReportDaoImpl implements AuctionReportDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<AuctionReportListVO> reportList(int p, int s) {
		// 경매 신고 목록 리스트 
		Map<String, Object> param = new HashMap<String, Object>();
		
		int end = p * s;
		int begin = end - (s - 1);
		
		param.put("begin", begin);
		param.put("end", end);
		
		return sqlSession.selectList("auctionReport.list", param);
	}
	
	@Override
	public int count(String type, String keyword) {
		// 목록 페이징을 위한 count 메소드 
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		return sqlSession.selectOne("auctionReport.count", param);	
	}
	
	@Override
	public AuctionReportDto setRestrict(int auctionReportNo) {
		// 관리자 제재 입력 후 신고 테이블의 제재 여부 컬럼 update 메소드 
		int count = sqlSession.update("auctionReport.setRestrict", auctionReportNo);
//		if(count == 0) throw new CannotFindException();
		
		return sqlSession.selectOne("auctionReport.one", auctionReportNo);
	}
}
