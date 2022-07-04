package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.CertDto;

@Repository
public class CertDaoImpl implements CertDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void makeCert(CertDto certDto) {
		int count = sqlSession.selectOne("cert.certExist", certDto.getCertTarget());
		
		if(count == 0) {
			sqlSession.insert("cert.makeCert", certDto);
		}
		else {
			sqlSession.update("cert.remakeCert", certDto);
		}
		
	}

	@Override
	public boolean certifyCert(CertDto certDto) {
		int count = sqlSession.selectOne("cert.certifyCert", certDto);
		
		if (count==1) {
			sqlSession.delete("cert.deleteUsedCert", certDto.getCertTarget());
			return true;
		}
		else {
			return false;
		}
	}

	@Override
	public void timeover() {
		sqlSession.delete("cert.timeover");
		
	}

}
