<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div class="container-fluid">
    <!-- 세션 확인용 임시 공간 -->
    <div class="row">
        <h5>회원번호: ${whoLogin}</h5>
    </div>
    <div class="row">
        <h5>로그인상태: ${isLogin}</h5>
    </div>
    <div class="row">
        <h5>관리자 여부: ${isAdmin}</h5>
    </div>
    <div class="row">
        <h5>블랙회원 여부: ${isBlackMamba}</h5>
    </div>

    <c:choose>
        <c:when test="${!isLogin}">
            <div class="row">
                <h1><a href="${root}/member/join_intro">회원가입</a></h1>
            </div>

            <div class="row">
                <h1><a href="${root}/member/login">로그인</a></h1>
            </div>
        </c:when>

        <c:otherwise>
            <div class="row">
                <h1><a href="${root}/member/logout">로그아웃</a></h1>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<div id="app">
    <div class="container-fluid bg-info gps mb-5">
        <div class="row">
            <div class="col-8 py-4 px-5">
                <h5 class="text-white mt-1">지금 내 동네는</h5>
                <h5 class="text-white"><span class="h4">임시 주소</span> 입니다</h5>
            </div>
            <div class="col py-4 px-3 bg-light position-relative">
                <a href="#" class="btn btn-info rounded-pill position-absolute" role="button">내 동내 변경 <i class="fa-solid fa-angle-right"></i></a>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row mb-5">
            <div class="col-10">
                <h4 class="fw-bold">우리 동네 경매</h4>
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
                            <a href="${root}/auction/detail?auctionNo=${auctionListVO.auctionNo}" class="stretched-link"></a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
	// 천 단위 콤마 찍기
	var comma = document.getElementsByClassName("comma");
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

</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
