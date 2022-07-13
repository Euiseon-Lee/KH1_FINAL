package com.an.auctionara.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.AttachmentDao;
import com.an.auctionara.repository.MemberDao;

import lombok.extern.slf4j.Slf4j;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	
	
	//첨부파일(프로필) 없이 구현함 이후 추가 구현 필요
	@Override
	@Transactional
	public void join(MemberDto memberDto, MultipartFile attachment) throws IllegalStateException, IOException {
		
		System.out.println(attachment);
		
		//프로필 등록코드
		if(!attachment.isEmpty())	{
			
			int attachmentNo = attachmentDao.save(attachment);
			
			memberDto.setAttachmentNo(attachmentNo);
	
			memberDao.join(memberDto);
			
			
		}
		
		
		
	}




}
