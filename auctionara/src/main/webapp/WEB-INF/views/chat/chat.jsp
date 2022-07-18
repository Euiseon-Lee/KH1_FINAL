<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div id="app" class="container-fluid" v-cloak>
    <div class="row mt-5">
        <div class="col-3 border-right">
        	<h4 class="fw-bold row border-bottom pb-3 my-0">내 채팅방</h4>
        	<div class="row">
        		<div id="chatroom-wrap" class="col">
			        <c:forEach var="ChatRoomListVO" items="${chatRoomList}">
					<div class="row border-bottom pb-2 pt-3" @click="talk(${ChatRoomListVO.chatRoomNo})" 
						:class="{'bg-light': ${ChatRoomListVO.chatRoomNo} == chatRoomNo}">
						<div class="col-3 pr-0">
							<img class="rounded-circle" src="${root}/attachment/download?attachmentNo=${ChatRoomListVO.attachmentNo}" 
								v-if="${whoLogin} == ${ChatRoomListVO.auctioneerNo}">
							<img class="rounded-circle" src="${root}/attachment/download?attachmentNo=${ChatRoomListVO.auctioneerAttachmentNo}" 
								v-if="${whoLogin} != ${ChatRoomListVO.auctioneerNo}">
						</div>
						<div class="col py-1">
							<h6 class="fw-bold chatroomName" v-if="${whoLogin} == ${ChatRoomListVO.auctioneerNo}">${ChatRoomListVO.memberNick}</h6>
							<h6 class="fw-bold chatroomName"v-if="${whoLogin} != ${ChatRoomListVO.auctioneerNo}">${ChatRoomListVO.auctioneerNick}</h6>
							<h6 class="chatroomName text-muted text-truncate">${ChatRoomListVO.auctionTitle}</h6>
						</div>
			        </div>       
			        </c:forEach>        		
        		</div>
        	</div>
        </div>
        <div class="col" v-show="!showRating && !showReport">
        	<div class="row">
        		<div class="col">
        			<div class="row p-3 border-bottom bg-light" v-if="chatRoomNo != 0">
        				<div class="col-1 mr-4"><img class="rounded" :src="'${root}/attachment/download?attachmentNo=' + photoAttachmentNo"></div>
        				<div class="col ml-3">
        					<div class="row fw-bold mt-2 text-truncate">{{ auctionTitle }}</div>
        					<a class="row text-muted chatroomName mt-2 pointer" @click="showReport = true">
        						<i class="fa-solid fa-land-mine-on mt-1 pl-1 pr-2"></i> 이 채팅 신고하기
        					</a>
        				</div>
        				<div class="col-2 pt-3">
        					<button class="btn btn-info" v-if="auctioneerBtn == null && ${whoLogin} == auctioneerNo" @click="auctioneerFinish">거래 완료</button>
        					<button class="btn btn-info" v-if="memberBtn == null && ${whoLogin} != auctioneerNo" @click="memberFinish">거래 완료</button>
        					<button class="btn btn-success" v-if="auctioneerBtn != null && memberBtn != null && rating && ${whoLogin} != auctioneerNo" 
        						@click="setRating">평가하기</button>
        				</div>
        			</div>
        			<div class="row py-3">
        				<div class="col d-flex flex-column" id="chat-wrap">
        					<div v-for="(chatContent, index) in chatContentDto" class="row my-2 pl-3 pr-5" :key="index" 
        						:class="{'flex-row-reverse': chatContent.chatterNo == ${whoLogin}}">
				            	<img class="rounded-circle profile mr-2" :src="'${root}/attachment/download?attachmentNo=' + attachmentNo" 
				            		v-if="${whoLogin} == auctioneerNo && chatContent.chatterNo != ${whoLogin}">
								<img class="rounded-circle profile mr-2" :src="'${root}/attachment/download?attachmentNo=' + auctioneerAttachmentNo" 
									v-if="${whoLogin} != auctioneerNo && chatContent.chatterNo != ${whoLogin}">
				            	<span class="bg-primary rounded-pill px-3 py-2 text-white" v-if="chatContent.chatType == 0">{{ chatContent.chatContent }}</span>
				            	<img class="photo" :src="'${root}/attachment/download?attachmentNo=' + chatContent.chatContent" 
									v-if="chatContent.chatType == 1">
				            	<img class="emoji" :src="'${root}/image/emoji_' + chatContent.chatContent + '.png'"
									v-if="chatContent.chatType == 2">									
				            	<span class="text-muted chat-time d-flex align-self-end mx-2">{{ chatContent.chatTimeFormat }}</span>     
				            </div>
				            <div v-for="(message, index) in messageList" :key="index" class="row my-2 pl-3 pr-5" 
				            	:class="{'flex-row-reverse': message.chatterNo == ${whoLogin}}">
			                	<img class="rounded-circle profile mr-2" :src="'${root}/attachment/download?attachmentNo=' + attachmentNo" 
			                		v-if="${whoLogin} == auctioneerNo && message.chatterNo != ${whoLogin}">
								<img class="rounded-circle profile mr-2" :src="'${root}/attachment/download?attachmentNo=' + auctioneerAttachmentNo" 
									v-if="${whoLogin} != auctioneerNo && message.chatterNo != ${whoLogin}">
			                	<span class="bg-primary rounded-pill px-3 py-2 text-white" v-if="message.attachmentNo == 0 && message.emojiNo == null">{{ message.message }}</span>
			                	<img class="photo" :src="'${root}/attachment/download?attachmentNo=' + message.attachmentNo" v-if="message.attachmentNo != 0 && message.emojiNo == null">
			                	<img class="emoji" :src="'${root}/image/emoji_' + message.emojiNo + '.png'" v-if="message.emojiNo != null && message.attachmentNo == 0">
			                	<span class="text-muted chat-time d-flex align-self-end mx-2">{{ message.chatTime }}</span>   
			            	</div>
							<div class="row mt-auto p-3" v-if="emoji">
								<img class="col pt-4 border-top pointer" src="${root}/image/emoji_1.png" @click="sendEmoji('1')">
								<img class="col pt-4 border-top pointer" src="${root}/image/emoji_2.png" @click="sendEmoji('2')">
								<img class="col pt-4 border-top pointer" src="${root}/image/emoji_3.png" @click="sendEmoji('3')">
								<img class="col pt-4 border-top pointer" src="${root}/image/emoji_4.png" @click="sendEmoji('4')">
								<img class="col pt-4 border-top pointer" src="${root}/image/emoji_5.png" @click="sendEmoji('5')">
								<img class="col pt-4 border-top pointer" src="${root}/image/emoji_6.png" @click="sendEmoji('6')">
							</div>			            	
        				</div>
        			</div>
        		</div>
        	</div>
            <div class="input-group ml-2" v-if="chatRoomNo != 0">
            	<input type="text" class="form-control border-top border-bottom mr-1" placeholder="메세지를 입력해주세요" 
            		aria-describedby="send" v-model="content">
            	<div class="mr-1">
            		<button class="btn btn-success" type="button" @click="showEmoji">
            			<i class="fa-solid fa-face-kiss-wink-heart"></i>
            		</button>
            	</div>            		
            	<label class="btn btn-info mr-1">
            		<i class="fa-solid fa-image"></i>
            		<input class="form-control d-none" type="file" accept=".png, .jpg, .gif" @change="sendImage" />
            	</label>
            	<div>
            		<button class="btn btn-primary" type="button" id="send" @click="send"><i class="fa-solid fa-paper-plane"></i></button>
            	</div>            	
            </div>
        </div>
        <div class="col" v-show="showRating">
			<div class="row p-3 border-bottom bg-light text-muted pointer" @click="showRating = false">
				<i class="fa-solid fa-arrow-left-long pr-2"></i>채팅방으로 돌아가기
			</div>
        	<h4 class="row fw-bold pl-5 my-5 ml-5">{{ auctioneerNick }} 님과의 거래가 어떠셨나요?</h4>
        	<div class="row px-5 ml-5">
        		<div class="col">
        			<h3 class="row fw-bold text-success pb-3">&#129392; 좋아요</h3>
        			<div v-for="(rating, index) in ratingList" :key="index" :class="{'form-check row mb-2': rating.ratingSortNo == '1'}">
						<label class="form-check-label mr-3 fw-bold text-muted"  for="rating.ratingItemNo" v-if="rating.ratingSortNo == '1'">
				        	<input class="form-check-input" type="radio" name="rating" id="rating.ratingItemNo" 
				        		:value="rating.ratingItemNo" checked /> {{ rating.ratingContent }}
				        </label>
					</div>					
        		</div>
        		<div class="col">
        			<h3 class="row fw-bold text-primary pb-3">&#128532; 별로에요</h3>
        			<div v-for="(rating, index) in ratingList" :key="index" :class="{'form-check row mb-2': rating.ratingSortNo == '0'}">
						<label class="form-check-label mr-3 fw-bold text-muted" for="rating.ratingItemNo" v-if="rating.ratingSortNo == '0'">
				        	<input class="form-check-input" type="radio" name="rating" id="rating.ratingItemNo" 
				        		:value="rating.ratingItemNo" /> {{ rating.ratingContent }}
				        </label>
					</div>				        			
        		</div>
        	</div>
        	<div class="row mt-5 ml-5 px-5"><button type="button" class="btn btn-primary px-3" @click="finishRating">평가 선택 완료</button></div>
        </div>
        <div class="col" v-show="showReport">
			<div class="row p-3 border-bottom bg-light text-muted pointer" @click="showReport = false">
				<i class="fa-solid fa-arrow-left-long pr-2"></i>채팅방으로 돌아가기
			</div>
        	<h4 class="row fw-bold pl-5 my-5 ml-5">{{ auctioneerNick }} 님과의 채팅을 신고하시겠습니까?</h4>
        	<div class="row px-5 ml-5">
        		<input type="text" class="form-control" v-model="reportReason" placeholder="신고 이유를 알려주세요" autocomplete="off" maxlength="100" />
                <div class="text-right mt-1"><span class="text-primary">{{ reportCount }}</span> / 100</div>
        	</div>
        	<div class="row mt-5 ml-5 px-5"><button type="button" class="btn btn-primary px-3" @click="finishReport" :disabled="reportReason == ''">신고 완료</button></div>
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
                attachmentNo: 0,
                auctioneerAttachmentNo: 0,
                ratingList: "",
                socket: null,
                messageList: [],
                content: "",
                div: "",
                auctioneerBtn: false,
                memberBtn: false,
                rating: false,
                showRating: false,
                showReport: false,
                reportReason: "",
                emoji: false,
            };
        },
        computed: {
        	reportCount() {
                return this.reportReason.length;
            },
        },
        methods: {
            talk(chatRoomNo) {
            	this.showRating = false; // 평가창 닫기
            	this.showReport = false; // 신고창 닫기
            	this.emoji = false; // 이모티콘창 닫기
            	
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
            	this.attachmentNo = findInfo.attachmentNo;
            	this.auctioneerAttachmentNo = findInfo.auctioneerAttachmentNo;
            	
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
                this.scrollBottom();
            },
            whenDisconnected() {
            },
            whenError() {
            	alter("서버와의 연결 오류가 발생하였습니다");
            },
            whenMessageReceived(e) {
                var data = JSON.parse(e.data);
                this.div = data; // 받기
                if (data.chatRoomNo == this.chatRoomNo) {
                	this.messageList.push(this.div);
                }
                this.scrollBottom();
            },
            send() {
                var message = {
                    type: 2,
                    chatterNo : ${whoLogin},
                    chatRoomNo: this.chatRoomNo,
                    chatTime: this.chatTime(),
                    message: this.content,
                    messageType: "string",
                };
                this.socket.send(JSON.stringify(message)); // 전송
                axios.post("http://localhost:8080/auctionara/chat/save", {
            		chatRoomNo : this.chatRoomNo,
            		chatterNo : ${whoLogin},
            		chatContent : this.content,
            		chatType : 0,
            	}).then(resp=>{
            		this.content = ""; // 초기화
            		this.scrollBottom();
            	});
            },
            sendImage() {
            	const formData = new FormData();
                formData.append("image", $("input[type=file]")[0].files[0]);
                axios.post("http://localhost:8080/auctionara/attachment/chat", formData)
                .then(resp=>{
            		if(resp.data) {
                        var message = {
                                type: 3,
                                chatterNo : ${whoLogin},
                                chatRoomNo: this.chatRoomNo,
                                chatTime: this.chatTime(),
                                attachmentNo: resp.data.attachmentNo,
                                message: "사진 " + resp.data.attachmentNo,
                                messageType: "string",
                            };
                            this.socket.send(JSON.stringify(message)); // 전송
                            axios.post("http://localhost:8080/auctionara/chat/save", {
                        		chatRoomNo : this.chatRoomNo,
                        		chatterNo : ${whoLogin},
                        		chatContent : resp.data.attachmentNo,
                        		chatType : 1,
                        	}).then(resp=>{
                        		this.image = []; // 초기화
                        		this.content = ""; // 초기화
                        		this.scrollBottom();
                        	});            			
            		}
            	});            	
            },
            sendEmoji(emojiNo) {
                var message = {
                        type: 4,
                        chatterNo : ${whoLogin},
                        chatRoomNo: this.chatRoomNo,
                        chatTime: this.chatTime(),
                        emojiNo: emojiNo,
                        message: "이모티콘 " + emojiNo,
                        messageType: "string",
                    };
                    this.socket.send(JSON.stringify(message)); // 전송
                    axios.post("http://localhost:8080/auctionara/chat/save", {
                		chatRoomNo : this.chatRoomNo,
                		chatterNo : ${whoLogin},
                		chatContent : emojiNo,
                		chatType : 2,
                	}).then(resp=>{
                		this.content = ""; // 초기화
                		this.emoji = false;
                		this.scrollBottom();
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
            setRating() {
            	axios.get("http://localhost:8080/auctionara/chat/rating/list")
            	.then(resp => {
            		this.showRating = true;
            		this.ratingList = resp.data;
            	});
            },
            finishRating() {
            	axios.post("http://localhost:8080/auctionara/chat/rating/save", {
            		ratingItemNo: $('input:radio[name=rating]:checked').val(),
            		auctionNo: this.auctionNo,
            	})
            	.then(resp => {
            		this.showRating = false;
            		this.rating = false;
            	});
            },
            finishReport() {
            	axios.post("http://localhost:8080/auctionara/chat/report", {
            		chatRoomNo: this.chatRoomNo,
            		memberNo: ${whoLogin},
            		chatReportReason: this.reportReason,
            	})
            	.then(resp => {
            		this.showReport = false;
            	}); 	
            },
            chatTime() {
            	var d = new Date();
                return (d.getMonth()+1) + "월 " + d.getDate() + "일 " + d.getHours() + ":" + d.getMinutes();
            },
            scrollBottom() {
            	$("#chat-wrap").scrollTop($("#chat-wrap")[0].scrollHeight); // 스크롤 맨 아래로
            },
            showEmoji() {
            	if(this.emoji) {
            		this.emoji = false;
            	} else {
            		this.emoji = true;
            	}
            	this.scrollBottom();
            }
        },
        mounted() {
        	history.pushState(null, null, "${root}/chat"); // URL 변경
        	<c:if test="${not empty chatRoomNo}">
        		this.chatRoomNo = ${chatRoomNo};
        	</c:if>
        	<c:forEach var="ChatRoomListVO" items="${chatRoomList}">
	    		this.chatRoomList.push({chatRoomNo: ${ChatRoomListVO.chatRoomNo}, auctionNo: ${ChatRoomListVO.auctionNo}, 
	    			auctioneerNo: ${ChatRoomListVO.auctioneerNo}, photoAttachmentNo: ${ChatRoomListVO.photoAttachmentNo}, 
	    			auctionTitle: "${ChatRoomListVO.auctionTitle}", auctioneerNick: "${ChatRoomListVO.auctioneerNick}",
	    			attachmentNo: ${ChatRoomListVO.attachmentNo}, auctioneerAttachmentNo: ${ChatRoomListVO.auctioneerAttachmentNo}});
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
    
    #chatroom-wrap {
    	height: 765px;
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
    
    .rounded-circle.profile {
    	object-fit: cover;
    	width: 40px;
        height: 40px;    
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
		cursor: pointer;
	}
	
    .message-wrapper>.message {
        display: flex;
    }
    
    .photo {
    	border-radius: 1.5rem;
    	width: 300px;
    }
    
    .emoji {
    	width: 120px;
    }

</style>

<%@include file="/WEB-INF/views/template/footer.jsp" %>
