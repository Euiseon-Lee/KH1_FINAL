<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%@include file="/WEB-INF/views/admin/template/header.jsp" %>

<div id="app" class="container">

	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<h1>매출 현황</h1>
			</div>
		</div>
	</div>
	
	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<canvas id="netSalesChart"></canvas>
			</div>
		</div>
	</div>
		
	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<canvas id="pointsChart"></canvas>
			</div>
		</div>
	</div>
	
	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<canvas id="bidChart"></canvas>
			</div>
		</div>
	</div>
	
</div>

<!-- VueJS -->
<script src="https://unpkg.com/vue@next"></script>

<!-- 배포용 CDN -->
<!-- <script src="https://unpkg.com/vue@next/dist/vue.global.prod.js"></script> -->

<!-- axios CDN -->
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

<!-- chartJS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- JQuery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	$(function () {
	    $.ajax({
	        url: "${pageContext.request.contextPath}/rest/admin_main/monthly_total_net_sales",
	        type: "get",
	        success: function (resp) {
	            var labels = [];
	
	            for (var i = 0; i < resp.length; i++) {
	                labels.push(resp[i].month);  
	            }
	
	            var cnt = [];
	            for (var i = 0; i < resp.length; i++) {
	                cnt.push(resp[i].totalNetSales);
	            }
	
	            const data = {
	                labels: labels,
	                datasets: [{
	                    label: '순이익', // 범례 
	                    backgroundColor: '#3B7CDD', 
	                    borderColor: '#3B7CDD', 
	                    data: cnt,
	                }]
	            };
	
	            var config = {
	                type: 'line',
	                data: data,
	                options: {}
	            };
	
	            var myChart = new Chart(
	                document.querySelector('#netSalesChart'), 
	                config  
	            );
	        }
	    });
	    
	    $.ajax({
	        url: "${pageContext.request.contextPath}/rest/admin_main/monthly_total_points",
	        type: "get",
	        success: function (resp) {
	            var labels = [];
	
	            for (var i = 0; i < resp.length; i++) {
	                labels.push(resp[i].month);  
	            }
	
	            var cnt = [];
	            for (var i = 0; i < resp.length; i++) {
	                cnt.push(resp[i].totalPoints);
	            }
	
	            const data = {
	                labels: labels,
	                datasets: [{
	                    label: '충전 포인트', // 범례 
	                    backgroundColor: '#3B7CDD', 
	                    borderColor: '#3B7CDD', 
	                    data: cnt,
	                }]
	            };
	
	            var config = {
	                type: 'line',
	                data: data,
	                options: {}
	            };
	
	            var myChart = new Chart(
	                document.querySelector('#pointsChart'), 
	                config  
	            );
	        }
	    });
	    
	    $.ajax({
	        url: "${pageContext.request.contextPath}/rest/admin_main/monthly_bid",
	        type: "get",
	        success: function (resp) {
	            var labels = [];
	
	            for (var i = 0; i < resp.length; i++) {
	                labels.push(resp[i].month);  
	            }
	
	            var cnt = [];
	            for (var i = 0; i < resp.length; i++) {
	                cnt.push(resp[i].totalBid);
	            }
	
	            const data = {
	                labels: labels,
	                datasets: [{
	                    label: '낙찰액', // 범례 
	                    backgroundColor: '#3B7CDD', 
	                    borderColor: '#3B7CDD', 
	                    data: cnt,
	                }]
	            };
	
	            var config = {
	                type: 'line',
	                data: data,
	                options: {}
	            };
	
	            var myChart = new Chart(
	                document.querySelector('#bidChart'), 
	                config  
	            );
	        }
	    });
	});
</script>

<%@include file="/WEB-INF/views/admin/template/footer.jsp" %>