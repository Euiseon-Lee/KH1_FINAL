<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="/WEB-INF/views/admin/template/header.jsp" %>

<div class="container">

	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<h1>회원 목록</h1>
			</div>
		</div>
	</div>
	
	<%-- <div class="row p-2 mt-2">
		<div class="col-10">
			<span></span>
		</div>
		<div class="col-2" id="app">
			<form action="list" method="get">
				<select class="form-select" name="type" onchange="this.form.submit()">
					<option value="">회원등급</option>
					<option value="member_grade" <c:if test="${member_grade == '일반회원'}">selected</c:if>>일반회원</option>
					<option value="member_grade" <c:if test="${member_grade == '블랙회원'}">selected</c:if>>블랙회원</option>
				</select>
			</form>
		</div>
	</div> --%>
	
	<div class="row p-2 mt-2">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>회원 번호</th>
					<th>닉네임</th>
					<th>이메일</th>
					<th>회원 등급</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="memberDto" items="${list}">
					<tr>
						<td>${memberDto.memberNo}</td>
						<td>${memberDto.memberNick}</td>
						<td>${memberDto.memberEmail}</td>
						
						<c:choose>
							<c:when test="${memberDto.memberGrade == '블랙회원'}">
								<td style="color:red;">${memberDto.memberGrade}</td>
							</c:when>
							<c:when test="${memberDto.memberGrade == '일반회원'}">
								<td style="color:black;">${memberDto.memberGrade}</td>
							</c:when>
							<c:otherwise>
								<td style="color:gray;">${memberDto.memberGrade}</td>
							</c:otherwise>
						</c:choose>
						
						<td><a href="${pageContext.request.contextPath}/admin/member/detail/${memberDto.memberNo}">상세보기</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class="p-2 mt-2 text-center pagination">
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
							<option value="member_nick" <c:if test="${type == 'member_nick'}">selected</c:if>>닉네임</option>
							<option value="member_email" <c:if test="${type == 'member_email'}">selected</c:if>>이메일</option>
						</select>
					</div>
					<div class="col-3">
						<input type="search" name="keyword" placeholder="검색어 입력" required class="form-control" value="${keyword}" autocomplete="off">
					</div>
					<div class="col-2">
						<input type="submit" value="검색" class="btn btn-primary">
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<%@include file="/WEB-INF/views/admin/template/footer.jsp" %>