<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%@include file="/WEB-INF/views/template/header.jsp" %>


<div id="app" class="container d-flex" v-cloak>
<!-- 사이드바 -->
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
	
	
	<!-- 본문 -->
	<div class="row flex-fill d-flex flex-column">
		<div class="col">
        	<h4 class="row fw-bold my-4 pt-2">내 경매 내역</h4>
        	<div class="row mb-4">
        		<div class="col-4 fw-bold">
        			총 받은 포인트 <span class="text-info fs-large ml-2">{{ comma(totalPoint) }}p</span>
        		</div>
        		<div class="col-5 d-flex justify-content-end">
        			<form class="position-relative" @submit="search">
		                <input class="form-control bg-light rounded-pill border-0" type="search" placeholder="검색" autocomplete="off" v-model="keyword">
		                <i class="fa-solid fa-magnifying-glass text-secondary position-absolute"></i>
		            </form>
        		</div>
        		<div class="col pt-1">
	        		<select class="form-select form-select-sm border-0 text-muted" v-model.number="filter" @change="updateList">
	                    <option value="0">전체</option>
	                    <option value="1">진행 중</option>
	                    <option value="2">마감</option>
	                    <option value="3">낙찰</option>
	                    <option value="4">거래 중</option>
	                    <option value="5">평가 전</option>
	                    <option value="6">평가 완료</option>
	                    <option value="7">미결제</option>
	                    <option value="8">경매 취소</option>
	                    <option value="9">경매 중지</option>
	                </select>
        		</div>        		
        		<div class="col pt-1">
	        		<select class="form-select form-select-sm border-0 text-muted" v-model.number="sort" @change="updateList">
	                    <option value="0">최신순</option>
	                    <option value="1">등록순</option>
	                    <option value="2">포인트순</option>
	                </select>
        		</div>
        	</div>
        	<div class="row">
	        	<table class="table table-hover border-bottom">
					<thead>
				    	<tr>
				    		<th scope="col" class="col-2">등록일시</th>
				    		<th scope="col" class="col-2 pointer" @click="categoryNo = 0; updateList();">카테고리</th>
				    		<th scope="col" class="col-5">경매 제목</th>
				    		<th scope="col">경매 상태</th>
				    		<th scope="col">받은 포인트</th>
				    	</tr>
					</thead>
					<tbody>
				    	<tr v-for="(auction, index) in list" :key="index">
				    		<td class="text-muted fs-small">{{ dateFormat(auction.auctionUploadTime) }}</td>
				    		<td class="text-muted fs-small pointer cate" @click="categoryNo = auction.categoryNo; updateList();">{{ auction.categoryName }}</td>
				    		<td class="fw-bold fs-small">
				    			<a v-if="auction.auctionProcess == 0" class="text-dark text-truncate" 
				    				:href="'${root}/auction/detail/' + auction.auctionNo">{{ auction.auctionTitle }}</a>
				    			<span v-if="auction.auctionProcess != 0" class="text-dark text-truncate">{{ auction.auctionTitle }}</span>
				    		</td>
				    		<td class="fs-small fw-bold">
				    			<span class="text-muted" v-if="auction.auctionProcess == 0 && auction.succBidStatus == 0 && auction.succBidNo == 0">{{ auction.auctionFinish }}</span>
				    			<a :href="'${root}/chat/auctioneer/' + auction.auctionNo"><span class="text-info" 
				    				v-if="auction.auctionProcess == 0 && auction.succBidStatus == 0 && auction.succBidNo != 0">낙찰</span></a>
				    			<a :href="'${root}/chat/auctioneer/' + auction.auctionNo"><span class="text-primary" 
				    				v-if="auction.auctionProcess == 0 && auction.succBidStatus == 1 && 
				    				(auction.succAuctioneerApprove == null || auction.succBidderApprove  == null)">거래 중</span></a>
				    			<a :href="'${root}/chat/auctioneer/' + auction.auctionNo"><span class="text-success" 
				    				v-if="auction.auctionProcess == 0 && auction.succBidStatus == 1 && auction.succAuctioneerApprove != null 
				    				&& auction.succBidderApprove != null && auction.ratingNo == 0">평가 전</span></a>
				    			<span class="text-success" v-if="auction.auctionProcess == 0 && auction.succBidStatus == 1 && auction.ratingNo != 0">평가 완료</span>
				    			<span class="text-muted" v-if="auction.auctionProcess == 0 && auction.succBidStatus == 2">미결제</span>
				    			<span class="text-muted" v-if="auction.auctionProcess == 1">경매 취소</span>
				    			<span class="text-muted" v-if="auction.auctionProcess == 2">경매 중지</span>
				    		</td>
				    		<td class="fs-small fw-bold text-muted">
				    			<span v-if="auction.auctionProcess == 0 && auction.succBidStatus == 1 
				    				&& auction.succAuctioneerApprove != null && auction.succBidderApprove != null">{{ comma(auction.succFinalBid) }}p</span>
				    		</td>
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
				keyword: "",
				categoryNo: 0,
				auctionCount: 0,
				totalPage: 1,
				pageList: 0,
				totalPoint: 0,
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
            	axios.get("http://localhost:8080/auctionara/mypage/auction_history/list", {
            		params: {
            			page: this.page,
            			filter: this.filter,
            			sort: this.sort,
            	      }
            	})
            	.then(resp => {
    				this.list = resp.data;
    				if(resp.data.length != 0) {
        				this.auctionCount = resp.data[0].auctionCount;
        				this.totalPage = parseInt((resp.data[0].auctionCount - 1) / 10) + 1;
        				this.totalPoint = resp.data[0].totalPoint;
    				} else {
        				this.auctionCount = 0;
        				this.totalPage = 1;
        				this.totalPoint = 0;
    				}
            	})
            },        	
            loadMore() { // 리스트 더 불러오기
            	axios.get("http://localhost:8080/auctionara/mypage/auction_history/list", {
            		params: {
            			page: this.page,
            			filter: this.filter,
            			sort: this.sort,
            			keyword: this.keyword,
            			categoryNo: this.categoryNo,
            	      }
            	})
            	.then(resp => {
    				this.list = resp.data;
    				if(resp.data.length != 0) {
        				this.auctionCount = resp.data[0].auctionCount;
        				this.totalPage = parseInt((resp.data[0].auctionCount - 1) / 10) + 1;    					
    				} else {
        				this.auctionCount = 0;
        				this.totalPage = 1;      					
    				}
            	})
            },
            updateList() { // 검색, 필터, 정렬 변경 시 리스트 갱신
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
            search(e) { // 검색
            	e.preventDefault();
            	this.updateList();
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
	
	.cate:hover {
		text-decoration: underline;
	}
	
	form {
	    width: 200px;
	}
	
	.fa-magnifying-glass {
	    top: 12px;
	    right: 25px;
	}
	
	select {
		font-size: 0.9em;
	}

	select:focus {
		outline: none;
	}	
</style>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>