package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
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
	public void deleteToken(AutologinDto autologinDto) {
		sqlSession.delete("autologin.deleteToken", autologinDto);
		
	}


	
	
	
	
}
