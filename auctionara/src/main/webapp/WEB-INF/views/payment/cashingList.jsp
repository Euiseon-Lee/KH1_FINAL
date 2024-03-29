<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div id="app" class="container d-flex" v-cloak>
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
			<a href="${root}/payment/list" class="nav-link btn-outline-info">포인트 충전 내역</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root}/payment/cashing" class="nav-link btn-outline-info">현금화 신청</a>
		  </li>
		  <li class="nav-item border-bottom">
			<a href="${root}/payment/cashingList" class="nav-link btn-outline-info">현금화 신청 내역</a>
		  </li>
		  <li class="nav-item border-bottom">
		    <a href="${root}/mypage/exit" class="nav-link btn-outline-secondary">회원 탈퇴</a>
		  </li>
		</ul>
	</div>

	<div class="row flex-fill d-flex flex-column">
		<div class="col">
        	<h4 class="row fw-bold my-4 pt-2">내 현금화 신청 내역</h4>
        	<div class="row mb-4">
        		<div class="col-4 fw-bold">
        			총 출금액 <span class="text-info fs-large ml-2">{{ comma(totalMoney) }}원</span>
        		</div>
        		<div class="col-4 ml-5">
        		</div>
        		<div class="col pt-1 pr-0">
	        		<select class="form-select form-select-sm border-0 text-muted" v-model.number="filter" @change="updateList">
	                    <option value="0">전체</option>
	                    <option value="1">출금신청</option>
	                    <option value="2">출금완료</option>
	                    <option value="3">출금처리중</option>
	                    <option value="4">출금보류</option>
	                </select>
        		</div>        		
        		<div class="col pt-1 pl-0">
	        		<select class="form-select form-select-sm border-0 text-muted" v-model.number="sort" @change="updateList">
	                    <option value="0">최근 순</option>
	                    <option value="1">오래된 순</option>
	                    <option value="2">출금 금액↑순</option>
	                    <option value="3">출금 금액↓순</option>
	                </select>
        		</div>
        	</div>
        	<div class="row">
	        	<table class="table table-hover border-bottom">
					<thead>
				    	<tr>
				    		<th scope="col" class="col-2">신청일시</th>
				    		<th scope="col" class="col-2">출금 금액</th>
				    		<th scope="col">입금 받을 은행</th>
				    		<th scope="col">입금 받을 계좌</th>
				    		<th scope="col">진행 상태</th>
				    		<th scope="col" class="col-2">완료일시</th>
				    	</tr>
					</thead>
					<tbody>
				    	<tr v-for="(cashing, index) in list" :key="index">
				    		<td class="text-muted fs-small">{{ dateFormat(cashing.cashingRequestTime) }}</td>	    		
							<td class="fw-bold fs-small text-dark text-truncate">{{ comma(cashing.cashingMoney) }}원</td>
							<td class="fs-small fw-bold text-muted">{{ cashing.cashingBank }}</td>
							<td class="fs-small fw-bold text-muted">{{ cashing.cashingAccount }}</td>
				    		<td class="fs-small fw-bold">
				    			<span :class="{'text-primary' : cashing.cashingStatus == '출금신청', 
				    				'text-muted' : cashing.cashingStatus == '출금보류', 
				    				'text-success': cashing.cashingStatus == '출금완료',
				    				'text-info': cashing.cashingStatus == '출금처리중'}">{{ cashing.cashingStatus }}</span>
				    		</td>
				    		<td class="fs-small text-muted"><span v-if="cashing.cashingSuccessTime != null">{{ dateFormat(cashing.cashingSuccessTime) }}</span></td>
				    	</tr>			    			    
					</tbody>
				</table>
        	</div>
	        <div class="row justify-content-center mt-4">
		        <nav>
				  <ul class="pagination">
				    <li class="page-item" :class="{'disabled': pageList == 0}">
				    	<a class="page-link" href="#" @click="prev">
				        	<span aria-hidden="true">&laquo;</span>
				    	</a>
				    </li>			    
				    <li class="page-item" v-for="pageItem in totalPage" :key="pageItem" 
				    	:class="{'active': pageItem == page}" v-show="parseInt((pageItem - 1) / 10) == pageList">
				    	<a class="page-link" href="#" @click="pagination(pageItem)">{{ pageItem }}</a>
				    </li>
				    <li class="page-item" :class="{'disabled': parseInt((totalPage - 1) / 10) == pageList}">
				    	<a class="page-link" href="#" @click="next">
				        	<span aria-hidden="true">&raquo;</span>
				    	</a>
				    </li>			    
				  </ul>
				</nav>
	        </div>        	
        </div>
	</div>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
	const app = Vue.createApp({
        data() {
            return {
            	page: 1,
            	list: [],
            	filter: 0,
            	sort: 0,
				cashingCount: 0,
				totalPage: 1,
				pageList: 0,
				totalMoney: 0,
            };
        },
        methods: {
        	comma(money) { // 금액 콤마 찍기
        	  	return String(money).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        	},
        	dateFormat(time) { // 날짜 포맷
        		let date = new Date(time);
        	  	return date.getFullYear() + "." + (date.getMonth() + 1) + "." + date.getDate() + " " 
        	  		+ (date.getHours() < 10 ? "0" : "") + date.getHours() + ":" + (date.getMinutes() < 10 ? "0" : "") + date.getMinutes();
        	},
            loadFirst() { // 첫 리스트 불러오기
            	axios.get("${root}/payment/loadCashingList", {
            		params: {
            			page: this.page,
            			filter: this.filter,
            			sort: this.sort,
            	      }
            	})
            	.then(resp => {
    				this.list = resp.data;
    				if(resp.data.length != 0) {
        				this.cashingCount = resp.data[0].cashingCount;
        				this.totalPage = parseInt((resp.data[0].cashingCount - 1) / 10) + 1;
        				this.totalMoney = resp.data[0].totalMoney;
    				} else {
        				this.cashingCount = 0;
        				this.totalPage = 1;
        				this.totalMoney = 0;
    				}
            	})
            },           	
            loadMore() { // 리스트 불러오기
            	axios.get("${root}/payment/loadCashingList", {
            		params: {
            			page: this.page,
            			filter: this.filter,
            			sort: this.sort,
            	      }
            	})
            	.then(resp => {
    				this.list = resp.data;
    				if(resp.data.length != 0) {
        				this.cashingCount = resp.data[0].cashingCount;
        				this.totalPage = parseInt((resp.data[0].cashingCount - 1) / 10) + 1;    					
    				} else {
        				this.cashingCount = 0;
        				this.totalPage = 1;      					
    				}
            	})
            },
            updateList() { // 필터, 정렬 변경 시 리스트 갱신
            	this.page = 1;
            	this.pageList = 0;
            	this.loadMore();
            },
            pagination(pageItem) { // 페이지 교체
            	this.page = pageItem;
            	this.loadMore();
            },
            prev() { // 이전 페이지 리스트
            	this.pageList--;
            	this.page = (this.pageList * 10) + 1;
            	this.loadMore();
            },
            next() { // 다음 페이지 리스트
            	this.pageList++;
            	this.page = (this.pageList * 10) + 1;
            	this.loadMore();
            },
        },
        mounted() {
        	this.loadFirst(); // 1페이지 불러오기
        },
    });
    app.mount("#app");
</script>
<style scoped>
	#app {
		min-height: 700px;
	}
	
	select {
		font-size: 0.9em;
	}

	select:focus {
		outline: none;
	}
</style>

<%@include file="/WEB-INF/views/template/footer.jsp" %>