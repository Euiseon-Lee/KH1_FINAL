package com.an.auctionara.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.ChatReportDto;
import com.an.auctionara.entity.ChatRoomDto;
import com.an.auctionara.vo.AuctionDetailVO;
import com.an.auctionara.vo.ChatRoomListVO;

@Repository
public class ChatRoomDaoImpl implements ChatRoomDao{
	
	@Autowired
	private SqlSession sqlSession;	

	@Override
	public int join(int auctionNo, int memberNo) {
		Map<String, Integer> info = new HashMap<>();
		info.put("memberNo", memberNo);
		info.put("auctionNo", auctionNo);
		ChatRoomDto chatRoomDto = sqlSession.selectOne("chatroom.check", info);
		if(chatRoomDto == null) {
			int chatRoomNo = sqlSession.selectOne("chatroom.sequence");
			chatRoomDto = ChatRoomDto.builder()
					.chatRoomNo(chatRoomNo)
					.auctionNo(auctionNo)
					.memberNo(memberNo)
					.build();
			sqlSession.insert("chatroom.insert", chatRoomDto);
		}
		return chatRoomDto.getChatRoomNo();
	}
	
	@Override
	public List<ChatRoomListVO> list(int memberNo) {
		return sqlSession.selectList("chatroom.list", memberNo);
	}
	
	@Override
	public AuctionDetailVO auctionDetail(int auctionNo) {
		return sqlSession.selectOne("chatroom.auctionOne", auctionNo);
	}

	@Override
	public void report(ChatReportDto chatReportDto) {
		int chatReportNo = sqlSession.selectOne("chat_report.sequence");
		chatReportDto.setChatReportNo(chatReportNo);
		sqlSession.insert("chat_report.insert", chatReportDto);
	}
}
