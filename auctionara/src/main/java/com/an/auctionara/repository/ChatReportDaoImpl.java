package com.an.auctionara.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.vo.ManagerRestrictionListVO;

@Repository
public class ChatReportDaoImpl implements ChatReportDao{

	@Autowired
	private SqlSession sqlSession; 

	@Override
	public List<ManagerRestrictionListVO> list(String type, String keyword, int p, int s) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		int end = p * s;
		int begin = end - (s - 1);
		
		param.put("begin", begin);
		param.put("end", end);
		
		return sqlSession.selectList("", param);
	}
	
	@Override
	public int count(String type, String keyword) {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("type", type);
		param.put("keyword", keyword);
		
		return sqlSession.selectOne("", param);
	}
}
