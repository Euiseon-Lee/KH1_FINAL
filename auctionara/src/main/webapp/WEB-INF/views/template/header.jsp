<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
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
        <nav class="navbar navbar-expand-sm">
            <div class="container-fluid">
                <a class="navbar-brand" href="${root}/">
                    <img src="${root}/image/logo.PNG" alt="logo" class="d-inline-block">
                </a>
                <form>
                    <input class="form-control" type="search" placeholder="찾으시는 물품의 키워드를 입력해주세요">
                </form>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span>임시버튼</span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <a href="${root}/auction/write"><button class="btn btn-primary">경매등록</button></a>
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                임시 메뉴</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="${root}/">회원가입</a></li>
                                <li><a class="dropdown-item" href="${root}/">로그인</a></li>
                                <li><a class="dropdown-item" href="${root}/">마이 페이지</a></li>
                                <li><a class="dropdown-item" href="${root}/">로그아웃</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item" href="${root}/">관리자 페이지</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
