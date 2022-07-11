package com.an.auctionara.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import com.an.auctionara.entity.AutologinDto;
import com.an.auctionara.repository.AutologinDao;

public class AutologinInterceptor implements HandlerInterceptor {

	@Inject
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private AutologinDao autologindDao;	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		Cookie autologinCookie = WebUtils.getCookie(request, "autologin");
		
		if(autologinCookie != null) {
			
			Cookie it = WebUtils.getCookie(request, "it");
			Cookie tn = WebUtils.getCookie(request, "tn");
			Cookie tp = WebUtils.getCookie(request, "tp");		
			
			String autoToken = it.getValue();
			String distortedMemberNo = tn.getValue();
			String distortedAutoIp = tp.getValue();
			
			AutologinDto autologinDto = autologindDao.returnTokenforCookie(autoToken);
			
			String memberNoforString = Integer.toString(autologinDto.getMemberNo());
			
			boolean isMemberNoSame = passwordEncoder.matches(memberNoforString, distortedMemberNo);
			boolean isAutoIpSame = passwordEncoder.matches(autologinDto.getAutoIp(), distortedAutoIp);
			
			if (isMemberNoSame && isAutoIpSame) {
				return true;
			}
			
			else {
				response.sendRedirect(request.getContextPath()+"/member/login");
				return false;
			}

		}
		
		else {
			response.sendRedirect(request.getContextPath()+"/member/login");
			return false;	
		}

	}
	

}
