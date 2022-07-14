<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div id="app" class="container-fluid" v-cloak>
    <div class="row mt-5">
        <div class="col-3 border-right">
        	<h4 class="fw-bold row border-bottom pb-3 my-0">내 채팅방</h4>
	        <c:forEach var="ChatRoomListVO" items="${chatRoomList}">
			<div class="row border-bottom pb-2 pt-3" @click="talk(${ChatRoomListVO.chatRoomNo})" :class="{'bg-light': ${ChatRoomListVO.chatRoomNo} == chatRoomNo}">
				<div class="col-3 pr-0">
					<img class="rounded-circle" src="${root}/attachment/download?attachmentNo=${ChatRoomListVO.attachmentNo}" v-if="${whoLogin} == ${ChatRoomListVO.auctioneerNo}">
					<img class="rounded-circle" src="${root}/attachment/download?attachmentNo=${ChatRoomListVO.auctioneerAttachmentNo}" v-if="${whoLogin} != ${ChatRoomListVO.auctioneerNo}">
				</div>
				<div class="col py-1">
					<h6 class="fw-bold chatroomName" v-if="${whoLogin} == ${ChatRoomListVO.auctioneerNo}">${ChatRoomListVO.memberNick}</h6>
					<h6 class="fw-bold chatroomName"v-if="${whoLogin} != ${ChatRoomListVO.auctioneerNo}">${ChatRoomListVO.auctioneerNick}</h6>
					<h6 class="chatroomName text-muted text-truncate">${ChatRoomListVO.auctionTitle}</h6>
				</div>
	        </div>       
	        </c:forEach>
        </div>
        <div class="col" v-show="!showRating">
        	<div class="row">
        		<div class="col">
        			<div class="row p-3 border-bottom bg-light" v-if="chatRoomNo != 0">
        				<div class="col-1 mr-4"><img class="rounded" :src="'${root}/attachment/download?attachmentNo=' + photoAttachmentNo"></div>
        				<div class="col ml-3">
        					<div class="row fw-bold mt-2 text-truncate">{{ auctionTitle }}</div>
        					<a class="row text-muted chatroomName mt-2"><i class="fa-solid fa-right-from-bracket mt-1 pr-2"></i> 판매자 정보 보러가기</a>
        				</div>
        				<div class="col-2 pt-3">
        					<button class="btn btn-info" v-if="auctioneerBtn == null && ${whoLogin} == auctioneerNo" @click="auctioneerFinish">거래 완료</button>
        					<button class="btn btn-info" v-if="memberBtn == null && ${whoLogin} != auctioneerNo" @click="memberFinish">거래 완료</button>
        					<button class="btn btn-success" v-if="auctioneerBtn != null && memberBtn != null && rating && ${whoLogin} != auctioneerNo" @click="showRating = true">평가하기</button>
        				</div>
        			</div>
        			<div class="row py-3">
        				<div class="col" id="chat-wrap">
        					<div v-for="(chatContent, index) in chatContentDto" class="row my-2 pl-3 pr-5" :key="index" :class="{'flex-row-reverse': chatContent.chatterNo == ${whoLogin}}">
				            	<span class="bg-primary rounded-pill px-3 py-2 text-white">{{ chatContent.chatContent }}</span><span class="text-muted chat-time mt-3 mx-2">{{ chatContent.chatTimeFormat }}</span>     
				            </div>
				            <div v-for="(message, index) in messageList" :key="index" class="row">
			                        {{messageList[index].message}}
			            	</div>
        				</div>
        			</div>
        		</div>
        	</div>
            <div class="input-group ml-2" v-if="chatRoomNo != 0">
            	<input type="text" class="form-control border-top border-bottom mr-1" placeholder="메세지를 입력해주세요" aria-describedby="send" v-model="content">
            	<button class="btn btn-primary" type="button" id="send" @click="send"><i class="fa-solid fa-paper-plane"></i></button> 
            </div>
        </div>
        <div class="col" v-show="showRating">
			<div class="row p-3 border-bottom bg-light text-muted pointer" @click="showRating = false"><i class="fa-solid fa-arrow-left-long pr-2"></i>채팅방으로 돌아가기</div>
        	<h4 class="row">{{ auctioneerNick }}님과 거래가 어떠셨나요?</h4>
        	<div class="row">
        		<div class="col">
        			<h5 class="row">좋아요</h5>
        			<div class="form-check row">
						<label class="form-check-label mr-3" for="like1">
					    	<input class="form-check-input" type="radio" name="rating" id="like1" checked /> 임시
						</label>
					</div>
        			<div class="form-check row">
						<label class="form-check-label mr-3" for="like1">
					    	<input class="form-check-input" type="radio" name="rating" id="like1" checked /> 임시
						</label>
					</div>					
        		</div>
        		<div class="col">
        			<h5 class="row">별로에요</h5>
        			<div class="form-check row">
						<label class="form-check-label mr-3" for="like1">
					    	<input class="form-check-input" type="radio" name="rating" id="like1" checked /> 임시
						</label>
					</div>
        			<div class="form-check row">
						<label class="form-check-label mr-3" for="like1">
					    	<input class="form-check-input" type="radio" name="rating" id="like1" checked /> 임시
						</label>
					</div>					        			
        		</div>
        	</div>
        </div>
    </div>
</div>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script src="https://unpkg.com/vue@next"></script>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>

<script>
    const app = Vue.createApp({
        data() {
            return {
                chatContentDto: [],
                chatRoomNo: 0,
                chatRoomList: [],
                auctionNo: 0,
                auctionTitle: "",
                photoAttachmentNo: 0,
                auctioneerNo: 0,
                auctioneerNick: "",
                socket: null,
                messageList: [],
                content: "",
                div: "",
                auctioneerBtn: false,
                memberBtn: false,
                rating: false,
                showRating: false,
            };
        },
        methods: {
            talk(chatRoomNo) {
            	this.showRating = false; // 평가창 닫기
            	
            	if(this.socket != null) {
            		this.socket.close(); // 이전 연결 닫기
            	} 
            	
            	if(this.chatRoomNo != chatRoomNo) {
            		this.messageList = []; // 메세지 비우기
            	}
            	
                this.chatRoomNo = chatRoomNo; // 채팅방 번호 변경
                
             	// 해당 채팅방 채팅 이력 가져오기
                axios.get("http://localhost:8080/auctionara/chat/talk/" + chatRoomNo)
                .then(resp => {
                    this.chatContentDto = resp.data; 
                }); 
                
                // 경매 정보 출력
            	const findInfo = this.chatRoomList.find(this.auctionInfo);
            	this.auctionNo = findInfo.auctionNo;
            	this.auctionTitle = findInfo.auctionTitle;
            	this.photoAttachmentNo = findInfo.photoAttachmentNo;
            	this.auctioneerNo = findInfo.auctioneerNo;
            	this.auctioneerNick = findInfo.auctioneerNick;
            	
                // 거래 완료 및 평가 여부 확인
                this.updateCheck();

                // 채팅 서버 접속
                this.socket = new SockJS("http://localhost:8080/auctionara/ws/chat");
                this.socket.onopen = this.whenConnected;
                this.socket.onclose = this.whenDisconnected;
                this.socket.onerror = this.whenError;
                this.socket.onmessage = this.whenMessageReceived;
            },
            whenConnected() {
                var message = {
                    type: 1,
                    chatRoomNo: this.chatRoomNo,
                };
                var json = JSON.stringify(message);
                this.socket.send(json);
            },
            whenDisconnected() {
                console.log("연결 종료");
            },
            whenError() {
            	console.log("서버와의 연결 오류가 발생하였습니다");
            },
            whenMessageReceived(e) {
                var data = JSON.parse(e.data);
                var timeObject = moment(data.chatTime).format("MM-DD H:mm");

                    this.div = data; // 받기
                    if (data.chatRoomNo == this.chatRoomNo) {
                        this.messageList.push(this.div);
                    }
            },
            send() {
                var message = {
                    type: 2,
                    // 채터 추가
                    chatRoomNo: this.chatRoomNo,
                    message: this.content,
                    messageType: "string",
                };
                this.socket.send(JSON.stringify(message)); // 전송
                axios.post("http://localhost:8080/auctionara/chat/save", {
            		chatRoomNo : this.chatRoomNo,
            		chatterNo : ${whoLogin},
            		chatContent : this.content,
            	}).then(resp=>{
            		this.content = ""; // 초기화
            	});
            },
            auctionInfo(e) {
            	if(e.chatRoomNo === this.chatRoomNo)  {
        		    return true;
        		}
            },
            auctioneerFinish() {
            	axios.get("http://localhost:8080/auctionara/chat/auctioneer/approve/" + this.auctionNo)
                .then(resp => {
                	this.updateCheck();
                });
            },
            memberFinish() {
            	axios.get("http://localhost:8080/auctionara/chat/bidder/approve/" + this.auctionNo)
                .then(resp => {
					this.updateCheck();
                });
            },
            updateCheck() {
               	axios.get("http://localhost:8080/auctionara/chat/check/" + this.auctionNo)
                .then(resp => {
                	console.log(resp.data);
                    if(resp.data) {
                    	this.auctioneerBtn = resp.data.succAuctioneerApprove;
                    	this.memberBtn = resp.data.succBidderApprove;
                    	if(resp.data.ratingNo == 0) {
                    		this.rating = true;
                    	}
                    } else {
                    	this.auctioneerBtn = false;
                    	this.memberBtn = false;
                    	this.rating = false;
                    }
                });
            },
        },
        mounted() {
        	history.pushState(null, null, "${root}/chat"); // URL 변경
        	<c:if test="${not empty chatRoomNo}">
        		this.chatRoomNo = ${chatRoomNo};
        	</c:if>
        	<c:forEach var="ChatRoomListVO" items="${chatRoomList}">
	    		this.chatRoomList.push({chatRoomNo: ${ChatRoomListVO.chatRoomNo}, auctionNo: ${ChatRoomListVO.auctionNo}, auctioneerNo: ${ChatRoomListVO.auctioneerNo}, photoAttachmentNo: ${ChatRoomListVO.photoAttachmentNo}, auctionTitle: "${ChatRoomListVO.auctionTitle}", auctioneerNick: ${ChatRoomListVO.auctioneerNick}});
	    	</c:forEach>
        	
        	if(this.chatRoomNo != 0) {
        		this.talk(this.chatRoomNo);
        	}
        },
    });
    app.mount("#app");
</script>
<style scoped>
	.border-right {
		min-height: 813px;
	}

    #chat-wrap {
    	height: 640px;
    	overflow: scroll;
    }
    
    .chat-time {
    	font-size: 0.75em;
    }
    
    .rounded-circle {
    	object-fit: cover;
    	width: 50px;
        height: 50px;
    }
    
    img.rounded {
    	object-fit: cover;
    	width: 70px;
        height: 70px;
    }

    .chatroomName {
    	font-size: 0.9em;
    }
	
	.pointer {
		corsur: pointer;
	}
	
    .message-wrapper>.message {
        display: flex;
    }
    

</style>

<%@include file="/WEB-INF/views/template/footer.jsp" %>
