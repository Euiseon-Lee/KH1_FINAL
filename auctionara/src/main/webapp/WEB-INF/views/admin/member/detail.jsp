<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>회원 상세정보</h1>

<h2>${memberDto.memberName }</h2>
<h2>${memberDto.memberSex }</h2>
<h2>${memberDto.memberBirth }</h2>
<h2>${memberDto.memberNick }</h2>
<h2>${memberDto.memberEmail }</h2>
<h2>${memberDto.memberHoldingPoints }</h2>
<h2>${memberDto.memberAvailableTime }</h2>
<h2>${memberDto.memberRedCount }</h2>
<h2>${memberDto.memberJoindate }</h2>
<h2>${memberDto.memberLogintime }</h2>
<h2>${memberDto.memberGrade }</h2>

<c:choose>
	<c:when test="${memberDto.memberGrade == '블랙회원' }">
		<a href="">일반회원 등록</a>
	</c:when>
	<c:when test="${memberDto.memberGrade == '일반회원' }">
		<a href="">블랙회원 등록</a>
	</c:when>
	<c:otherwise>
		<span></span>
	</c:otherwise>
</c:choose>
