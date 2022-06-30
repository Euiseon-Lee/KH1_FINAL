package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.ManagerRestrictionDto;

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
}
