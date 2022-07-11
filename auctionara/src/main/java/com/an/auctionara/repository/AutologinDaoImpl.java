package com.an.auctionara.repository;

import javax.servlet.http.Cookie;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.AutologinDto;

@Repository
public class AutologinDaoImpl implements AutologinDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertToken(AutologinDto autologinDto) {
		AutologinDto checkAutologinDto = sqlSession.selectOne("autologin.tokenExists", autologinDto.getMemberNo());		
				
		if(checkAutologinDto == null) {			
			sqlSession.insert("autologin.insertToken", autologinDto);
		}
		else {
			sqlSession.update("autologin.updateToken", autologinDto);
		}
	}

	@Override
	public AutologinDto returnToken(int memberNo) {
		return sqlSession.selectOne("autologin.tokenExists", memberNo);
	}

	@Override
	public void deleteToken(int memberNo) {
		sqlSession.delete("autologin.deleteToken", memberNo);
		
	}

	@Override
	public String memberNoforCookie(int memberNo) {
		String memberNoforString = Integer.toString(memberNo);
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String memberNoforCookie = encoder.encode(memberNoforString);
		
		return memberNoforCookie;
	}

	@Override
	public String autoIpforCookie(String autoIp) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String autoIpforCookie = encoder.encode(autoIp);
		return autoIpforCookie;
	}

	@Override
	public AutologinDto returnTokenforCookie(String autoToken) {
		return sqlSession.selectOne("autologin.returnTokenforCookie",autoToken);
	}

	
	


	
	
	
	
}
