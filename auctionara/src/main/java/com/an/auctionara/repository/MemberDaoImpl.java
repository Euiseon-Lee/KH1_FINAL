package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public void join(MemberDto memberDto) {
		int sequence = sqlSession.selectOne("member.sequence");
		memberDto.setMemberNo(sequence);
		sqlSession.insert("member.join", memberDto);
		
	}

}
