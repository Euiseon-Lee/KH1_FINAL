package com.an.auctionara.interceptor;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class IsAdminInterceptor implements HandlerInterceptor{
	
	@Inject
	private HttpSession session;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String auth = (String) session.getAttribute("auth");

		if(auth.equals("관리자")) {
			return true;
		} else {
			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}
		
	}
}
