<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>



<div class="container d-flex">
<!-- 사이드바 -->

	<div class="row col-3 mt-4">
		<ul class="nav flex-column text-center">
		  <li class="nav-item border-bottom">
		  	<h4>
		  		<a href="${root}/mypage/index" class="nav-link btn-outline-secondary">마이페이지</a>
		  	</h4>
		  </li>
		  <li class="nav-item border-bottom">
		  	<a href="${root}/mypage/info" class="nav-link btn-outline-info">정보수정</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/exit" class="nav-link btn-outline-info">회원탈퇴</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/auction_history" class="nav-link btn-outline-info">경매내역</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/pay_history" class="nav-link btn-outline-info">결제완료내역</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/cash_log" class="nav-link btn-outline-info">포인트/현금화</a>
		  </li>
		</ul>
	</div>
		
	<!-- 본문 -->
	<div class="row flex-fill">
		<div class="row col-4 m-3 d-inline">
			<img src="${pageContext.request.contextPath}${profileUrl}"
					class="img-thumbnail center-block">
		</div>
		
		<div class="row col-4 m-5 d-inline">
			<div>${memberDto.memberNick}</div>
			<div>${memberDto.memberEmail}</div>
			
			<table class="table-borderless table-responsive table-sm mt-3">
				<tr>
					<th class="text-left">보유 포인트</th>
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
						${memberDto.memberRedCount}회 >
					</td>
				</tr>

				
	
	
			</table>			
			
		</div>
		
		

		
	
	</div>



</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>