<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-fluid" id="app">
    <form action="${root}/auction/submit" method="post" class="needs-validation" enctype="multipart/form-data" @submit="beforeSubmit" id="form">
        <div class="row pt-5 pb-3 border-bottom border-dark">
            <div class="col-sm">
                <h2 class="fw-bold">경매 등록</h2>
            </div>
        </div>
        <div class="row py-4 border-bottom">
            <div class="col-sm-3">
                <label class="form-label">경매 물품 이미지 (<span class="text-primary">{{ attachmentCount }}</span>/4)</label>
            </div>
            <div class="col-sm d-flex">
                <div v-for="(no, index) in attachmentUrl" v-bind:key="index" class="position-relative preview mr-2">
                    <img :src="attachmentUrl[index]" />
                    <span class="bg-primary p-1" @click="attachmentRemove(index)">삭제</span>
                </div>
                <label class="btn btn-outline-primary pt-5" id="add_btn" v-show="attachmentCount < 4">
                    <i class="fa-solid fa-camera fa-2x"></i><br>
                    사진 추가
                    <input class="form-control d-none" type="file" id="attachment" accept=".png, .jpg, .gif" @change="attachmentPreview" />
                </label>
            </div>
        </div>
        <div class="row py-4 border-bottom">
            <div class="col-sm-3">
                <label for="auctionTitle" class="form-label">제목</label>
            </div>
            <div class="col-sm">
                <input type="text" class="form-control" id="auctionTitle" name="auctionTitle" v-model="auctionTitle" placeholder="경매 물품 제목을 입력해주세요" autocomplete="off" maxlength="30" />
                <div class="text-right mt-1"><span class="text-primary">{{ titleCount }}</span> / 30</div>
            </div>
        </div>
        <div class="row py-4 border-bottom">
            <div class="col-sm-3">
                <label for="categoryNo" class="form-label">카테고리</label>
            </div>
            <div class="col-sm">
                <select class="form-control" id="categoryNo" name="categoryNo" v-model="categoryNo">
                    <option value="">선택</option>
                    <c:forEach var="categoryDto" items="${categoryList}">
                        <option value="${categoryDto.categoryNo}">${categoryDto.categoryName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="row py-4 border-bottom">
            <div class="col-sm-3">
                <label class="form-label">경매 물품 상태</label>
            </div>
            <div class="col-sm">
                <div class="form-check form-check-inline">
                    <label class="form-check-label mr-3" for="radio5">
                        <input class="form-check-input" type="radio" name="auctionStatus" id="radio5" value="5" checked />상
                    </label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label mr-3" for="radio4">
                        <input class="form-check-input" type="radio" name="auctionStatus" id="radio4" value="4" />중상
                    </label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label mr-3" for="radio3">
                        <input class="form-check-input" type="radio" name="auctionStatus" id="radio3" value="3" />중
                    </label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label mr-3" for="radio2">
                        <input class="form-check-input" type="radio" name="auctionStatus" id="radio2" value="2" />중하
                    </label>
                </div>
                <div class="form-check form-check-inline">
                    <label class="form-check-label mr-3" for="radio1">
                        <input class="form-check-input" type="radio" name="auctionStatus" id="radio1" value="1" />하
                    </label>
                </div>
            </div>
        </div>
        <div class="row py-4 border-bottom">
            <div class="col-sm-3">
                <label for="auctionContent" class="form-label">경매 물품 설명</label>
            </div>
            <div class="col-sm">
                <textarea class="form-control" id="auctionContent" name="auctionContent" rows="5" v-model="auctionContent" placeholder="경매 물품에 대한 설명을 자세히 입력해주세요" autocomplete="off" maxlength="100"></textarea>
                <div class="text-right mt-1"><span class="text-primary">{{ contentCount }}</span> / 100</div>
            </div>
        </div>
        <div class="row py-4 border-bottom">
            <div class="col-sm-3">
                <label for="auctionBidUnit" class="form-label">입찰 단위</label>
            </div>
            <div class="col-sm">
                <select class="form-control" id="auctionBidUnit" name="auctionBidUnit" v-model="auctionBidUnit">
                    <option value="100">100원 (1백원)</option>
                    <option value="1000">1,000원 (1천원)</option>
                    <option value="10000">10,000원 (1만원)</option>
                    <option value="100000">100,000원 (10만원)</option>
                    <option value="1000000">1,000,000원 (100만원)</option>
                </select>
            </div>
        </div>
        <div class="row py-4 border-bottom">
            <div class="col-sm-3">
                <label for="auctionOpeningBid" class="form-label">최소 입찰 가격</label>
            </div>
            <div class="col-sm">
                <input type="text" class="form-control" id="auctionOpeningBid" name="auctionOpeningBid" v-bind:class="{'is-invalid': (!auctionOpeningBidVaild() && auctionOpeningBid != '')}" v-model="auctionOpeningBid" placeholder="100" autocomplete="off" maxlength="9" />
                <div class="invalid-feedback">입찰 단위에 맞는 금액만 가능합니다.</div>
            </div>
            <div class="col-sm align-self-center">원</div>
        </div>   
        <div class="row py-4 border-bottom">
            <div class="col-sm-3">
                <label for="auctionClosingBid" class="form-label">즉시 낙찰 가격</label>
            </div>
            <div class="col-sm">
                <input type="text" class="form-control" id="auctionClosingBid" name="auctionClosingBid" v-bind:class="{'is-invalid': (!auctionClosingBidValid() && auctionClosingBid != '')}" v-model="auctionClosingBid" placeholder="100" autocomplete="off" maxlength="9" />
                <div class="invalid-feedback">최소 입찰 가격보다 높거나 같고, 입찰 단위에 맞는 금액만 가능합니다.</div>
            </div>
            <div class="col-sm align-self-center">원</div>
        </div>             
        <div class="row py-4 border-bottom">
            <div class="col-sm-3">
                <label for="auctionClosedTime" class="form-label">경매 마감 기한</label>
            </div>
            <div class="col-sm">
                <input type="datetime-local" class="form-control" id="auctionClosedTime" name="auctionClosedTime" v-model="auctionClosedTime" />
            </div>
        </div>
        <div class="row py-4 d-flex justify-content-end">
            <button type="submit" class="btn btn-primary mr-2" :disabled="!formPass">경매 등록하기</button>
            <a class="btn btn-secondary" href="${root}/">돌아가기</a>
        </div>
    </form>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
    // 현재 시간 +1일 전 / +31일 후는 경매 마감일로 설정하지 못하도록 설정
    let today = new Date();
    let min = new Date(today.setDate(today.getDate() + 2)).toISOString().slice(0, 16);
    let max = new Date(today.setDate(today.getDate() + 32)).toISOString().slice(0, 16);
    document.getElementById("auctionClosedTime").min = min;
    document.getElementById("auctionClosedTime").max = max;

    const app = Vue.createApp({
        data() {
            return {
                attachment: [],
                attachmentUrl: [],
                attachmentCount: 0,
                auctionTitle: "",
                categoryNo: "",
                auctionContent: "",
                auctionOpeningBid: "",
                auctionClosingBid: "",
                auctionBidUnit: "100",
                auctionClosedTime: "",
                openingBidVaild: false,
                closingBidValid: false,
            };
        },
        computed: {
            titleCount() {
                return this.auctionTitle.length;
            },
            contentCount() {
                return this.auctionContent.length;
            },
            formPass() {
                return this.attachmentCount > 0 && this.auctionTitle != "" && this.categoryNo != "" && this.openingBidVaild && this.closingBidValid && this.auctionOpeningBid != "" && this.auctionClosingBid != "" && this.auctionContent != "" && this.auctionClosedTime != "";
            },
        },
        methods: {
            attachmentPreview() {
                const attachment = document.getElementById("attachment");
                this.attachment.push(attachment.files[0]);
                this.attachmentUrl.push(URL.createObjectURL(attachment.files[0]));
                this.attachmentCount++;
            },
            attachmentRemove(index) {
                this.attachment.splice(index, 1);
                this.attachmentUrl.splice(index, 1);
                this.attachmentCount--;
            },
            auctionOpeningBidVaild() {
				this.openingBidVaild = parseInt(this.auctionOpeningBid % this.auctionBidUnit) == 0
                return this.openingBidVaild;
            },
            auctionClosingBidValid() {
				this.closingBidValid = parseInt(this.auctionClosingBid % this.auctionBidUnit) == 0 && parseInt(this.auctionClosingBid) >= parseInt(this.auctionOpeningBid);
                return this.closingBidValid;
            },
            beforeSubmit(e) {
                const form = document.getElementById("form");
                const formData = new FormData(form);
                var request = new XMLHttpRequest();
                for (var i = 0; i < this.attachmentCount; i++) {
                    formData.append("attachment", this.attachment[i]);
                };
                request.open("POST", "http://localhost:8080/auctionara/auction/write");
                request.send(formData);
            }
        },
    });
    app.mount("#app");

</script>
<style scoped>
    #add_btn {
        width: 150px;
        height: 150px;
    }

    .preview {
        width: 150px;
        height: 150px;
    }

    .preview img {
        position: absolute;
        top: 0;
        left: 0;
        transform: translate(50, 50);
        width: 100%;
        height: 100%;
        object-fit: cover;
        margin: auto;
        border-radius: .25rem;
    }

    .preview span {
        position: absolute;
        top: 0;
        right: 0;
        color: #ffffff;
        font-size: 12px;
        cursor: pointer;
        border-radius: .25rem;
    }

    .form-label {
        font-size: 18px;
    }

</style>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
