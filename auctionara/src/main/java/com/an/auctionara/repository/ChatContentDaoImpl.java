package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.ChatContentDto;

@Repository
public class ChatContentDaoImpl implements ChatContentDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ChatContentDto chatContentDto) {
		sqlSession.insert("chatContent.insert", chatContentDto);
		
	}
}
