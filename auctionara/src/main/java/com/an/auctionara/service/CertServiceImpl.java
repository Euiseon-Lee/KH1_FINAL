package com.an.auctionara.service;

import java.text.DecimalFormat;
import java.text.Format;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.an.auctionara.entity.CertDto;
import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.CertDao;
import com.an.auctionara.repository.MemberDao;

@Service
public class CertServiceImpl implements CertService {

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private MemberDao memberDao;	

	//인증번호 만들기
	private Random r = new Random();
	private Format f = new DecimalFormat("000000");

	@Override
	public void sendCert(String memberEmail) {
	
		//랜덤 인증번호 생성
		int certNumber = r.nextInt(1000000);
		String certString = f.format(certNumber);
		
		//전송할 이메일 제목 및 내용
		String title = "경매나라";
		String content = "인증번호 : "+certString;
		
		//메일에 요소 채우기
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(memberEmail);
		message.setSubject(title);
		message.setText(content);
		
		//메일 보내기
		mailSender.send(message);
		
		//인증번호를 DB에 저장
		certDao.makeCert(CertDto.builder()
									.memberNo(memberDao.checkEmail(memberEmail))
									.certTarget(memberEmail)
									.certNo(certString)
									.build());
	}
	
	@Override
	public void sendPwResetMail(MemberDto targetDto) throws MessagingException {
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		
		//메일 내용 구성
		helper.setTo(targetDto.getMemberEmail());
		helper.setSubject("경매나라 비밀번호 재설정");
		
		//랜덤 인증번호 생성
		int certNumber = r.nextInt(1000000);
		String certString = f.format(certNumber);
		
		String returnUri = ServletUriComponentsBuilder
								.fromCurrentContextPath()
								.path("/member/reset")
								.queryParam("memberNo", targetDto.getMemberNo())
								.queryParam("cert", certString)
								.toUriString();
		
		String content = 
				"<a href='"+returnUri+"'>"
					+ "비밀번호를 재설정하시려면 여기를 누르세요"
			+ "</a>";
		helper.setText(content, true);
		
		
		//메일 전송
		mailSender.send(message);
		
		
		//DB에 ??????
		certDao.makeCert(CertDto.builder()
									.certTarget(targetDto.getMemberEmail())
									.certNo(certString)
									.build());
	}
	
}
