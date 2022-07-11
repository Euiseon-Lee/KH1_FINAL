package com.an.auctionara.interceptor;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class IsLoginInterceptor implements HandlerInterceptor {
	
	@Inject
	private HttpSession session;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		if(session.getAttribute("whoLogin") != null) {
			return true;
		}
		
		response.sendRedirect(request.getContextPath() + "/member/login");
		return false;
	}

}
