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
	<div class="row flex-fill d-flex flex-column">
		<div class="col">
        	<h4 class="row fw-bold my-4 pt-2">내 경매 내역</h4>
        	<table class="table table-hover">
			  <thead>
			    <tr>
			      <th scope="col">등록일시</th>
			      <th scope="col">카테고리</th>
			      <th scope="col">경매 제목</th>
			      <th scope="col">마감일시</th>
			      <th scope="col">경매 상태</th>
			      <th scope="col"></th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <td></td>
			    </tr>
			    <tr>
			      <td></td>
			    </tr>
			    <tr>
			      <td class="fw-bold text-info"></td>
			    </tr>
			    <tr>
			      <td></td>
			    </tr>
			    <tr>
			      <td></td>
			    </tr>
			    <tr>
			      <td></td>
			    </tr>			    			    
			  </tbody>
			</table>
        </div>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>