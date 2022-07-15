<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

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
		<div class="accordion" id="accordionExample">
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="headingOne">
		      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
		       	나의 총 경매내역
		      </button>
		    </h2>
		    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        		<table class="table table-hover">
					<thead>
						<tr>
							<th>경매 번호</th>
							<th>카테고리</th>
							<th style="width:30%;">경매 제목</th>
							<th>등록일</th>
							<th>게시글 상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="memberVO" items="${list}">
							<tr>
								<td>${auctionDto.auctionNo}</td>
								<td>${auctionDto.categoryName}</td>
								<td>
									<a href="${pageContext.request.contextPath}/admin/auction/detail/${memberVO.auctionNo}">${memberVO.auctionTitle}</a>
								</td>
								<td>
									<fmt:parseDate value="${memberVO.auctionUploadTime}" var="auctionUploadDate" pattern="yyyy-MM-dd HH:ss"></fmt:parseDate>
									<fmt:formatDate value="${auctionUploadDate}" pattern="yyyy-MM-dd"/>
								</td>
								<td>
									${memberVO.auctionProcess}
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="headingTwo">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
		        Accordion Item #2
		      </button>
		    </h2>
		    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        <strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="headingThree">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
		        Accordion Item #3
		      </button>
		    </h2>
		    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
		      </div>
		    </div>
		  </div>
		</div>
	
	</div>
	
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>