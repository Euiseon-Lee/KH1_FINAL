package com.an.auctionara.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.an.auctionara.repository.GpsAddressDao;

@Component
public class AddressInterceptor implements HandlerInterceptor {
	
	@Autowired
	private GpsAddressDao gpsAddressDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		int memberNo = (int) request.getSession().getAttribute("whoLogin");
		
		if(gpsAddressDao.list(memberNo).isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/address");
			return false;
		} else {
			return true;
		}
	}
}


