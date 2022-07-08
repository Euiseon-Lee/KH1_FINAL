<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
	<meta name="author" content="AdminKit">
	<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="img/icons/icon-48x48.png" />

	<link rel="canonical" href="https://demo-basic.adminkit.io/" />

	<title>경매나라 Admin</title>

	<link href="${root}/css/app.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
		$(function(){
			var url = window.location
			$('li.sidebar-item a').filter(function() {
				 return this.href == url;
			}).parent().addClass('active');
		});
	</script>
</head>

<body>
	<div class="wrapper">
		<nav id="sidebar" class="sidebar js-sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="${root}/admin/">
		          <span class="align-middle">경매나라 Admin</span>
		        </a>

				<ul class="sidebar-nav">
					<li class="sidebar-header">
						매출 관리
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <span class="align-middle">매출 현황</span>
			            </a>
					</li>
					
					<li class="sidebar-header">
						회원 관리
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="${root}/admin/member/list">
			              <span class="align-middle">회원 목록</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <span class="align-middle">평가 항목 관리</span>
			            </a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="${root}/admin/restriction/list">
			              <span class="align-middle">제재 목록</span>
			            </a>
					</li>
					
					<li class="sidebar-header">
						현금화 관리
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="${root}/admin/cashing/list">
			              <span class="align-middle">현금화 목록</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="${root}/admin/cashing/request_list">
			              <span class="align-middle">현금화 신청 내역</span>
			            </a>
					</li>
					
					<li class="sidebar-header">
						경매 관리
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="${root}/admin/auction/list">
			              <span class="align-middle">경매 게시글 목록</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <span class="align-middle">카테고리 관리</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="${root}/admin/auction/report_list">
			              <span class="align-middle">신고 내역</span>
			            </a>
					</li>
					
					<li class="sidebar-header">
						채팅 / 챗봇 관리 
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <span class="align-middle">챗봇 관리</span>
			            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="#">
			              <span class="align-middle">채팅 신고 내역</span>
			            </a>
					</li>
				</ul>
			</div>
		</nav>

		<div class="main">
			<nav class="navbar navbar-expand navbar-light navbar-bg">
				<div class="list-group text-end">
									
				</div>
			</nav>

			<main class="content">
