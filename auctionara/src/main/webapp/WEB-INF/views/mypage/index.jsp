<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>



<div class="container d-flex">
<!-- 사이드바 -->

	<div class="row col-3 mt-3">
		<ul class="nav flex-column text-center">
		  <li class="nav-item border-bottom">
		  	<a href="${root}/mypage/index" class="nav-link btn-outline-secondary fw-bold fs-large">마이페이지</a>
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
		    <a href="${root}/mypage/cash_log" class="nav-link btn-outline-info">포인트/현금화</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/exit" class="nav-link btn-outline-info">회원 탈퇴</a>
		  </li>
		</ul>
	</div>
		
	<!-- 본문 -->
	<div class="row flex-fill d-flex flex-column">
		<div class="row col-3 m-3 d-inline">
			<img src="${pageContext.request.contextPath}${profileUrl}"
					class="img-thumbnail center-block">
		</div>
		
		<div class="row m-5 d-inline">
			<div>${memberDto.memberNick}</div>
			<div>${memberDto.memberEmail}</div>
			
			<table class="table-borderless table-responsive table-sm mt-3">
				<tr>
					<th class="text-left" style="width:50%;">보유 포인트</th>
					<td class="text-right">
						<a href="${root}/mypage/cash_log">${memberDto.memberHoldingPoints}p ></a>
					</td>
				</tr>
				<tr>
					<th class="text-left">총 경매 횟수</th>
					<td class="text-right">
						<a href="${root}/mypage/auction_history">
						
						</a>
					</td>
				</tr>
				<tr>
					<th class="text-left">총 낙찰 횟수</th>
					<td class="text-right">
						<a href="${root}/mypage/auction_history">
						
						</a>
					</td>
				</tr>
				<tr>
					<th class="text-left">경고횟수</th>
					<td class="text-right">
						<a href="${root}/mypage/auction_history">
							${memberDto.memberRedCount}회 >						
						</a>
					</td>
				</tr>
				<tr>
					<th class="text-left">거래 시간</th>
					<td class="text-right">
						<c:if test="${memberDto.memberPreference != null}">
							${memberDto.memberPreference}
						</c:if>
						<c:if test="${memberDto.memberPreference == null}">
							<a href="${root}/mypage/info">거래 선호시간을 설정해주세요</a>
						</c:if>
					</td>
				</tr>
				
	
	
			</table>			
			
		</div>
		
		

		
	
	</div>



</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>