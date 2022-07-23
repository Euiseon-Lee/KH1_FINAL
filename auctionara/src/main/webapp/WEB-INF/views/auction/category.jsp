<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div id="app" class="mt-5">
    <div class="container-fluid" v-cloak>
    	<div class="row pb-5 mb-3 border-bottom" :class="{'pl-4': categoryPage == 1}">
    		<div class="col-1 pl-0 category-btn" v-show="categoryPage == 2" @click="categoryPrev"><i class="fa-solid fa-chevron-left pt-4 text-secondary"></i></div>
	    	<c:forEach var="categoryDto" items="${categoryList}">
	    		<a class="col category-link" :class="{'col-1': categoryPage == 2}" v-show="category.includes(${categoryDto.categoryNo})" @click="selectCategory(${categoryDto.categoryNo}, '${categoryDto.categoryName}')">
	    			<span class="row justify-content-center mb-2"><img class="category-img" :class="{'border': categoryNo == ${categoryDto.categoryNo}, 'border-primary': categoryNo == ${categoryDto.categoryNo}}" src="${root}/image/category${categoryDto.categoryNo}.jpg"></img></span>
	    			<span id="no${categoryDto.categoryNo}" class="row fw-bold category-name justify-content-center" :class="{'text-primary': categoryNo == ${categoryDto.categoryNo}, 'text-dark': categoryNo != ${categoryDto.categoryNo}}">${categoryDto.categoryName}</span>
	    		</a>	    		
	    	</c:forEach>
	    	<div class="col pr-0 category-btn" v-show="categoryPage == 1" @click="categoryNext"><i class="fa-solid fa-chevron-right pt-4 text-secondary"></i></div>
    	</div>
        <div class="row mb-4 pt-4">
            <div class="col-9 mr-5">
                <h4 class="fw-bold">{{ categoryName }}</h4>
            </div>
            <div class="col-1 pr-0 ml-3">
                <select class="form-select form-select-sm border-0 text-muted" v-model.number="filter" @change="updateList">
                    <option value="0" v-if="${addressCount}">전체</option>
                    <option value="1">주소1</option>
                    <option value="2" v-if="${addressCount}">주소2</option>
                </select>
            </div>
            <div class="col pl-0">
                <select class="form-select form-select-sm border-0 text-muted" v-model.number="sort" @change="updateList">
                    <option value="0">최신 등록순</option>
                    <option value="1">입찰가&#8593;순</option>
                    <option value="2">입찰가&#8595;순</option>
                    <option value="3">마감 임박순</option>
                    <option value="4">우수 판매자순</option>
                </select>
            </div>
        </div>
        <div id="list-wrap" class="row row-cols-4">
            <div class="col" v-for="(auction, index) in list" :key="auction.auctionNo">
            	<div class="card rounded border-0 mb-4 px-2">
                	<img :src="'${root}/attachment/download?attachmentNo=' + auction.photoAttachmentNo" class="card-img-top card-img-custom">
                	<div class="card-img-overlay p-0 pr-2" v-if="auction.deadlineClosing">
                		<span id="deadline" class="card-title bg-primary text-white px-2 py-1 fw-bold">마감임박</span>
                	</div>
                    <div class="card-body p-0 pt-4">
                    	<h6 class="card-title text-truncate fw-bold">{{ auction.auctionTitle }}</h6>
                        <div class="d-flex">
	                        <p class="card-text flex-grow-1" v-if="auction.biddingPrice == 0">현재
	                        	<span class="text-primary">{{ comma(auction.auctionOpeningBid) }}</span>원
	                        </p>
	                        <p class="card-text flex-grow-1" v-if="auction.biddingPrice != 0">현재
	                            <span class="text-primary">{{ comma(auction.biddingPrice) }}</span>원
	                        </p>
	                        <p class="card-text">남은 <span class="text-primary">{{ auction.auctionRemainTime }}</span></p>
						</div>
					<a :href="'${root}/auction/detail/' + auction.auctionNo" class="stretched-link"></a>
					</div>
				</div>
        	</div>
        </div>
    </div>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=714d787408b068ef9f0ff6126a1c0b99&libraries=services"></script>
<script>
	const app = Vue.createApp({
        data() {
            return {
            	page: 1,
            	list: [],
            	filter: 0,
            	sort: 0,
            	categoryName: "",
            	category: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
            	categoryPage: 1,
            	categoryNo: 0,
            };
        },
        methods: {
        	comma(money) {
        	  	return String(money).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        	},
            listScroll(e) { // 스크롤 바닥 감지
                const bottom = document.body.offsetHeight === window.innerHeight + window.scrollY;
                if(bottom) this.loadMore();
            },
            loadMore() { // 카테고리별 경매 불러오기
            	axios.get("${root}/list", {
            		params: {
            			page: this.page,
            			filter: this.filter,
            			sort: this.sort,
            			categoryNo: this.categoryNo,
            	      }
            	})
            	.then(resp => {
            		if(resp.data.length != 0) {
    					this.list = this.list.concat(resp.data);
    					this.page++;
            		} else { // 불러올 리스트가 더 없으면 스크롤 이벤트 삭제  
            			window.removeEventListener("scroll", this.listScroll);
            		}
            	})
            },
            updateList() { // 필터 or 정렬 변경 시 리스트 갱신
            	this.list = [];
            	this.page = 1;
            	window.addEventListener("scroll", this.listScroll);
            	this.loadMore();
            },
            categoryNext() {
            	this.category = [14, 15, 16, 17, 18];
            	this.categoryPage = 2;
            }, 
            categoryPrev() {
            	this.category = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
            	this.categoryPage = 1;
            },
            getCategory() { // 카테고리 추출
            	this.categoryNo = parseInt(location.search.replace("?categoryNo=", ""));
            	this.categoryName = document.getElementById("no" + this.categoryNo).innerText;
            	if(!this.category.includes(this.categoryNo)) {
            		this.categoryNext();
            	}
            },
            selectCategory(categoryNo, categoryName) { // 카테고리 선택
            	this.categoryNo = categoryNo;
            	this.categoryName = categoryName;
            	history.pushState(null, null, "${root}/auction/category?categoryNo=" + this.categoryNo); // URL 변경
            	this.updateList();
            },
        },
        mounted() {
        	this.getCategory();
        	this.loadMore(); // 카테고리별 1페이지
        	if(!${addressCount}) {
        		this.filter = 1;
        	}
        	window.addEventListener("scroll", this.listScroll);
        },
        beforeDestroy() {
        	window.removeEventListener("scroll", this.listScroll);
        },
    });
    app.mount("#app");
</script>
<style scoped>
	select {
		font-size: 0.9em;
	}

	select:focus {
		outline: none;
	}
	
	.border-primary {
		border-width: 2px !important;
	}
	
	#list-wrap {
		min-height: 300px;
	}
</style>

<%@include file="/WEB-INF/views/template/chatbot.jsp" %>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
