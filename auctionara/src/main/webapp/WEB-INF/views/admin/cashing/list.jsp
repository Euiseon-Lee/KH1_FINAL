<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
	<table>
		<thead>
			<tr>
				<th>신청 번호</th>
				<th>회원 번호</th>
				<th>신청 금액</th>
				<th>신청 은행</th>
				<th>신청 계좌번호</th>
				<th>현금화 유형</th>
				<th>현금화 상태</th>
				<th>현금화 신청시간</th>
				<th>현금화 완료시간</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="cashingPointsDto" items="${list}">
				<tr>
					<td>${cashingPointsDto.cashingNo}</td>
					<td>${cashingPointsDto.memberNo}</td>
					<td>${cashingPointsDto.cashingMoney}</td>
					<td>${cashingPointsDto.cashingBank}</td>
					<td>${cashingPointsDto.cashingAccount}</td>
					<td>${cashingPointsDto.cashingType}</td>
					<td>${cashingPointsDto.cashingStatus}</td>
					<td>${cashingPointsDto.cashingRequestTime}</td>
					<td>${cashingPointsDto.cashingSuccessTime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="row center pagination">
	
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
	
	<div class="row center">
		<!-- 검색창 -->
		<form action="list" method="get">
			<select name="type" class="form-input input-round">
				<option value="member_no" <c:if test="${type == 'member_no'}">selected</c:if>>제목</option>
				<option value="cashing_bank" <c:if test="${type == 'cashing_bank'}">selected</c:if>>내용</option>
			</select>
			
			<input type="search" name="keyword" placeholder="검색어 입력" required class="form-input input-round" value="${keyword}">
			
			<input type="submit" value="검색" class="btn btn-primary">
		</form>
	</div>
</div>