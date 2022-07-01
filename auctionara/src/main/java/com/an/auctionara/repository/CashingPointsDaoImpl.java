package com.an.auctionara.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.CashingPointsDto;
import com.an.auctionara.vo.CashingPointsListVO;

@Repository
public class CashingPointsDaoImpl implements CashingPointsDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<CashingPointsListVO> list(String type, String keyword, int p, int s) {
		// 검색 + 페이징 메소드 
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		
		int end = p * s;
		int begin = end - (s - 1);
		
		param.put("begin", begin);
		param.put("end", end);
		
		
		return sqlSession.selectList("cashingPoints.list", param);
	}
	
	@Override
	public int count(String type, String keyword) {
		// list 페이징용 count 
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		return sqlSession.selectOne("cashingPoints.count", param);
	}
	
	@Override
	public List<CashingPointsListVO> requestList() {
		// 현금화 신청 list 
		return sqlSession.selectList("cashingPoints.requestList");
	}
	
	@Override
	public CashingPointsDto approveCashing(int cashingNo) {
		// 현금화 승인  
		int count = sqlSession.update("cashingPoints.approveCashing", cashingNo);
//		if(count == 0) throw new CannotFindException();
		
		return sqlSession.selectOne("cashingPoints.one", cashingNo);
	}
	
	@Override
	public CashingPointsDto refuseCashing(int cashingNo) {
		// 현금화 거절 
		int count = sqlSession.update("cashingPoints.refuseCashing", cashingNo);
//		if(count == 0) throw new CannotFindException();
		
		return sqlSession.selectOne("cashingPoints.one", cashingNo);
	}
}
