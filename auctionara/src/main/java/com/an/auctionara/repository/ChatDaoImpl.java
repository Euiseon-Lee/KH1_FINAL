package com.an.auctionara.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.an.auctionara.entity.ChatContentDto;
import com.an.auctionara.vo.ChatListVO;
import com.an.auctionara.vo.ChatRoomSelectVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ChatDaoImpl implements ChatDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ChatContentDto> list(int chatRoomNo) {
		return sqlSession.selectList("chatContent.list", chatRoomNo);
	}
}
