<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container d-flex">
	<div class="row col-3 mt-3">
		<ul class="nav flex-column text-center">
		  <li class="nav-item border-bottom">
		  	<a href="${root}/mypage/index" class="nav-link btn-outline-dark fw-bold fs-large">마이페이지</a>
		  </li>
		  <li class="nav-item border-bottom">
		  	<a href="${root}/mypage/info" class="nav-link btn-outline-info">내 정보 수정</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/auction_history" class="nav-link btn-outline-info">내 경매</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/pay_history" class="nav-link btn-outline-info">내 입찰</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root}/payment/paymentReady" class="nav-link btn-outline-info">포인트 충전</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root }/payment/list" class="nav-link btn-outline-info">포인트 충전 취소</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root }/payment/cashing" class="nav-link btn-outline-info">현금화 신청</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root }/payment/cashingList" class="nav-link btn-outline-info">현금화 신청 목록</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/exit" class="nav-link btn-outline-secondary">회원 탈퇴</a>
		  </li>
		</ul>
	</div>
	
		<div class="row flex-fill d-flex flex-column">
	        <h4 class="row fw-bold my-4 pt-2">현금화 신청 목록</h4>
	        
	        <div class="row">
		        <table  class="table table-hover border-bottom">
					<thead>
						<tr>
							<th scope="col" width="20%">신청 일시</th>
							<th scope="col">신청 은행</th>
							<th scope="col" width="30%">신청 계좌</th>
							<th scope="col">진행 상태</th>
							<th scope="col">완료 일시</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var = "list" items="${cashingList}">
							<tr>
								<td class="text-muted fs-small"><fmt:formatDate value="${list.cashingRequestTime }" pattern="yyyy.MM.dd HH:mm"></fmt:formatDate></td>
								<td class="fs-small">${list.cashingBank }</td>
								<td class="fs-small">${list.cashingAccount }</td>
								<c:choose>
									<c:when test="${list.cashingStatus == '출금신청' }">
										<td class="fs-small">${list.cashingStatus }</td>									
									</c:when>
									<c:when test="${list.cashingStatus == '출금보류' }">
										<td class="fs-small text-primary">${list.cashingStatus }</td>
									</c:when>
									<c:when test="${list.cashingStatus == '출금완료' }">
										<td class="fs-small text-info">${list.cashingStatus }</td>
									</c:when>
								</c:choose>
								<td class="text-muted fs-small"><fmt:formatDate value="${list.cashingSuccessTime }" pattern="yyyy.MM.dd HH:mm"></fmt:formatDate></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
	        </div>
        </div>
        
</div>




<%@include file="/WEB-INF/views/template/footer.jsp" %>