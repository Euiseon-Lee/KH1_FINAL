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
                                확대
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
                <i class="fa-solid fa-gavel pr-2"></i> ${auctionDetail.biddingCount} 건
            </div>
            <div class="col text-muted p-0">
                <i class="fa-solid fa-clock pr-2"></i>
                <fmt:formatDate value="${auctionDetail.auctionClosedTime}" pattern="M월 d일 HH:mm" /> 마감 ( 남은 ${auctionDetail.auctionRemainTime} )
            </div>
        </div>
        <div class="row mb-2 mr-5">
            <div class="col-3 p-0 d-flex align-items-end">
                <c:choose>
                    <c:when test="${auctionDetail.maxBiddingPrice == 0}">
                        <h5 class="fw-bold">최초 입찰가</h5>
                    </c:when>
                    <c:otherwise>
                        <h5 class="fw-bold">현재 최고가</h5>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col p-0">
                <c:choose>
                    <c:when test="${auctionDetail.maxBiddingPrice == 0}">
                        <h3 class="text-primary fw-bold comma" id="maxBid">${auctionDetail.auctionOpeningBid} 원</h3>
                    </c:when>
                    <c:otherwise>
                        <h3 class="text-primary fw-bold comma" id="maxBid">${auctionDetail.maxBiddingPrice} 원</h3>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="row mr-5">
            <div class="col-3 p-0 d-flex align-items-end">
                <h5 class="fw-bold">즉시 낙찰가</h5>
            </div>
            <div class="col p-0">
                <h3 class="text-info fw-bold comma">${auctionDetail.auctionClosingBid} 원</h3>
            </div>
        </div>
        <c:if test="${auctionDetail.myBiddingPrice != 0}">
            <div class="row mt-3 mr-5 mb-auto pt-3 border-top">
                <div class="col-3 p-0 d-flex align-items-end">
                    <h5 class="fw-bold">내 입찰가</h5>
                </div>
                <div class="col p-0">
                    <h3 class="text-secondary fw-bold comma">${auctionDetail.myBiddingPrice} 원</h3>
                </div>
            </div>
        </c:if>
        <div class="row mt-auto mb-3 d-flex justify-content-end">
            <div class="col-3 p-0 pl-5 mr-2 text-muted">
                <i class="fa-solid fa-land-mine-on pr-2"></i> 신고하기
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
                    <c:when test="${whoLogin == auctionDetail.auctioneerNo && auctionDetail.biddingCount == 0}">
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3">
		                    <i class="fa-solid fa-ban pr-2"></i> 경매 취소
		                </button>
                    </c:when>
                    <c:when test="${whoLogin == auctionDetail.auctioneerNo && auctionDetail.biddingCount != 0}">
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3">
		                    <i class="fa-solid fa-ban pr-2"></i> 경매 중지
		                </button>
                    </c:when>                    
                    <c:otherwise>
		                <button type="button" class="btn btn-primary btn-lg btn-block py-3" data-bs-toggle="modal" data-bs-target="#biddingModal">
		                    <i class="fa-solid fa-gavel pr-2"></i> 입찰하기
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
            <pre class="text-muted">
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
                ${auctionDetail.auctionNo}
            </h6>
        </div>
    </div>
</div>
<c:forEach var="photoDto" items="${photoList}">
    <div class="modal fade" id="modal${photoDto.photoAttachmentNo}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-truncate flex-grow-1 text-center pl-5">${auctionDetail.auctionTitle}</h5>
                    <button type="button" class="btn-close close" data-bs-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <img src="${root}/attachment/download?attachmentNo=${photoDto.photoAttachmentNo}" class="img-fluid img-thumbnail">
                </div>
            </div>
        </div>
    </div>
</c:forEach>
<div class="modal fade" id="biddingModal" tabindex="-1" aria-labelledby="biddingModalLabel" aria-hidden="true" @hidden.bs.modal="inputBid = ${auctionDetail.maxBiddingPrice}">
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
                        <div class="form-group">
                            <label for="inputBid">입찰 가격을 입력해주세요 ( 입찰 단위 : <span class="comma text-primary">${auctionDetail.auctionBidUnit}</span> 원 )</label>
                            <input type="number" class="form-control" id="inputBid" autocomplete="off" v-model="inputBid" @input="bidReplace()" v-bind:class="{'is-invalid': !bidVaild}">
                            <small class="form-text text-info">{{ inputBidReplace }}</small>
                            <div class="invalid-feedback">최고 입찰가보다 높고, 입찰 단위에 부합하는 금액만 가능합니다.</div>
                        </div>
                    </div>
                    <div class="col align-self-center p-0">원</div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" @click="inputBid = inputBid + ${auctionDetail.auctionBidUnit}; bidReplace()">입찰 단위만큼 올리기</button>
                <button type="button" class="btn btn-info" data-bs-dismiss="modal">즉시 낙찰하기</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal" :disabled="!bidVaild">입찰하기</button>
            </div>
        </div>
    </div>
</div>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
    // 천 단위 콤마 찍기
    const comma = document.getElementsByClassName("comma");
    for (i = 0; i < comma.length; i++) {
        comma[i].innerHTML = comma[i].innerHTML.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    };
    const app = Vue.createApp({
        data() {
            return {
                show: false,
                inputBid: 0,
                inputBidReplace: "",
            };
        },
        computed: {
            bidVaild() {
                if (${auctionDetail.maxBiddingPrice} == 0) {
                	return this.inputBid >= ${auctionDetail.auctionOpeningBid} && (this.inputBid % ${auctionDetail.auctionBidUnit}) == 0;
                } else {
                	return this.inputBid > ${auctionDetail.maxBiddingPrice} && (this.inputBid % ${auctionDetail.auctionBidUnit}) == 0;
                }
            },
        },        
        methods: {
            bidReplace() {
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
                if (${auctionDetail.maxBiddingPrice} == 0) {
                    this.inputBid = ${auctionDetail.auctionOpeningBid};
                } else {
                    this.inputBid = ${auctionDetail.maxBiddingPrice} + ${auctionDetail.auctionBidUnit};
                }
                
                this.inputBid = parseInt(this.inputBid / ${auctionDetail.auctionBidUnit}) * ${auctionDetail.auctionBidUnit};
                this.bidReplace();
            },
        },
        mounted() {
            const biddingModal = document.getElementById("biddingModal");
            biddingModal.addEventListener("hidden.bs.modal", this.closeBidModal);
            
            this.closeBidModal();
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
</style>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
