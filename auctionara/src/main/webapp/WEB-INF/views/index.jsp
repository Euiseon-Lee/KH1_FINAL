<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div id="app">
    <div class="container-fluid bg-info gps mb-5">
        <div class="row position-relative">
            <div class="col-8 py-4 px-5">
                <h5 class="text-white mt-1">지금 내 대표 동네는</h5>
                <h5 class="text-white"><span class="h4 text-truncate" id="address1"></span> 입니다</h5>
            </div>
            <div class="col py-4 px-3 bg-light" id="map">
            </div>
            <a href="${root}/address" class="btn btn-info rounded-pill position-absolute" role="button">내 동내 변경 <i class="fa-solid fa-angle-right"></i></a>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row mb-5">
            <div class="col-10">
                <h4 class="fw-bold">우리 동내 경매</h4>
            </div>
            <div class="col">
                <select class="form-select form-select-sm border-0 text-muted">
                    <option selected>전체</option>
                    <option value="1">필터1</option>
                    <option value="2">필터2</option>
                </select>
            </div>
            <div class="col">
                <select class="form-select form-select-sm border-0 text-muted">
                    <option selected>최신순</option>
                    <option value="1">정렬1</option>
                    <option value="2">정렬2</option>
                </select>
            </div>
        </div>
        <div class="row row-cols-4">
            <c:forEach var="auctionListVO" items="${auctionList}">
                <div class="col">
                    <div class="card rounded border-0 mb-5 px-2">
                        <img src="${root}/attachment/download?attachmentNo=${auctionListVO.photoAttachmentNo}" class="card-img-top card-img-custom">
                        <div class="card-body p-0 pt-4">
                            <h6 class="card-title text-truncate">${auctionListVO.auctionTitle}</h6>
                            <div class="d-flex">
                                <p class="card-text flex-grow-1">현재
                                    <c:choose>
                                        <c:when test="${auctionListVO.biddingPrice == 0}">
                                            <span class="text-primary comma">${auctionListVO.auctionOpeningBid}</span>원
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-primary comma">${auctionListVO.biddingPrice}</span>원
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <p class="card-text">남은 <span class="text-primary">${auctionListVO.auctionRemainTime}</span></p>
                            </div>
                            <a href="${root}/auction/detail/${auctionListVO.auctionNo}" class="stretched-link"></a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=714d787408b068ef9f0ff6126a1c0b99&libraries=services"></script>
<script>
	// 천 단위 콤마 찍기
	const comma = document.getElementsByClassName("comma");
	for(i=0; i < comma.length; i++)
	{
		comma[i].innerHTML = comma[i].innerHTML.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

    const app = Vue.createApp({
        data() {
            return {
            };
        },
        computed: {
        },
    });
    app.mount("#app");
	
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
    
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
