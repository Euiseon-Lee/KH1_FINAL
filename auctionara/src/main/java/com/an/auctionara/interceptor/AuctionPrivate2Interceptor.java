package com.an.auctionara.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.an.auctionara.repository.AuctionDao;

@Component
public class AuctionPrivate2Interceptor implements HandlerInterceptor {
	
	@Autowired
	private AuctionDao auctionDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		int auctionNo = (int) request.getSession().getAttribute("auctionNo");

		if(auctionDao.checkPrivate(auctionNo)) {     
			return true;
		} else {
			response.sendError(403);
			return false;
		}
	}
}


