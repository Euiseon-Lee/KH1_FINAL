package com.an.auctionara.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import com.an.auctionara.entity.AutologinDto;
import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.AutologinDao;
import com.an.auctionara.repository.MemberDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class AutologinInterceptor implements HandlerInterceptor {

	@Inject
	private PasswordEncoder passwordEncoder;
	
	@Inject
	private HttpSession session;
	
	@Autowired
	private AutologinDao autologinDao;	
	
	@Autowired
	private MemberDao memberDao;
	
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

//			log.debug("autoToken = {}", autoToken);
//			log.debug("distortedMemberNo = {}", distortedMemberNo);
//			log.debug("distortedAutoIp = {}", distortedAutoIp);
			
			AutologinDto autologinDto = autologinDao.returnTokenforCookie(autoToken);
//			log.debug("autologinDto = {}", autologinDto);
			
			if(autologinDto == null) {
			    //자동로그인 관련 정보 제거 
			    tn.setMaxAge(0);
			    it.setMaxAge(0);
			    tp.setMaxAge(0);
			    
			    tn.setPath("/");
			    it.setPath("/");
			    tp.setPath("/");
			    
			    response.addCookie(tn);
			    response.addCookie(it);
			    response.addCookie(tp);
			    
				
				//쿠키에 자동로그인 체크 빼기
				Cookie ck = new Cookie("autologin", "");
			    ck.setMaxAge(0);
			    ck.setPath("/");
			    response.addCookie(ck);
			    
				//세션정보 제거
				session.removeAttribute("whoLogin");
				session.removeAttribute("auth");
			    
//				response.sendRedirect(request.getContextPath() + "/member/login");				
//				return false;
			}
			
			else {
				String memberNoforString = Integer.toString(autologinDto.getMemberNo());
				boolean isMemberNoSame = passwordEncoder.matches(memberNoforString, distortedMemberNo);
				boolean isAutoIpSame = passwordEncoder.matches(autologinDto.getAutoIp(), distortedAutoIp);
				
				if (isMemberNoSame && isAutoIpSame) {
					
					MemberDto memberDto = memberDao.memberSearch(autologinDto.getMemberNo());
					
					session.setAttribute("whoLogin", memberDto.getMemberNo());
					session.setAttribute("auth", memberDto.getMemberGrade());	
					
				}
			}	
		}
		return true;	
	}
}
