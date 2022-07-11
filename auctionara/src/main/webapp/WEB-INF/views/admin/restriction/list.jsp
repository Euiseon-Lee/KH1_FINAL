<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="/WEB-INF/views/admin/template/header.jsp" %>

<div class="container">
	
	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<h1>회원 제재 내역</h1>
			</div>
		</div>
	</div>
	
	<div class="row p-2 mt-2">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>제재 번호</th>
					<th style="width:15%;">제재 대상</th>
					<th>제재 유형</th>
					<th style="width:40%;">제재 내용</th>
					<th>제재 날짜</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="managerRestrictionListVO" items="${list}">
					<tr>
						<td>${managerRestrictionListVO.restrictionNo }</td>
						<td>${managerRestrictionListVO.memberName }</td>
						<td>${managerRestrictionListVO.restrictionType }</td>
						<td>${managerRestrictionListVO.restrictionReason }</td>
						<td>${managerRestrictionListVO.restrictionTime }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="row p-2 mt-2 text-center">
		<c:if test="${p > 1}">
			<c:choose>
				<c:when test="${search}">
					<a href="list?p=1&s=${s}&type=${type}&keyword=${keyword}">&laquo;</a>
				</c:when>
				<c:otherwise>
					<a href="list?p=1&s=${s}">&laquo;</a>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:if test="${startBlock > 1}">
			<c:choose>
				<c:when test="${search}">
					<a href="list?p=${startBlock-1}&s=${s}&type=${type}&keyword=${keyword}">&laquo;</a>
				</c:when>
				<c:otherwise>
					<a href="list?p=${startBlock-1}&s=${s}">&laquo;</a>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<!-- 숫자 링크 영역 -->
		<c:forEach var="i" begin="${startBlock}" end="${endBlock}" step="1">
			<c:choose>
				<c:when test="${search}">
					<c:choose>
						<c:when test="${i == p}">
							<a class="active" href="list?p=${i}&s=${s}&type=${type}&keyword=${keyword}">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="list?p=${i}&s=${s}&type=${type}&keyword=${keyword}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${i == p}">
							<a class="active" href="list?p=${i}&s=${s}">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="list?p=${i}&s=${s}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
		<!-- 다음 버튼 영역 -->
		<c:if test="${endBlock < lastPage}">
			<c:choose>
				<c:when test="${search}">
					<a href="list?p=${endBlock+1}&s=${s}&type=${type}&keyword=${keyword}">&gt;</a>
				</c:when>
				<c:otherwise>
					<a href="list?p=${endBlock+1}&s=${s}">&gt;</a>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:if test="${p < lastPage}">
			<c:choose>
				<c:when test="${search}">
					<a href="list?p=${lastPage}&s=${s}&type=${type}&keyword=${keyword}">&raquo;</a>
				</c:when>
				<c:otherwise>
					<a href="list?p=${lastPage}&s=${s}">&raquo;</a>
				</c:otherwise>
			</c:choose>
		</c:if>
	</div>
	
	<div class="row p-2 mt-2">
		<!-- 검색창 -->
		<form action="list" method="get">
			<div class="row justify-content-md-center">
				<div class="col-2">
					<select name="type" class="form-select">
						<option value="member_name" <c:if test="${type == 'member_name'}">selected</c:if>>제재 대상</option>
						<option value="restriction_type" <c:if test="${type == 'restriction_type'}">selected</c:if>>제재 유형</option>
						<option value="restriction_reason" <c:if test="${type == 'restriction_reason'}">selected</c:if>>제재 내용</option>
					</select>
				</div>
				<div class="col-3">
					<input type="search" name="keyword" placeholder="검색어 입력" required class="form-control" value="${keyword}">
				</div>
				<div class="col-2">
					<input type="submit" value="검색" class="btn btn-primary">
				</div>
			</div>
		</form>
	</div>
	
</div>

<%@include file="/WEB-INF/views/admin/template/footer.jsp" %>