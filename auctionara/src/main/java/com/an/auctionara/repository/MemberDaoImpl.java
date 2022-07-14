package com.an.auctionara.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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


	@Override
	public MemberDto login(String memberEmail, String memberPw) {
		MemberDto memberDto = sqlSession.selectOne("member.login", memberEmail);
		
		if(memberDto == null) {
			return null;
		}
		
		
		boolean isPwIdentical = memberDto.getMemberPw().equals(memberPw);
		if(isPwIdentical) {
			sqlSession.update("member.updateLogintime", memberDto.getMemberNo());
			return memberDto;
		}
		else {
			return null;
		}
	}


	@Override
	public MemberDto memberSearch(int memberNo) {
		MemberDto memberDto = sqlSession.selectOne("member.one", memberNo);
		return memberDto;
	}


	@Override
	public int checkEmailNum(String memberEmail) {
		int result = sqlSession.selectOne("member.checkEmailNum", memberEmail);
		
		return result;
	}


	@Override
	public void plusRedCount(int memberNo) {
		// member_red_count 컬럼 증가용 메소드 
		int count = sqlSession.update("member.plusRedCount", memberNo);
//		if(count == 0) throw new CannotFindException();
	}


	@Override
	public boolean checkMemberNo(String memberEmail) {
		Integer memberNo = sqlSession.selectOne("member.checkMemberNo", memberEmail);
		
		if(memberNo==null) return false;
		else return true;
		
	}
	
	
	@Override
	public List<MemberDto> list(String type, String keyword, int p, int s) {
		// 관리자 페이지 - 회원 목록 조회 메소드 
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		int end = p * s;
		int begin = end - (s - 1);
		
		param.put("begin", begin);
		param.put("end", end);
		
		return sqlSession.selectList("member.list", param);
	}
	
	
	@Override
	public int count(String type, String keyword) {
		// 관리자 페이지 - 회원 목록 페이징을 위한 count 메소드 
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("type", type);
		param.put("keyword", keyword);
		
		return sqlSession.selectOne("member.count", param);	
	}
	
	
	@Override
	public MemberDto setGeneral(int memberNo) {
		// 관리자 페이지 - 일반회원 등록 메소드
		int count = sqlSession.update("member.setGeneral", memberNo);
//		if(count == 0) throw new CannotFindException();
		
		return sqlSession.selectOne("member.one", memberNo);
	}
	
	
	@Override
	public MemberDto setBlock(int memberNo) {
		// 관리자 페이지 - 블랙회원 등록 메소드 
		int count = sqlSession.update("member.setBlock", memberNo);
//		if(count == 0) throw new CannotFindException();
		
		return sqlSession.selectOne("member.one", memberNo);
	}


	
	//암호화 전 코드 => 암호화 이후 수정 필요
	@Override
	public boolean resetPw(MemberDto memberDto) {
		
		if(memberDto == null) return false;
		
		int count = sqlSession.update("member.changePw", memberDto);
//						MemberDto.builder()
//							.memberEmail(memberDto.getMemberEmail())
//							.memberPw(memberDto.getMemberPw())
//							.build());
		
		return count > 0;
	}
	
	
	// 관리자
	@Override
	public int countMember() {
		// 회원 수 count 메소드 
		return sqlSession.selectOne("member.countMember");
	}
	
	
	@Override
	public MemberDto deductPoints(int memberNo, int cashingMoney) {
		// 관리자 - 현금화 승인 후 보유 포인트 차감 메소드
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("memberNo", memberNo);
		param.put("cashingMoney", cashingMoney);
		
		int count = sqlSession.update("member.deductPoint", param);
//		if(count == 0) throw new CannotFindException();
		
		return sqlSession.selectOne("member.one", memberNo);
	}
}
