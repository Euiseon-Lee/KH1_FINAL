package com.an.auctionara.repository;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.an.auctionara.entity.AttachmentDto;

@Repository
public class AttachmentDaoImpl implements AttachmentDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	private File directory = new File(System.getProperty("user.home") + "/upload");
	public AttachmentDaoImpl() {
		directory.mkdirs();
	}
	
	@Override
	public int save(MultipartFile attachment) throws IllegalStateException, IOException {
		int attachmentNo = sqlSession.selectOne("attachment.sequence");
		String fileName = String.valueOf(attachmentNo);
		File target = new File(directory, fileName);
		attachment.transferTo(target);
		sqlSession.insert("attachment.insert", AttachmentDto.builder()
														.attachmentNo(attachmentNo)
														.attachmentUploadname(attachment.getOriginalFilename())
														.attachmentSavename(fileName)
														.attachmentType(attachment.getContentType())
														.attachmentSize(attachment.getSize())
													.build());
		return attachmentNo;
	}
	
	@Override
	public AttachmentDto info(int attachmentNo) {
		return sqlSession.selectOne("attachment.one", attachmentNo);
	}
	
	@Override
	public ByteArrayResource load(String attachmentSavename) throws IOException {
		File target = new File(directory, attachmentSavename);
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		return resource;
	}
}
