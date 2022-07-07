<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-fluid" id="app">
    <div class="row pt-5">
        <span class="text-muted mr-3">카테고리</span>
        <span class="text-muted mr-3">></span>
        <a href="${root}/auction/category/${auctionDetail.categoryNo}"><span class="text-muted">${auctionDetail.categoryName}</span></a>
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
            	<h3 class="text-primary fw-bold" v-if="maxBid == 0"><span id="openingBid" class="comma">${auctionDetail.auctionOpeningBid}</span> 원</h3>
            	<h3 class="text-primary fw-bold" v-if="maxBid != 0" id="blind"><span id="maxBid" class="comma">${auctionDetail.maxBiddingPrice}</span> 원</h3>
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
        <div class="row mt-3 mr-5 mb-auto pt-3 border-top" v-show="maxBid != 0">
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
            <div class="col-3 p-0 pl-2 mr-2 text-muted pointer">
                <i class="fa-solid fa-land-mine-on pl-3 pr-2"></i> 신고하기
            </div>
        </div>
        <div class="row">
            <div class="col p-0">
                <c:choose>
                    <c:when test="${whoLogin == auctionDetail.auctioneerNo}">
		                <button type="button" class="btn btn-info btn-lg btn-block py-3">
		                    <i class="fa-solid fa-comments-dollar pr-2"></i> 1:1 채팅 관리
		                </button>
                    </c:when>
                    <c:otherwise>
		                <button type="button" class="btn btn-info btn-lg btn-block py-3">
		                    <i class="fa-solid fa-comments-dollar pr-2"></i> 판매자와 1:1 채팅
		                </button>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col">
                <c:choose>
                    <c:when test="${whoLogin == auctionDetail.auctioneerNo}">
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3" v-show="biddingCount == 0">
		                    <i class="fa-solid fa-ban pr-2"></i> 경매 취소
		                </button>
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3" v-show="biddingCount != 0">
		                    <i class="fa-solid fa-ban pr-2"></i> 경매 중지
		                </button>
                    </c:when>                    
                    <c:otherwise>
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3" id="startBidding" data-bs-toggle="modal" data-bs-target="#biddingModal" @click="refresh">
		                    <i class="fa-solid fa-gavel pr-2"></i> 입찰하기
		                </button>
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3 d-none" id="finishBidding" disabled>
		                    종료되었습니다
		                </button>		                	                
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<div class="row mt-4">
    <div class="col-8 border-right">
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
            <pre class="text-muted text-wrap pr-4">
${auctionDetail.auctionContent}
</pre>
        </div>
    </div>
    <div class="col">
        <div class="row ml-3">
            <h5 class="fw-bold">판매자 정보</h5>
        </div>
        <div class="row ml-3">
            <h6>
                추후 회원 정보 표시 예정
            </h6>
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
                <button type="button" class="btn btn-info" data-bs-dismiss="modal">즉시 낙찰하기</button>
                <button type="button" class="btn btn-primary" id="insertBid" data-bs-dismiss="modal" :disabled="!bidVaild" @click="bidding">입찰하기</button>
                <button type="button" class="btn btn-primary d-none" id="blindBid" data-bs-dismiss="modal" @click="blindBidding">입찰하기</button>
            </div>
	        <div class="alert alert-danger d-flex align-items-center" role="alert" v-if="alert == 1">
	    		<i class="fa-solid fa-circle-exclamation pr-2"></i>누군가 이미 입찰한 가격입니다! 더 높은 가격으로 입찰해보세요
			</div>  
        </div>      
    </div>
</div>
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
                maxBid: ${auctionDetail.maxBiddingPrice},
                biddingCount: ${auctionDetail.biddingCount},
                topBidder: ${auctionDetail.topBidder},
                alert: 0,
                closedTime: '<fmt:formatDate value="${auctionDetail.auctionClosedTime}" pattern="YYYY-MM-dd HH:mm:00" />',
            };
        },
        computed: {
            bidVaild() {
                if (this.maxBid == 0) {
                	return this.inputBid >= ${auctionDetail.auctionOpeningBid} && (this.inputBid % ${auctionDetail.auctionBidUnit}) == 0;
                } else {
                	return this.inputBid > this.maxBid && (this.inputBid % ${auctionDetail.auctionBidUnit}) == 0;
                }
            },
        },        
        methods: {
            comma() {
                // 천 단위 콤마 찍기
                const comma = document.getElementsByClassName("comma");
                for (i = 0; i < comma.length; i++) {
                    comma[i].innerHTML = comma[i].innerHTML.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                };
            },
            bidReplace() {
            	// 금액이 10억 이상이면 마지막 자리 지우기
            	if(this.inputBid > 1000000000) {
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
            closeBidModal() {
                if (this.maxBid == 0) {
                    this.inputBid = ${auctionDetail.auctionOpeningBid};
                } else {
                    this.inputBid = this.maxBid + ${auctionDetail.auctionBidUnit};
                }
                
                this.inputBid = parseInt(this.inputBid / ${auctionDetail.auctionBidUnit}) * ${auctionDetail.auctionBidUnit};
                this.bidReplace();
            },
            refresh() {
            	axios.get("http://localhost:8080/auctionara/auction/detail/refresh", {
            		params: {
                		bidderNo : 9, // 임시
                		auctionNo : ${auctionDetail.auctionNo},
            	      }
            	}).then(resp=>{
            		if(resp.data){
                		document.getElementById("count").innerText = resp.data.biddingCount;
                		this.biddingCount = resp.data.biddingCount;
                    	if(document.getElementById("blind").innerText == "블라인드") {
                    		this.maxBid = resp.data.myBiddingPrice;
                    		this.topBidder = 0;
                    	} else {
                    		document.getElementById("maxBid").innerText = resp.data.maxBiddingPrice;
                    		this.maxBid = resp.data.maxBiddingPrice;
                    		this.topBidder = parseInt(resp.data.topBidder);
                    	}
                		document.getElementById("myBid").innerText = resp.data.myBiddingPrice;
                		this.comma();
                		this.closeBidModal();
                		this.alert = 0;
            		};
	            });
            },
            throttleRefresh: _.throttle((app) => {
            	app.refresh();
            	document.getElementById("rotate").classList.remove("rotate");
            	document.getElementById("rotate").offsetWidth = document.getElementById("rotate").offsetWidth;
            	document.getElementById("rotate").classList.add("rotate");
            }, 500), // 0.5초에 한 번씩 새로고침 가능
            bidding() {
            	axios.get("http://localhost:8080/auctionara/auction/detail/refresh", {
            		params: {
                		bidderNo : 9, // 임시
                		auctionNo : ${auctionDetail.auctionNo},
            	      }
            	}).then(resp=>{	
                    if(this.inputBid <= resp.data.maxBiddingPrice) {
                    	const modal = new bootstrap.Modal(document.getElementById("biddingModal"));
                    	modal.show();
                    	this.alert = 1;
                    } else {
                    	axios.post("http://localhost:8080/auctionara/auction/detail/bidding", {
                            bidderNo : 9, // 임시
                            auctionNo : ${auctionDetail.auctionNo},
                            biddingPrice : this.inputBid,
                        }).then(resp=>{
                        	if(resp.data){
                            	document.getElementById("count").innerText = resp.data.biddingCount;
                            	this.biddingCount = resp.data.biddingCount;
                            	document.getElementById("maxBid").innerText = resp.data.maxBiddingPrice;
                            	this.maxBid = resp.data.maxBiddingPrice;
                            	document.getElementById("myBid").innerText = resp.data.myBiddingPrice;
                            	this.topBidder = parseInt(resp.data.topBidder);
                            	this.comma(); 
                            	this.closeBidModal();
                        	};
            	    	});
                    };
                    	
                    if(resp.data){
                   		document.getElementById("count").innerText = resp.data.biddingCount;
                		this.biddingCount = resp.data.biddingCount;
                		document.getElementById("maxBid").innerText = resp.data.maxBiddingPrice;
                		this.maxBid = resp.data.maxBiddingPrice;
                		document.getElementById("myBid").innerText = resp.data.myBiddingPrice;
                		this.topBidder = parseInt(resp.data.topBidder);
                		this.comma();
                		this.closeBidModal();
            		};
	            });
            },
            blindBidding() {
            	axios.post("http://localhost:8080/auctionara/auction/detail/bidding", {
                	bidderNo : 9, // 임시
                    auctionNo : ${auctionDetail.auctionNo},
                    biddingPrice : this.inputBid,
                }).then(resp=>{
                	if(resp.data){
                    	document.getElementById("count").innerText = resp.data.biddingCount;
                        this.biddingCount = resp.data.biddingCount;
                        document.getElementById("myBid").innerText = resp.data.myBiddingPrice;
                        this.maxBid = resp.data.myBiddingPrice;
                        this.topBidder = 0;
                        this.comma(); 
                        this.closeBidModal();
                    };
            	});
            }
        },
        mounted() {
            const biddingModal = document.getElementById("biddingModal");
            biddingModal.addEventListener("hidden.bs.modal", this.closeBidModal);
            
            const refresh = this.refresh;

            // 마감 타이머
            const dday = new Date(this.closedTime);
            let timerText;

            function timer() {
                const today = new Date();
                const gap = dday - today; 
                const d = Math.floor(gap / (1000 * 60 * 60 * 24)); // 일
                const h = Math.floor((gap / (1000 * 60 * 60)) % 24); // 시
                const m = Math.floor((gap / (1000 * 60)) % 60); // 분
                const s = Math.ceil((gap / 1000) % 60); // 초 (초는 1~60초 후로 표기)
                if (gap <= 0) { // 경매 마감 처리
                	clearInterval(interval); // interval 멈추기
                	document.getElementById("maxBidLabel").innerText = "최종 낙찰가";
                	document.getElementById("blind").innerHTML = '<span id="maxBid" class="comma"></span> 원'; // 최종 낙찰가 표시
                	document.getElementById("timer").innerText = "종료되었습니다"; // 타이머 종료
                	document.getElementById("startBidding").remove(); // 입찰 버튼 제거
                	document.getElementById("finishBidding").classList.remove("d-none"); // 종료 버튼 표시
                	document.getElementById("topBidder").classList.remove("d-none"); // 최고 입찰자 배지 표시
                	document.getElementById("topBidder").innerHTML = '<i class="fa-solid fa-crown"></i> 낙찰</span>'; // 최고 입찰자 -> 낙찰로 변경
                	document.getElementById("refresh").remove(); // 새로고침 버튼 제거
                	refresh(); // 최종 정보 불러오기
                	
                	// 입찰 모달 제거
                	if(document.getElementsByClassName("modal-backdrop").length > 0) {
                		document.getElementsByClassName("modal-backdrop")[0].remove();
                	}
                    biddingModal.remove();  
                } else {
                	if(d == 0 && h == 0 && m == 0) {
                		timerText = s + "초 후";
                	} else if(d == 0 && h == 0) {
                		timerText = m + "분 " + s + "초 후";
                	} else if(d == 0) {
                		timerText = h + "시간 " + m + "분 " + s + "초 후";
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
          	const interval = setInterval(timer, 250);
          	timer();

            this.closeBidModal();
            this.comma();
        },
        beforeDestroy() {
            const biddingModal = document.getElementById("biddingModal");
            biddingModal.removeEventListener("hidden.bs.modal", this.closeBidModal);
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
    
    .pointer {
    	cursor: pointer;
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
	
</style>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
