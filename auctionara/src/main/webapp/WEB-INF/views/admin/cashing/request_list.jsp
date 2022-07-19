<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="/WEB-INF/views/admin/template/header.jsp" %>

<script>
	$(function(){
		$(".approve-cashing").click(function(e){
			var result = confirm("해당 현금화 신청을 승인하시겠습니까?");
			
			if(!result) {
				e.preventDefault();
			}
		});
		$(".refuse-cashing").click(function(e){
			var result = confirm("해당 현금화 신청을 거절하시겠습니까?");
			
			if(!result) {
				e.preventDefault(); 
			}
		});
	});
</script>

<div class="container">
	
	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<h1>현금화 신청 내역</h1>
			</div>
		</div>
	</div>
	
	<div class="row p-2 mt-2">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>신청 번호</th>
					<th>닉네임</th>
					<th>신청 금액</th>
					<th>신청 은행</th>
					<th>신청 계좌번호</th>
					<th>현금화 상태</th>
					<th>현금화 신청시간</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="cashingPointsVO" items="${requestList}">
					<tr>
						<td>${cashingPointsVO.cashingNo}</td>
						<td>${cashingPointsVO.memberNick}</td>
						<td>${cashingPointsVO.cashingMoney}</td>
						<td>${cashingPointsVO.cashingBank}</td>
						<td>${cashingPointsVO.cashingAccount}</td>
						<td>${cashingPointsVO.cashingStatus}</td>
						<td>${cashingPointsVO.cashingRequestTime}</td>
						<td>
							<a href="approve/${cashingPointsVO.cashingNo}/${cashingPointsVO.cashingMoney}/${cashingPointsVO.memberNo}" class="approve-cashing">승인</a>
							&nbsp|&nbsp
							<a href="refuse/${cashingPointsVO.cashingNo}" class="refuse-cashing">보류</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
</div>

<%@include file="/WEB-INF/views/admin/template/footer.jsp" %>