<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%@include file="/WEB-INF/views/admin/template/header.jsp" %>

<div id="app" class="container">
	
	<div class="row p-2">
		<h1>DashBoard</h1>
	</div>

	<div class="row mt-4">
		<div class="col-4">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<div class="col-3">
							<i class="fa-solid fa-won-sign fa-2x fa-pull-left"></i>
						</div>
						<div class="col-9">
							<div class="row">
								<h6 class="text-secondary">월 수익</h6>
							</div>
							<div class="row" var="">
								<h3>{{comma(monthlyNetSales)}}원</h3>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-4">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<div class="col-3">
							<i class="fa-solid fa-user fa-2x fa-pull-left"></i>
						</div>
						<div class="col-9">
							<div class="row">
								<h6 class="text-secondary">신규 회원</h6>
							</div>
							<div class="row">
								<h3>{{comma(memberCount)}}명</h3>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-4">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<div class="col-3">
							<i class="fa-solid fa-table-cells-large fa-2x fa-pull-left"></i>
						</div>
						<div class="col-9">
							<div class="row">
								<h6 class="text-secondary">경매 게시글</h6>
							</div>
							<div class="row">
								<h3>{{comma(auctionCount)}}건</h3>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="card">
		<div class="card-body">
			<div class="mt-2">
				<h2 class="text-secondary">순수익</h2>
			</div>
			<div class="mt-5">
				<canvas id="netSalesChart"></canvas>
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
<!-- <script src="https://code.jquery.com/jquery-3.6.0.js"></script> -->

<script>
	const app = Vue.createApp({
		data(){
			return{
				memberCount:"",
				monthlyNetSales:"",
				auctionCount:"",
				chartData:null,
				loading:false,
			};
		},
		computed:{
			
		},
		methods:{
			comma(money) {
        	  	return String(money).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        	},
			createNetSalesChart(){
				var labels = [];
				var totalNetSales = [];
				
				for(var i = 0; i < this.chartData.length; i++) {
					labels.push(this.chartData[i].month);
					totalNetSales.push(this.chartData[i].totalNetSales);
				}
				
	            const data = {
	                labels:labels,
	                datasets:[{
	                    backgroundColor: '#3B7CDD',
	                    borderColor: '#3B7CDD',
	                    data:totalNetSales,
	                }]
	            };
                
                const config = {
                    type:"line",
                    data:data,
                    options:{
                    	plugins:{
                    		legend: {
        	                	display: false
                        	}
                    	}
                    }
                };
                var myChart = new Chart(
                    document.querySelector("#netSalesChart"),
                    config
                );
            },
		},
		watch:{
            chartData(){
                if(!this.loading) return;
                this.createNetSalesChart();
            },
        },
		created(){
        	axios({
                url:"${pageContext.request.contextPath}/rest/admin_main/monthly_total_net_sales",
                method:"get"
            })
            .then((resp) => {
	           this.chartData = resp.data;  
            });
        	
			axios({
				url:"${pageContext.request.contextPath}/rest/admin_main/count_member",
				method:"get"
			})
			.then((resp) => {
				this.memberCount = resp.data;
			});
			
			axios({
				url:"${pageContext.request.contextPath}/rest/admin_main/monthly_net_sales",
				method:"get"
			})
			.then((resp) => {
				this.monthlyNetSales = resp.data;
			});
			
			axios({
				url:"${pageContext.request.contextPath}/rest/admin_main/count_auction",
				method:"get"
			})
			.then((resp) => {
				this.auctionCount = resp.data;
			});
		},
		mounted(){
            this.loading = true;
            if(this.netSalesData == null) return;
            this.createNetSalesChart();
        },
	});
	app.mount("#app");
</script>

<%@include file="/WEB-INF/views/admin/template/footer.jsp" %>