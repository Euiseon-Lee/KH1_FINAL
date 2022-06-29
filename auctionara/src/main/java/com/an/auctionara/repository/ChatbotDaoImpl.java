package com.an.auctionara.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.ChatbotDto;

@Repository
public class ChatbotDaoImpl implements ChatbotDao {
	
	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public List<ChatbotDto> list() {
		// 목록 출력 메소드 
		return sqlSession.selectList("chatbot.list");
	}
	
	@Override
	public ChatbotDto insert(ChatbotDto chatbotDto) {
		// 등록 메소드 
		
		// 시퀀스 번호 추출 
		int chatbotNo = sqlSession.selectOne("chatbot.sequence");
		// chatbotDto에 chatbotNo 등록
		chatbotDto.setChatbotNo(chatbotNo);
		// insert 진행 
		sqlSession.insert("chatbot.insert", chatbotDto);
		return chatbotDto; 
	}
	
	@Override
	public void delete(int chatbotNo) {
		// 삭제 메소드 
		sqlSession.delete("chatbot.delete", chatbotNo);
	}
	
	@Override
	public ChatbotDto update(ChatbotDto chatbotDto) {
		// 수정 메소드 
		int count = sqlSession.update("chatbot.update", chatbotDto);
//		if(count == 0) throw new CannotFindException();
		
		return sqlSession.selectOne("chatbot.one", chatbotDto.getChatbotNo());
	}
}
