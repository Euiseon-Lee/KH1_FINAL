package com.an.auctionara.controller;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.an.auctionara.entity.AttachmentDto;
import com.an.auctionara.repository.AttachmentDao;

@RestController
@RequestMapping("/attachment")
public class AttachmentController {

	@Autowired
	private AttachmentDao attachmentDao;
	
	@PostMapping("/save")
	public void save(@RequestParam(value = "attachment", required = false) List<MultipartFile> attachment, HttpSession session) throws IllegalStateException, IOException {
		for(int i = 0; i < attachment.size(); i++) {
			attachmentDao.save(attachment.get(i));
		}
	}
	
	@GetMapping("/download")
	public ResponseEntity<ByteArrayResource> download(
			@RequestParam int attachmentNo) throws IOException {
		AttachmentDto attachmentDto = attachmentDao.info(attachmentNo);
		ByteArrayResource resource = 
				attachmentDao.load(attachmentDto.getAttachmentSavename());
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(attachmentDto.getAttachmentSize())
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.header(HttpHeaders.CONTENT_DISPOSITION, 
						ContentDisposition.attachment()
								.filename(attachmentDto.getAttachmentUploadname(), StandardCharsets.UTF_8)
								.build()
								.toString()
				)
			.body(resource);
	}	
}
