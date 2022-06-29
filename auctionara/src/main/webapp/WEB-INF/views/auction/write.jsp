<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-fluid">
    <form action="" method="post">
        <div class="row">
            <h2>경매 등록</h2>
        </div>
        <div class="row">
            <div class="col-sm">
                <label for="attachment" class="form-label">경매 물품 이미지 (0/4)</label>
            </div>
            <div class="col-sm">
                <input class="form-control" type="file" id="attachment">
            </div>
        </div>
        <div class="row">
            <div class="col-sm">
                <label for="auctionTitle" class="form-label">제목</label>
            </div>
            <div class="col-sm">
                <input type="text" class="form-control" id="auctionTitle" placeholder="경매 물품 제목을 입력해주세요">
            </div>
        </div>
        <div class="row">
            <div class="col-sm">
                <label for="categoryNo" class="form-label">카테고리</label>
            </div>
            <div class="col-sm">
                <select class="form-select" id="categoryNo">
                    <option selected>선택</option>
                    <option value="{category.categoryNo}">{category.categoryName}</option>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-sm">
                <label class="form-label">경매 물품 상태</label>
            </div>
            <div class="col-sm">
                <div class="form-check form-check-inline">
                    <label class="form-check-label" for="radio1">상
                        <input class="form-check-input" type="radio" name="auctionStatus" id="radio1">
                    </label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label" for="radio2">중상
                        <input class="form-check-input" type="radio" name="auctionStatus" id="radio2">
                    </label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label" for="radio3">중
                        <input class="form-check-input" type="radio" name="auctionStatus" id="radio3">
                    </label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label" for="radio4">중하
                        <input class="form-check-input" type="radio" name="auctionStatus" id="radio4">
                    </label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label" for="radio5">하
                        <input class="form-check-input" type="radio" name="auctionStatus" id="radio5">
                    </label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm">
                <label for="auctionContent" class="form-label">경매 물품 설명</label>
            </div>
            <div class="col-sm">
                <textarea class="form-control" id="auctionContent" rows="5" placeholder="경매 물품에 대한 설명을 자세히 입력해주세요"></textarea>
            </div>
        </div>
        <div class="row">
            <div class="col-sm">
                <label for="auctionOpeningBid" class="form-label">최소 입찰 가격</label>
            </div>
            <div class="col-sm">
                <input type="text" class="form-control" id="auctionOpeningBid" placeholder="100원 이상부터 가능">원
            </div>
        </div>
        <div class="row">
            <div class="col-sm">
                <label for="auctionClosingBid" class="form-label">즉시 낙찰 가격</label>
            </div>
            <div class="col-sm">
                <input type="text" class="form-control" id="auctionClosingBid" placeholder="100원 이상부터 가능">원
            </div>
        </div>
        <div class="row">
            <div class="col-sm">
                <label for="auctionBidUnit" class="form-label">입찰 단위</label>
            </div>
            <div class="col-sm">
                <select class="form-select" id="auctionBidUnit">
                    <option selected>선택</option>
                    <option value="100">100원 (1백원)</option>
                    <option value="1000">1,000원 (1천원)</option>
                    <option value="10000">10,000원 (1만원)</option>
                    <option value="100000">100,000원 (10만원)</option>
                    <option value="1000000">1,000,000원 (100만원)</option>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-sm">
                <label for="auctionClosedTime" class="form-label">경매 마감 시간</label>
            </div>
            <div class="col-sm">
                <input type="date" class="form-control" id="auctionClosedTime">
                <input type="time" class="form-control" id="auctionClosedTime">
            </div>
        </div>
        <div class="row">
            <div class="col-sm">
                <button type="submit" class="btn btn-primary">경매 등록하기</button>
            </div>
            <div class="col-sm">
                <button class="btn btn-secondary">돌아가기</button>
            </div>
        </div>
    </form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
