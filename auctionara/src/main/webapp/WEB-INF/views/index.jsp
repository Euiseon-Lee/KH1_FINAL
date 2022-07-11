<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div id="app" class="mt-4">

	<div>
		세션 확인용
		memberNo = ${whoLogin}
		memberGrade = ${auth}
	</div>


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
        <div class="row mb-4">
            <div class="col-9 mr-5">
                <h4 class="fw-bold">우리 동네 경매</h4>
            </div>
            <div class="col-1 pr-0 ml-3">
                <select class="form-select form-select-sm border-0 text-muted" v-model.number="filter" @change="updateList">
                    <option value="0">전체</option>
                    <option value="1">주소1</option>
                    <option value="2">주소2</option>
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
        <div class="row row-cols-4">
        <transition-group name="list">
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
        </transition-group>	          
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
            	test: "테스트",
            };
        },
        computed: {
        },
        methods: {
        	comma(money) {
        	  	return String(money).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        	},
            listScroll(e) { // 스크롤 바닥 감지
                const bottom = document.body.offsetHeight === window.innerHeight + window.scrollY;
                if(bottom) this.loadMore();
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
            	this.list = [];
            	this.page = 1;
            	window.addEventListener("scroll", this.listScroll);
            	this.loadMore();
            }
        },
        mounted() {
        	this.loadMore(); // 우리 동네 경매 1페이지
        	window.addEventListener("scroll", this.listScroll);
        	
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
	select:focus {
		outline: none;
	}
	
 	.list-enter-active, .list-leave-active {
	  transition: all 0.3s;
	}
	
	.list-enter, .list-leave-to {
	  opacity: 0;
	}
</style>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
