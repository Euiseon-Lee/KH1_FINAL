<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div id="app" class="mt-4">
    <div class="container-fluid bg-info gps mb-5">
        <div class="row position-relative">
            <div class="col-8 py-4 px-5">
                <h5 class="text-white mt-1">지금 내 대표 동네는</h5>
                <h5 class="text-white"><span class="h4 text-truncate" id="address1"></span> 입니다</h5>
            </div>
            <div class="col py-4 px-3 bg-light" id="map">
            </div>
            <a href="${root}/address" class="btn btn-info rounded-pill position-absolute" role="button">내 동네 변경 <i class="fa-solid fa-angle-right"></i></a>
        </div>
    </div>

    <div class="container-fluid" v-cloak>
    	<div class="row pb-5 border-bottom" :class="{'pl-4': categoryPage == 1}">
    		<div class="col-1 pl-0 category-btn" v-show="categoryPage == 2" @click="categoryPrev"><i class="fa-solid fa-chevron-left pt-4 text-secondary"></i></div>
	    	<c:forEach var="categoryDto" items="${categoryList}">
	    		<a class="col category-link" :class="{'col-1': categoryPage == 2}" v-show="category.includes(${categoryDto.categoryNo})" href="${root}/auction/category?categoryNo=${categoryDto.categoryNo}">
	    			<span class="row justify-content-center mb-2"><img class="category-img" src="${root}/image/category${categoryDto.categoryNo}.jpg"></img></span>
	    			<span class="row fw-bold text-dark category-name justify-content-center">${categoryDto.categoryName}</span>
	    		</a>	    		
	    	</c:forEach>
	    	<div class="col pr-0 category-btn" v-show="categoryPage == 1" @click="categoryNext"><i class="fa-solid fa-chevron-right pt-4 text-secondary"></i></div>
    	</div>
    	<c:if test="${!empty myBiddingAuctionList}">
    	<div class="row mb-4 mt-5">
            <div class="col">
                <h4 class="fw-bold">내 최근 입찰 경매</h4>
            </div>
            <div class="col-2 d-flex justify-content-end">
            	<a class="btn btn-primary btn-sm rounded-pill px-3 my-1 mr-3" href="${root}/mypage/pay_history" role="button">더 보기</a>
            </div>
    	</div>
    	<div class="row row-cols-4 border-bottom pb-3">
    	<c:forEach var="myBiddingAuction" items="${myBiddingAuctionList}">
            <div class="col">
            	<div class="card rounded border-0 mb-4 px-2">
                	<img src="${root}/attachment/download?attachmentNo=${myBiddingAuction.photoAttachmentNo}" class="card-img-top card-img-custom">
                	<div class="card-img-overlay p-0 pr-2" v-if="${myBiddingAuction.deadlineClosing}">
                		<span id="deadline" class="card-title bg-primary text-white px-2 py-1 fw-bold">마감임박</span>
                	</div>
                    <div class="card-body p-0 pt-4">
                    	<h6 class="card-title text-truncate fw-bold">${myBiddingAuction.auctionTitle}</h6>
                        <div class="d-flex">
	                        <p class="card-text flex-grow-1 mb-2">입찰 <span class="comma">${myBiddingAuction.myBiddingPrice}</span>원</p>
	                        <p class="card-text">남은 <span class="text-primary">${myBiddingAuction.auctionRemainTime}</span></p>
						</div>
						<p class="card-text flex-grow-1">현재
	                    	<span class="text-primary comma">${myBiddingAuction.biddingPrice}</span>원
	                    </p>
					<a href="${root}/auction/detail/${myBiddingAuction.auctionNo}" class="stretched-link"></a>
					</div>
				</div>
        	</div>  
		</c:forEach>    	   	
    	</div>
    	</c:if>
        <div class="row mb-4 mt-5">
            <div class="col-9 mr-5">
                <h4 class="fw-bold">우리 동네 경매</h4>
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
            	category: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
            	categoryPage: 1,
            };
        },
        methods: {
        	comma(money) {
        	  	return String(money).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        	},
        	comma2() {
                // 금액 콤마 찍기
                const comma = document.getElementsByClassName("comma");
                for (i = 0; i < comma.length; i++) {
                    comma[i].innerHTML = comma[i].innerHTML.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                };
            },
            listScroll(e) { // 스크롤 바닥 감지
                const bottom = document.body.offsetHeight === window.innerHeight + window.scrollY;
                if(bottom) {this.loadMore();}
            },
            loadMore() { // 우리 동네 경매 불러오기
            	axios.get("http://localhost:8080/auctionara/list", {
            		params: {
            			page: this.page,
            			filter: this.filter,
            			sort: this.sort,
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
            	window.addEventListener("scroll", this.listScroll);
            	this.list = [];
            	this.page = 1;
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
        },
        mounted() {
        	this.loadMore(); // 우리 동네 경매 1페이지
        	this.comma2();
        	window.addEventListener("scroll", this.listScroll);
        	if(!${addressCount}) {
        		this.filter = 1;
        	}
        	
            const mapContainer = document.getElementById("map"); // 지도를 표시할 div
            const mapOption = {
                center: new daum.maps.LatLng(${address1.gpsLatitude}, ${address1.gpsLongitude}), // 지도의 중심 좌표
                level: 6, // 지도의 확대 레벨
                draggable: false, // 확대 축소 막기
            };
            const map = new kakao.maps.Map(mapContainer, mapOption); // 지도 미리 생성
            const marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(${address1.gpsLatitude}, ${address1.gpsLongitude}),
                map: map
            }); // 마커 미리 생성
            
            map.relayout(); // 지도 생성
            
         	// 좌표 > 주소 변환
            const geocoder = new kakao.maps.services.Geocoder();
            const callback = function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    if (!result[0].road_address) { // 도로명 주소가 없으면
                    	$("#address1").text(result[0].address.address_name);
                    } else {
                    	$("#address1").text(result[0].road_address.address_name);
                    }        	 
                }
            };
            geocoder.coord2Address(${address1.gpsLongitude}, ${address1.gpsLatitude}, callback);
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
	
	#list-wrap {
		min-height: 800px;
	}
</style>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
