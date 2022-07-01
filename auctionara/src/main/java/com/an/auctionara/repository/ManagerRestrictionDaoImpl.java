package com.an.auctionara.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.ManagerRestrictionDto;
import com.an.auctionara.vo.ManagerRestrictionListVO;

@Repository
public class ManagerRestrictionDaoImpl implements ManagerRestrictionDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void restrictMember(ManagerRestrictionDto managerRestrictionDto) {
		// 회원 제재 등록 메소드 
		int restrictionNo = sqlSession.selectOne("managerRestriction.sequence");
		managerRestrictionDto.setRestrictionNo(restrictionNo);
		
		sqlSession.insert("managerRestriction.insert", managerRestrictionDto);
	}
	
	@Override
	public List<ManagerRestrictionListVO> list(String type, String keyword, int p, int s) {
		// 회원 제재 내역 메소드 
		Map<String, Object> param = new HashMap<String, Object>();
		
		int end = p * s;
		int begin = end - (s - 1);
		
		param.put("begin", begin);
		param.put("end", end);
		
		return sqlSession.selectList("managerRestriction.list", param);
	}
	
	@Override
	public int count(String type, String keyword) {
		// list 페이징을 위한 count 메소드 
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("type", type);
		param.put("keyword", keyword);
		
		return sqlSession.selectOne("managerRestriction.count", param);
	}
}
