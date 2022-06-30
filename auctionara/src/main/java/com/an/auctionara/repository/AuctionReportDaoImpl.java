package com.an.auctionara.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	public int count() {
		// 목록 페이징을 위한 count 메소드 
		return sqlSession.selectOne("auctionReport.count");
	}
}
