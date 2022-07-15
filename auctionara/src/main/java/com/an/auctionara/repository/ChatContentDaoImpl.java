package com.an.auctionara.repository;

import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.ChatContentDto;
import com.an.auctionara.vo.AuctionListVO;
import com.an.auctionara.vo.ChatContentVO;

@Repository
public class ChatContentDaoImpl implements ChatContentDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<ChatContentDto> list(int chatRoomNo) {
		List<ChatContentDto> list = sqlSession.selectList("chatContent.list", chatRoomNo);
		SimpleDateFormat f = new SimpleDateFormat("M월 d일 HH:mm");
		for(ChatContentDto chatContentDto : list) {
			chatContentDto.setChatTimeFormat(f.format(chatContentDto.getChatTime()));
		}
		return list;
	}

	@Override
	public void save(ChatContentDto chatContentDto) {
		int chatNo = sqlSession.selectOne("chatContent.sequence");
		chatContentDto.setChatNo(chatNo);
		sqlSession.insert("chatContent.insert", chatContentDto);
	}
	
	@Override
	public List<ChatContentVO> content(int chatroomNo) {
		return sqlSession.selectList("chatContent.content", chatroomNo);
	}
}
