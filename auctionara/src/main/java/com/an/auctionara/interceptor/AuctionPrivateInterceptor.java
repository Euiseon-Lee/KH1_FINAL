package com.an.auctionara.interceptor;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.HandlerMapping;

import com.an.auctionara.repository.AuctionDao;

@Component
public class AuctionPrivateInterceptor implements HandlerInterceptor {
	
	@Autowired
	private AuctionDao auctionDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Map pathVariable = (Map) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
		int auctionNo = Integer.parseInt((String) pathVariable.get("auctionNo"));

		if(auctionDao.checkPrivate(auctionNo)) {
			return true;
		} else {
			response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter(); 
	        out.println("<script>alert('비공개 처리 된 경매입니다'); location.href = 'http://localhost:8080/auctionara';</script>"); // 비공개 경매일 시 경고창 표시 후 이전 페이지로 돌아가기
	        out.flush();

			return false;
		}
	}
}


