<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!-- 세션 정보 추가 -->
<c:set var="memberNo" value="${whoLogin}"></c:set>
<c:set var="isLogin" value="${memberNo != null}"></c:set>
<c:set var="isAdmin" value="${auth == '관리자'}"></c:set>
<c:set var="isBlackMamba" value="${auth == '블랙회원'}"></c:set>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>경매나라</title>

    <!-- 파비콘 -->
    <link rel="icon" href="${root}/image/favicon.ico">

    <!-- Noto Sans 폰트 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="${root}/css/reset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
    <link rel="stylesheet" type="text/css" href="${root}/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/custom.css">
</head>

<body>
    <div class="container">
        <nav class="navbar navbar-primary bg-white sticky-top pt-3">
            <a class="navbar-brand mb-2" href="${root}/">
                <img src="${root}/image/logo.png" alt="logo" class="d-inline-block">
            </a>
            <form class="position-relative">
                <input class="form-control bg-light rounded-pill border-0" type="search" placeholder="찾으시는 물품의 키워드를 입력해주세요">
                <i class="fa-solid fa-magnifying-glass text-secondary position-absolute"></i>
            </form>
            <div class="d-flex">
                <a href="${root}/auction/write"><button class="btn btn-primary rounded-pill"><i class="fa-solid fa-pen-to-square mx-1"></i> 경매 등록</button></a>
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">임시 메뉴</a>
                    <ul class="dropdown-menu ml-4">
                    
                    	<c:choose>
                    		<c:when test="${isLogin}">
								<li><a class="dropdown-item" href="${root}/">마이 페이지</a></li>
								<li><a class="dropdown-item" href="${root}/member/logout">로그아웃</a></li>
                    		</c:when>
                    		<c:otherwise>
                    			<li><a class="dropdown-item" href="${root}/member/login">로그인</a></li>
								<li><a class="dropdown-item" href="${root}/member/join">회원가입</a></li>
                    		</c:otherwise>
                    	</c:choose>
                    	

                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="${root}/">관리자 페이지</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
