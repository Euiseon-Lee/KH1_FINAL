package com.an.auctionara.repository;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.an.auctionara.entity.ChatParticipatorDto;
import com.an.auctionara.entity.ChatRoomDto;
import com.an.auctionara.vo.AuctionDetailVO;
import com.an.auctionara.vo.ChatRoomListVO;
import com.an.auctionara.vo.ChatRoomSelectVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ChatRoomDaoImpl implements ChatRoomDao{
	
	@Autowired
	private SqlSession sqlSession;	
	
	
	@Override
	public List<ChatRoomListVO> list(int memberNo) {
		
		List<ChatRoomListVO> list = sqlSession.selectList("chatroom.list", memberNo);
		List<ChatRoomListVO> list2 = new ArrayList<>();
		list2.add(list.get(0));
		for(int i =0; i<list.size()-1; i++) {
			if(list.get(i).getChatRoomNo()!=list.get(i+1).getChatRoomNo()){
				list2.add(list.get(i+1));
			}
		}
		log.info("data: {}", list2.get(0).getChatTime());
		return list2;
	}
	
	@Override
	public int isJoin(int auctionNo, int memberNo, int auctioneerNo) {
		
		ChatRoomSelectVO crs = ChatRoomSelectVO.builder().auctionNo(auctionNo).memberNo(memberNo).build();
		
		int chatRoomNo = sqlSession.selectOne("chatroom.one", crs);
		log.info("chatRoomNo={}",chatRoomNo);
		if(chatRoomNo==0) {
			chatRoomNo = newChat(memberNo, auctionNo, auctioneerNo);
		}
		//없으면 0이 나오나..?
		
		return chatRoomNo;
		
	}
	
	@Override
	@Transactional
	public int newChat(int memberNo, int auctionNo, int auctioneerNo) {
		int chatroomNo = sqlSession.selectOne("chatroom.sequence");
		ChatRoomDto crd = ChatRoomDto.builder().auctionNo(auctionNo).chatRoomNo(chatroomNo).build();
		sqlSession.insert("chatroom.insert", crd);
		ChatParticipatorDto chatParticipator = ChatParticipatorDto.builder().chatRoomNo(chatroomNo).memberNo(memberNo).build();
		sqlSession.insert("chatParticipator.insert", chatParticipator);		
		ChatParticipatorDto chatParticipator2 = ChatParticipatorDto.builder().chatRoomNo(chatroomNo).memberNo(auctioneerNo).build();
		sqlSession.insert("chatParticipator.insert", chatParticipator2);
		
		return chatroomNo;
		
	}
	@Override
	public AuctionDetailVO auctionDetail(int auctionNo) {
		return sqlSession.selectOne("chatroom.auctionOne", auctionNo);
	}

}
