package com.an.auctionara.cashing.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.an.auctionara.entity.CashingPointsDto;
import com.an.auctionara.repository.CashingPointsDao;
import com.an.auctionara.vo.CashingPointsListVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class CashingPointsTest {
	
	@Autowired
	private CashingPointsDao cashingPointsDao;
	
	@Test
	public void test() {
		List<CashingPointsListVO> requestList = cashingPointsDao.requestList();
		
		System.out.println(requestList);
		
		for(CashingPointsListVO vo : requestList) {
			System.out.println(vo);
		}
		
	}
}
