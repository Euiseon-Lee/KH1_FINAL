<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-fluid" id="app" v-cloak>
    <div class="row pt-5">
        <span class="text-muted mr-3">카테고리</span>
        <span class="text-muted mr-3">></span>
        <a href="${root}/auction/category?categoryNo=${auctionDetail.categoryNo}"><span class="text-muted">${auctionDetail.categoryName}</span></a>
    </div>
    <div class="row mt-4 py-4 border-bottom border-top">
        <div class="col-5 p-0">
            <div id="carousel" class="carousel slide" data-ride="carousel" data-bs-interval="false" @mouseover="show = true" @mouseleave="show = false">
                <ol class="carousel-indicators">
                    <c:forEach var="photoDto" items="${photoList}" varStatus="status">
                        <c:choose>
                            <c:when test="${status.first}">
                                <li data-bs-target="#carousel" data-bs-slide-to="${status.index}" class="active"></li>
                            </c:when>
                            <c:otherwise>
                                <li data-bs-target="#carousel" data-bs-slide-to="${status.index}"></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </ol>
                <div class="carousel-inner">
                    <c:forEach var="photoDto" items="${photoList}" varStatus="status">
                        <c:choose>
                            <c:when test="${status.first}">
                                <div class="carousel-item active">
                            </c:when>
                            <c:otherwise>
                                <div class="carousel-item">
                            </c:otherwise>
                        </c:choose>
                        <img src="${root}/attachment/download?attachmentNo=${photoDto.photoAttachmentNo}" class="d-block w-100">
                        <div class="carousel-caption d-none d-md-block" v-if="show">
                            <button type="button" class="btn btn-primary btn-sm rounded-pill" data-bs-toggle="modal" data-bs-target="#modal${photoDto.photoAttachmentNo}">
                                <i class="fa-solid fa-magnifying-glass"></i>
                                전체보기
                            </button>
                        </div>
                </div>
                </c:forEach>
            </div>
            <a class="carousel-control-prev" role="button" data-bs-target="#carousel" data-bs-slide="prev" v-if="show">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            </a>
            <a class="carousel-control-next" role="button" data-bs-target="#carousel" data-bs-slide="next" v-if="show">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
            </a>
        </div>
    </div>
    <div class="col ml-5 pl-3 pr-0 d-flex flex-column">
        <div class="row pr-1 mb-3">
            <h3 class="fw-bold">${auctionDetail.auctionTitle}</h3>
        </div>
        <div class="row mb-3 mr-5">
            <div class="col-3 p-0 text-muted">
                <i class="fa-solid fa-gavel pr-2"></i><span id="count">${auctionDetail.biddingCount}</span> 건
            </div>
            <div class="col text-muted p-0">
                <i class="fa-solid fa-clock pr-2"></i>
                <fmt:formatDate value="${auctionDetail.auctionClosedTime}" pattern="M월 d일 HH:mm" /> 마감 (<span id="timer"></span>)
            </div>
        </div>
        <div class="row mb-2 mr-5">
            <div class="col-3 p-0 d-flex align-items-end">
            	<h5 class="fw-bold" v-show="maxBid == 0">최초 입찰가</h5>
            	<h5 id="maxBidLabel" class="fw-bold" v-show="maxBid != 0">현재 최고가</h5>
            </div>
            <div class="col p-0">
            	<h3 class="text-primary fw-bold" v-show="maxBid == 0"><span id="openingBid" class="comma">${auctionDetail.auctionOpeningBid}</span> 원</h3>
            	<h3 class="text-primary fw-bold" v-show="maxBid != 0" id="blind"><span id="maxBid" class="comma">${auctionDetail.maxBiddingPrice}</span> 원</h3>
            </div>
        </div>
        <div class="row mr-5">
            <div class="col-3 p-0 d-flex align-items-end">
                <h5 class="fw-bold">즉시 낙찰가</h5>
            </div>
            <div class="col p-0">
                <h3 class="text-info fw-bold"><span id="closingBid" class="comma">${auctionDetail.auctionClosingBid}</span> 원</h3>
            </div>
        </div>
        <div class="row mt-3 mr-5 mb-auto pt-3 border-top" v-show="maxBid != 0 && myBidding">
        	<div class="col-3 p-0 d-flex align-items-end">
        		<h5 class="fw-bold">내 입찰가</h5>
        	</div>
        	<div class="col p-0">
        		<h3 class="text-secondary fw-bold"><span id="myBid" class="comma">${auctionDetail.myBiddingPrice}</span> 원 <span class="text-warning pl-2 align-self-center" id="topBidder" v-show="topBidder == 1"><i class="fa-solid fa-crown"></i> 최고 입찰자</span></h3>
            </div>
        </div>
        <div class="row mt-auto mb-3 pl-5 d-flex justify-content-end">
            <div id="refresh" class="col-3 text-muted p-0 pointer" @click="throttleRefresh(this)">
           		<span class="pl-5"><i id="rotate" class="fa-solid fa-arrow-rotate-left"></i> 새로고침</span>
            </div>
            <div class="col-3 p-0 pl-2 mr-2 text-muted pointer" data-bs-toggle="modal" data-bs-target="#reportModal">
                <i class="fa-solid fa-land-mine-on pl-3 pr-2"></i> 신고하기
            </div>
        </div>
        <div class="row">
            <div class="col p-0">
                <c:choose>
                    <c:when test="${whoLogin == auctionDetail.auctioneerNo}">
                    	<a class="btn btn-info btn-lg btn-block py-3" href="${root}/chat" role="button" v-if="(auctionClose && biddingCount == 0) || !auctionClose">
		                    <i class="fa-solid fa-comments-dollar pr-2"></i> 1:1 채팅 관리
		                </a>
		                <a class="btn btn-info btn-lg btn-block py-3" href="${root}/chat/auctioneer/${auctionDetail.auctionNo}" role="button" v-if="auctionClose && biddingCount != 0">
		                    <i class="fa-solid fa-comments-dollar pr-2"></i> 낙찰자와 1:1 채팅
		                </a>		                
                    </c:when>
                    <c:otherwise>
                    	<a class="btn btn-info btn-lg btn-block py-3" href="${root}/chat/${auctionDetail.auctionNo}" role="button">
                    		<i class="fa-solid fa-comments-dollar pr-2"></i> 판매자와 1:1 채팅
                    	</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col">
                <c:choose>
                    <c:when test="${whoLogin == auctionDetail.auctioneerNo}">
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3" v-if="biddingCount == 0 && !auctionClose" data-bs-toggle="modal" data-bs-target="#cancelAuctionModal">
		                    <i class="fa-solid fa-ban pr-2"></i> 경매 취소
		                </button>
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3" v-if="biddingCount != 0 && !auctionClose" data-bs-toggle="modal" data-bs-target="#stopAuctionModal">
		                    <i class="fa-solid fa-ban pr-2"></i> 경매 중지
		                </button>
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3" disabled v-if="auctionClose">
		                    종료되었습니다
		                </button>
                    </c:when>                    
                    <c:otherwise>
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3" id="startBidding" data-bs-toggle="modal" data-bs-target="#biddingModal" @click="refresh" v-if="${checkAddress}">
		                    <i class="fa-solid fa-gavel pr-2"></i> 입찰하기
		                </button>
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3" disabled v-if="auctionClose && (topBidder == 0 || topBidder == null)">
		                    종료되었습니다
		                </button>
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3" disabled v-if="!${checkAddress} && !auctionClose">
		                    동네인증 필요
		                </button>
		                <a href="${root }/payment/paying/${auctionDetail.auctionNo}" class="btn btn-primary btn-lg btn-block py-3" v-if="auctionClose && topBidder == 1">
		                    <i class="fa-solid fa-coins pr-2"></i> 결제하기
		                </a>             	                
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<div class="row mt-4">
    <div class="col-8">
        <div class="row mb-3">
            <h5 class="fw-bold">경매 물품 정보</h5>
        </div>
        <div class="row">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active">물품 상태 :
                        <c:choose>
                            <c:when test="${auctionDetail.auctionStatus == 5}">
                                <span class="text-primary pl-1">상</span>
                            </c:when>
                            <c:when test="${auctionDetail.auctionStatus == 4}">
                                <span class="text-primary pl-1">중상</span>
                            </c:when>
                            <c:when test="${auctionDetail.auctionStatus == 3}">
                                <span class="text-primary pl-1">중</span>
                            </c:when>
                            <c:when test="${auctionDetail.auctionStatus == 2}">
                                <span class="text-primary pl-1">중하</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-primary pl-1">하</span>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ol>
            </nav>
        </div>
        <div class="row">
            <pre class="text-muted pr-4">
${auctionDetail.auctionContent}
</pre>
        </div>
    </div>
    <div class="col">
        <div class="row ml-3 mb-3">
            <h5 class="fw-bold">판매자 정보</h5>
        </div>
        <div class="row ml-3 pb-3 border-bottom">
            <div class="col-2"><img id="profile" class="rounded-circle" src="${root}/attachment/download?attachmentNo=${auctioneerInfo.attachmentNo}"></div>
            <div class="col ml-4">
            	<h6 class="row fw-bold mb-2">${auctioneerInfo.memberNick}</h6>
				<c:choose>
					<c:when test="${auctioneerInfo.memberPreference != null}">
					<h6 class="row text-muted">${auctioneerInfo.memberPreference}</h6>
					</c:when>
					<c:otherwise>
					<h6 class="row text-muted">선호 거래일 없음</h6>
					</c:otherwise>
				</c:choose>
            </div>
        </div>
        <div class="row ml-3 py-3 border-bottom">
        	<div class="col-4 text-muted ml-2">긍정 평가 <span class="text-success fw-bold fs-large ml-3">${auctioneerInfo.likeCount}개</span></div>
        	<div class="col-4 text-muted ml-2">부정 평가 <span class="text-primary fw-bold fs-large ml-3">${auctioneerInfo.dislikeCount}개</span></div>
        </div>
        <div class="row ml-3 pt-3 pb-2">
        	<div class="text-muted">마지막 접속일 : ${auctioneerInfo.memberLogintime}</div>
        </div>
        <div class="row ml-3">
        	<div class="text-muted">누적 제재 : ${auctioneerInfo.memberRedCount}회</div>
        </div>        
    </div>
</div>
<c:forEach var="photoDto" items="${photoList}">
	<div class="modal fade" id="modal${photoDto.photoAttachmentNo}" tabindex="-1" aria-hidden="true">
		<div class="photo-modal-wrap">
			<div class="modal-dialog modal-dialog-centered border-0 photo-modal">
				<div class="modal-content">
					<img src="${root}/attachment/download?attachmentNo=${photoDto.photoAttachmentNo}" class="img-fluid img-thumbnail">
				</div> 
			</div>
		</div> 
	</div>
</c:forEach>
<div class="modal fade" id="biddingModal" tabindex="-1" aria-labelledby="biddingModalLabel" aria-hidden="true" @hidden.bs.modal="inputBid = maxBid">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="biddingModalLabel"><i class="fa-solid fa-gavel pr-2"></i>입찰하기</h5>
                <button type="button" class="btn-close close" data-bs-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-10">
                        <div class="form-group pl-2">
                            <label for="inputBid"> 입찰 가격을 입력해주세요 ( 입찰 단위 : <span class="comma text-primary">${auctionDetail.auctionBidUnit}</span> 원 )</label>
                            <input type="number" class="form-control" id="inputBid" autocomplete="off" v-model="inputBid" @input="bidReplace()" v-bind:class="{'is-invalid': !bidVaild}" max="999999900">
                            <small class="form-text text-info pl-1">{{ inputBidReplace }}</small>
                            <div class="invalid-feedback">최고 입찰가보다 높고, 입찰 단위에 부합하는 금액만 가능합니다.</div>
                        </div>
                    </div>
                    <div class="col align-self-center p-0">원</div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" @click="inputBid = inputBid + ${auctionDetail.auctionBidUnit}; bidReplace()">입찰 단위만큼 올리기</button>
                <button type="button" class="btn btn-info" data-bs-dismiss="modal" @click="closeBidding">즉시 낙찰하기</button>
                <button type="button" class="btn btn-primary" id="insertBid" data-bs-dismiss="modal" :disabled="!bidVaild" @click="bidding">입찰하기</button>
                <button type="button" class="btn btn-primary d-none" id="blindBid" data-bs-dismiss="modal" :disabled="!bidVaild" @click="blindBidding">입찰하기</button>
            </div>
	        <div class="alert alert-danger d-flex align-items-center" role="alert" v-if="alert == 1">
	    		<i class="fa-solid fa-circle-exclamation pr-2"></i>누군가 이미 입찰한 가격입니다! 더 높은 가격으로 입찰해보세요
			</div>  
        </div>      
    </div>
</div>
<div class="modal fade" id="failBiddingModal" aria-hidden="true" aria-labelledby="failBiddingModalLable" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="failBiddingModalLable">&#128546; 입찰 실패</h5>
				<button type="button" class="btn-close close" data-bs-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
        		누군가 이미 낙찰하여 경매가 종료되었습니다
      		</div>
    	</div>
  	</div>
</div>
<div class="modal fade" id="reportModal" aria-hidden="true" aria-labelledby="reportModalLable" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reportModalLable">&#129402; 경매 신고하기</h5>
				<button type="button" class="btn-close close" data-bs-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
        		경매 신고 이유를 알려주세요!
        		<input type="text" class="form-control mt-2" v-model="reportReason" autocomplete="off" maxlength="100" />
                <div class="text-right mt-1"><span class="text-primary">{{ reportCount }}</span> / 100</div>
      		</div>
            <div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">돌아가기</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal" :disabled="reportReason == ''" @click="report">신고하기</button>
            </div>      		
    	</div>
  	</div>
</div>
<c:if test="${whoLogin == auctionDetail.auctioneerNo}">
<div class="modal fade" id="stopAuctionModal" aria-hidden="true" aria-labelledby="stopAuctionModalLable" tabindex="-1" v-show="biddingCount != 0 && !auctionClose">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="stopAuctionModalLable"><i class="fa-solid fa-ban pr-2 text-primary"></i> 경매 중지</h5>
				<button type="button" class="btn-close close" data-bs-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
        		입찰자가 있는 경매를 중지하면 <span class="fw-bold text-primary">사이트 이용에 관한 불이익</span>을 받게 됩니다.
        		<br><br>
        		정말 경매를 중지하시겠습니까?
      		</div>
      		<div class="modal-footer">
      			<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
      			<button type="button" class="btn btn-primary" @click="checkAuction2" data-bs-dismiss="modal">예</button>
      		</div>
    	</div>
  	</div>
</div>
<div class="modal fade" id="cancelAuctionModal" aria-hidden="true" aria-labelledby="cancelAuctionModalLable" tabindex="-1" v-if="biddingCount == 0 && !auctionClose">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="cancelAuctionModalLable"><i class="fa-solid fa-ban pr-2 text-primary"></i> 경매 취소</h5>
				<button type="button" class="btn-close close" data-bs-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
        		정말 경매를 취소하시겠습니까?
      		</div>
      		<div class="modal-footer">
      			<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
                <button type="button" class="btn btn-primary" @click="checkAuction1" data-bs-dismiss="modal">예</button>
      		</div>
    	</div>
  	</div>
</div>
<div class="modal fade" id="failCancleModal" aria-hidden="true" aria-labelledby="failCancleModalLable" tabindex="-1" v-show="biddingCount == 0 && !auctionClose">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="failCancleModalLable">&#129402; 경매 취소/중지 실패</h5>
				<button type="button" class="btn-close close" data-bs-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
        		이미 낙찰된 경매이므로 경매를 취소하거나 중지할 수 없습니다.
      		</div>
    	</div>
  	</div>
</div>
</c:if>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
<script>
    const app = Vue.createApp({
        data() {
            return {
                show: false,
                inputBid: 0,
                inputBidReplace: "",
                auctionNo: ${auctionDetail.auctionNo},
                bidUnit: ${auctionDetail.auctionBidUnit},
                openingBid: ${auctionDetail.auctionOpeningBid},
                closingBid: ${auctionDetail.auctionClosingBid},
                maxBid: ${auctionDetail.maxBiddingPrice},
                biddingCount: ${auctionDetail.biddingCount},
                myBidding: false,
                topBidder: 0,
                closedTime: '<fmt:formatDate value="${auctionDetail.auctionClosedTime}" pattern="YYYY-MM-dd HH:mm:00" />',
                alert: 0,
                interval: "",
                auctionClose: false,
                reportReason: "",
            };
        },
        computed: {
            bidVaild() { // 입찰 금액 유효성 검사
            	if (this.maxBid == 0) {
                	return this.inputBid >= this.openingBid && (this.inputBid % this.bidUnit) == 0;
                } else {
                	return this.inputBid > this.maxBid && (this.inputBid % this.bidUnit) == 0;
                }
            },
            reportCount() {
                return this.reportReason.length;
            },
        },        
        methods: {
            comma() {
                // 금액 콤마 찍기
                const comma = document.getElementsByClassName("comma");
                for (i = 0; i < comma.length; i++) {
                    comma[i].innerHTML = comma[i].innerHTML.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                };
            },
            bidReplace() {
            	// 금액이 10억 이상이면 마지막 자리 지우기
            	if(this.inputBid >= 1000000000) {
            		this.inputBid = parseInt(this.inputBid / 10);
            	}
            	
            	// 한글 금액 표기
                const numKor = new Array("", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구", "십"); // 숫자 문자
                const danKor = new Array("", "십", "백", "천", "", "십", "백", "천", "", "십", "백", "천", "", "십", "백", "천"); // 만위 문자
                const input = String(this.inputBid);
                let result = "";
                for (i = 0; i < input.length; i++) {
                    let str = "";
                    const num = numKor[input.charAt(input.length - (i + 1))];
                    if (num != "") str += num + danKor[i]; // 숫자가 0인 경우 텍스트를 표현하지 않음
                    switch (i) {
                        case 4:
                            str += "만";
                            break; // 4자리인 경우 '만'을 붙여줌
                        case 8:
                            str += "억";
                            break; // 8자리인 경우 '억'을 붙여줌
                    }
                    result = str + result;
                }
                result = result + "원";
                return this.inputBidReplace = result;
            },
            closeBidModal() { // 현재 최소 입찰 가능 금액을 모달창에 갱신
                if (this.maxBid == 0) {
                    this.inputBid = this.openingBid;
                } else {
                    this.inputBid = this.maxBid + this.bidUnit;
                }
                
                this.inputBid = parseInt(this.inputBid / this.bidUnit) * this.bidUnit;
                this.bidReplace();
            },
            refresh() {
            	this.alert = 0; // 입찰 경고창 닫기
            	axios.get("http://localhost:8080/auctionara/auction/detail/refresh", {
            		params: {
                		bidderNo : ${whoLogin},
                		auctionNo : this.auctionNo,
            	      }
            	}).then(resp=>{
            		if(resp.data){
            			// 즉시 낙찰 여부 확인
            			if(this.closingBid <= resp.data.maxBiddingPrice) { // 이미 낙찰됨
            				this.closeAuction(); // 경매 종료
            			} 
            			
            			// 입찰 횟수 갱신
        				document.getElementById("count").innerText = resp.data.biddingCount;
                		this.biddingCount = resp.data.biddingCount;  
                		
                		// 내 입찰가 갱신
                		document.getElementById("myBid").innerText = resp.data.myBiddingPrice;
                		
                        if(document.getElementById("blind").innerText == "블라인드") { // 블라인드 모드일 때
                        	this.maxBid = resp.data.myBiddingPrice;
                        	this.topBidder = 0;
                        } else { // 일반 모드일 때
                			// 최고 입찰가 갱신
                    		document.getElementById("maxBid").innerText = resp.data.maxBiddingPrice;
                    		this.maxBid = resp.data.maxBiddingPrice;
                    		
                    		// 최고 입찰자 갱신
                    		this.topBidder = parseInt(resp.data.topBidder);
                        }	
                		this.comma();
                		this.closeBidModal();
            		};
	            }).catch(err=>{
	            	if(err.response.status == 403) {
		            	alert("비공개 처리 된 경매입니다");
		            	location.href = "${root}/";	            		
	            	}
            	});
            },
            throttleRefresh: _.throttle((app) => { // 0.5초에 한 번씩 새로고침 가능
            	app.refresh();
            	
            	// 새로고침 아이콘 회전
            	document.getElementById("rotate").classList.remove("rotate");
            	document.getElementById("rotate").offsetWidth = document.getElementById("rotate").offsetWidth;
            	document.getElementById("rotate").classList.add("rotate");
            }, 500), 
            bidding() {
            	axios.get("http://localhost:8080/auctionara/auction/detail/refresh", {
            		params: {
                		bidderNo : ${whoLogin},
                		auctionNo : this.auctionNo,
            	      }
            	}).then(resp=>{	
            		if(this.closingBid <= resp.data.maxBiddingPrice) { // 누군가 이미 낙찰하여 경매 종료
            			// 낙찰 알림 모달
            			const modal = new bootstrap.Modal(document.getElementById("failBiddingModal"));
                    	modal.show();
                    	
            			this.closeAuction(); // 경매 종료
            			this.refresh();
            		} else {
                        if(this.inputBid <= resp.data.maxBiddingPrice) { // 누군가 이미 같거나 높은 가격을 입찰했을 때 입찰 실패 & 경고 표시 (일반 입찰 때만)
                        	const modal = new bootstrap.Modal(document.getElementById("biddingModal"));
                        	modal.show();
                        	this.refresh();
                        	this.alert = 1;
                        } else { // 입찰 성공
                        	if(this.inputBid >= this.closingBid) { // 즉시 낙찰
                            	axios.post("http://localhost:8080/auctionara/auction/detail/bidding/close", {
                                    bidderNo : ${whoLogin},
                                    auctionNo : this.auctionNo,
                                    biddingPrice : this.inputBid,
                                }).then(resp=>{
                                	this.refresh();
                                	this.myBidding = true;
                                })
                        	} else { // 일반 입찰
                            	axios.post("http://localhost:8080/auctionara/auction/detail/bidding", {
                                    bidderNo : ${whoLogin},
                                    auctionNo : this.auctionNo,
                                    biddingPrice : this.inputBid,
                                }).then(resp=>{
                                	this.refresh();
                                	this.myBidding = true;
                                })
                        	}
                        }
            		}
            	}).catch(err=>{
	            	if(err.response.status == 403) {
		            	alert("비공개 처리 된 경매입니다");
		            	location.href = "${root}/";	            		
	            	}
            	});
            },
            blindBidding() {
            	axios.get("http://localhost:8080/auctionara/auction/detail/refresh", {
            		params: {
                		bidderNo : ${whoLogin},
                		auctionNo : this.auctionNo,
            	      }
            	}).then(resp=>{	
            		if(this.closingBid <= resp.data.maxBiddingPrice) { // 누군가 이미 낙찰하여 경매 종료
            			// 낙찰 알림 모달
            			const modal = new bootstrap.Modal(document.getElementById("failBiddingModal"));
                    	modal.show();
                    	
            			this.closeAuction(); // 경매 종료
            			this.refresh();
            		} else {
                    	if(this.inputBid >= this.closingBid) { // 즉시 낙찰
                        	axios.post("http://localhost:8080/auctionara/auction/detail/bidding/close", {
                                bidderNo : ${whoLogin},
                                auctionNo : this.auctionNo,
                                biddingPrice : this.inputBid,
                            }).then(resp=>{
                            	this.refresh();
                            	this.myBidding = true;
                            })
                    	} else { // 일반 입찰
                        	axios.post("http://localhost:8080/auctionara/auction/detail/bidding", {
                                bidderNo : ${whoLogin},
                                auctionNo : this.auctionNo,
                                biddingPrice : this.inputBid,
                            }).then(resp=>{
                            	this.refresh();
                            	this.myBidding = true;
                            })
                    	}       	
            		}
            	}).catch(err=>{
	            	if(err.response.status == 403) {
		            	alert("비공개 처리 된 경매입니다");
		            	location.href = "${root}/";	            		
	            	}
            	});
            },
            closeBidding() {
            	axios.get("http://localhost:8080/auctionara/auction/detail/refresh", {
            		params: {
                		bidderNo : ${whoLogin},
                		auctionNo : this.auctionNo,
            	      }
            	}).then(resp=>{	
            		if(this.closingBid <= resp.data.maxBiddingPrice) { // 누군가 이미 낙찰
            			// 낙찰 알림 모달
            			const modal = new bootstrap.Modal(document.getElementById("failBiddingModal"));
                    	modal.show();
                    	
	        			this.closeAuction(); // 경매 종료
	        			this.refresh();					
            		} else {  // 내가 즉시 낙찰
                    	axios.post("http://localhost:8080/auctionara/auction/detail/bidding/close", {
                        	bidderNo : ${whoLogin},
                            auctionNo : this.auctionNo,
                            biddingPrice : this.closingBid,
                        }).then(resp=>{
                        	this.refresh();
                        	this.myBidding = true;
                    	})  
            		}
            	}).catch(err=>{
	            	if(err.response.status == 403) {
		            	alert("비공개 처리 된 경매입니다");
		            	location.href = "${root}/";	            		
	            	}
            	});
            },
            closeAuction() {
            	if(this.auctionClose == false) {
            		this.closedTime = new Date(); // 현재 시간을 넣어 타이머 종료

            		document.getElementById("maxBidLabel").innerText = "최종 낙찰가";
                	document.getElementById("blind").innerHTML = '<span id="maxBid" class="comma"></span> 원'; // 최종 낙찰가 표시
                	document.getElementById("timer").innerText = "종료되었습니다"; // 타이머 종료
                	document.getElementById("refresh").remove(); // 새로고침 버튼 제거
                	if(document.getElementById("startBidding")) {
                		document.getElementById("startBidding").remove(); // 입찰 버튼 제거
                	}
                	
                	if(document.getElementById("topBidder")) {
	                	document.getElementById("topBidder").classList.remove("d-none"); // 최고 입찰자 배지 표시
	                	document.getElementById("topBidder").innerHTML = '<i class="fa-solid fa-crown"></i> 낙찰</span>'; // 최고 입찰자 -> 낙찰로 변경
	                }
					
                	// 입찰 모달 제거
                	if(document.getElementsByClassName("modal-backdrop").length > 0) {
                		document.getElementsByClassName("modal-backdrop")[0].remove();
                	}
                	document.getElementById("biddingModal").remove();
                	
                	this.auctionClose = true;            		
            	}
            },
            checkAuction1() {
            	axios.get("http://localhost:8080/auctionara/auction/detail/refresh", {
            		params: {
                		bidderNo : ${whoLogin},
                		auctionNo : this.auctionNo,
            	      }
            	}).then(resp=>{
            		if(this.closingBid <= resp.data.maxBiddingPrice) { // 누군가 이미 낙찰하여 경매 취소 실패
            			this.closeAuction();
            			this.refresh();
            			const modal = new bootstrap.Modal(document.getElementById("failCancleModal"));
                    	modal.show();
            		} else if(resp.data.biddingCount > 0) { // 경매 중지로 전환
            			this.refresh();
            			const modal = new bootstrap.Modal(document.getElementById("stopAuctionModal"));
                    	modal.show();
            		} else {
            			location.href = "${root}/auction/detail/cancel/${auctionDetail.auctionNo}";
            		}
            	}).catch(err=>{
	            	if(err.response.status == 403) {
		            	alert("비공개 처리 된 경매입니다");
		            	location.href = "${root}/";      		
	            	}
            	});           	
            },
            checkAuction2() {
            	axios.get("http://localhost:8080/auctionara/auction/detail/refresh", {
            		params: {
                		bidderNo : ${whoLogin},
                		auctionNo : this.auctionNo,
            	      }
            	}).then(resp=>{
            		if(this.closingBid <= resp.data.maxBiddingPrice) { // 누군가 이미 낙찰하여 경매 중지 실패
            			this.closeAuction();
            			this.refresh();
            			const modal = new bootstrap.Modal(document.getElementById("failCancleModal"));
                    	modal.show();
            		} else {
            			location.href = "${root}/auction/detail/stop/${auctionDetail.auctionNo}"
            		}
            	}).catch(err=>{
	            	if(err.response.status == 403) {
		            	alert("비공개 처리 된 경매입니다");
		            	location.href = "${root}/";	            		
	            	}
            	});
            },
            report() {
            	axios.post("http://localhost:8080/auctionara/auction/detail/report", {
            		auctionNo: this.auctionNo,
            		auctionReporterNo: ${whoLogin},
            		auctionReportReason: this.reportReason,
            	})
            	.then(resp => {}); 
            }
        },
        mounted() {
            document.getElementById("biddingModal").addEventListener("hidden.bs.modal", this.closeBidModal);
            
            const refresh = this.refresh;
            const closeAuction = this.closeAuction;
			
         	// 마감 타이머 함수
            function timer(dday) {
            	let timerText;
                const today = new Date();
                const gap = dday - today; 
                const d = Math.floor(gap / (1000 * 60 * 60 * 24)); // 일
                const h = Math.floor((gap / (1000 * 60 * 60)) % 24); // 시
                const m = Math.floor((gap / (1000 * 60)) % 60); // 분
                const s = Math.ceil((gap / 1000) % 60); // 초 (초는 1~60초 후로 표기)
                if (gap <= 0) { // 마감 시간이 되어 경매 종료 시
                	closeAuction(); // 마감 처리
                	refresh(); // 최종 정보 불러오기
                	clearInterval(interval); // 반복 종료
                } else {
                	if(d == 0 && h == 0 && m == 0) {
                		timerText = s + "초 후";
                	} else if(d == 0 && h == 0) {
                		timerText = m + "분 " + s + "초 후";
                	} else if(d == 0 && m == 0) {
                		timerText = h + "시간 " + s + "초 후";
                	} else if(d == 0) {
                		timerText = h + "시간 " + m + "분 " + s + "초 후";
                	} else if(h == 0) {
                		timerText = d + "일 " + m + "분 " + s + "초 후";
                	} else if(m == 0) {
                		timerText = d + "일 " + h + "시간 " + s + "초 후";
                	} else {
                		timerText = d + "일 " + h + "시간 " + m + "분 " + s + "초 후";
                	}
                	document.getElementById("timer").innerText = timerText;
    				if (gap <= 600000) { // 10분 이하부터 최고가 블라인드 
    					document.getElementById("blind").innerText = "블라인드";
    					document.getElementById("blindBid").classList.remove("d-none");
    					document.getElementById("topBidder").classList.add("d-none");
    					if(document.getElementById("insertBid")) {
        					document.getElementById("insertBid").remove();    						
    					}
    				}
				}
            }

          	if(this.closingBid <= this.maxBid) { // 페이지 접속 시점에 이미 낙찰되었을 경우
          		closeAuction();
          		refresh();
          	}
			
          	// 타이머 실행
          	this.closedTime = new Date(this.closedTime);
            const interval = setInterval(() => timer(this.closedTime), 250);
            timer(this.closedTime);
          	
            this.closeBidModal();
            this.comma();
            
            <c:if test="${auctionDetail.topBidder != null}">
	            this.topBidder = ${auctionDetail.topBidder};
	            this.myBidding = true;
            </c:if>
        },
        beforeDestroy() {
            document.getElementById("biddingModal").removeEventListener("hidden.bs.modal", this.closeBidModal);
        },
    });
    app.mount("#app");
</script>
<style scoped>
    .carousel-item img {
        object-fit: cover;
        height: 26em;
        border-radius: 1rem;
    }

    .carousel-item {
        transition: transform .1s ease;
    }

    .carousel-caption {
        right: 5%;
        bottom: 0;
        text-align: right;
    }

    .text-warning {
    	font-size: 0.5em;
    	vertical-align: middle;
    }
    
    @keyframes rotate {
	  from {
	    transform: rotate(0deg);
	  }
	  to {
	    transform: rotate(360deg);
	  }
	}
	
	.rotate {
		animation: rotate 0.5s ease-out;
	}
	
	.modal.fade .modal-dialog {
		transition: transform .1s ease-out;
	}
	
	.photo-modal-wrap {
 		width: fit-content;
 		height: 100%;
    	margin: 0 auto;
    	max-width: 70%; 
	}
	
	.photo-modal {
 		width: 100%; 
 		max-width: 100%;
	}
	
	#profile {
    	object-fit: cover;
    	width: 50px;
        height: 50px; 	
	}
	
</style>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
