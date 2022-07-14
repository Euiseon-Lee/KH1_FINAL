<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="/WEB-INF/views/template/header.jsp" %>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <style>
        .chatContent{
            height:650px;
        }
        .auction{
        	height:100px;
        }
	.message-wrapper > .message {
		display:flex;
	}
    </style>
</head>

<h1>${memberNo}님의 채팅목록</h1>

	<div id="app" class="container-fluid">
		<div class="row mt-4 border">
			<div class="col-sm-4 border">
				<table>
                    <tr>
                        <th>채팅방 정보 {{chatRoomNo}}</th>
                    </tr>
                    <tr>
                        <td>
                            <button v-for="(chatRoom, list) in chatRoomListVO" :key="list" :id="list" class="chatRoomListVO" @click="talk(chatRoom.chatRoomNo);">
                            	{{chatRoom.chatRoomNo}}			
                                {{chatRoom.auctionNo }}			
                                {{chatRoom.memberNo }}			
                                {{chatRoom.memberNick }}			
                                {{chatRoom.chatContent }}			
                                {{chatRoom.chatTime }}			
                                {{chatRoom.attachmentNo}}
                  			</button>
                        </td>
                    </tr>
				</table>
			</div>
             <div class="col-sm-8 border">

             	<div class="row container-fluid auction border">
             	</div>
             	
                <div class="container-fluid chatContent overflow-auto">
                    <div class="message-wrapper">
                    	<div v-for="(chatContent, index) in chatContentDto" class="chatContentDto" :key="index">
                    		{{chatContent.chatterNo}}
                    		{{chatContent.chatContent}}
                    		{{chatContent.chatTime}}
                  		</div>
                  		<div v-for="(message, index) in messageList" :key="index" class="chatContentDto">
                  			{{messageList[index].message}}
                  		</div>
                    </div>
                </div>
                <div class="container">
                    <input type="file" class="file-input">
                    <button class="btn-send-file" @click="send_file()">파일 전송</button>
                    <br>
                    <input type="text" class="send-input" v-model="contents">
                    <button class="btn-send" @click="send()">텍스트 전송</button>
                </div>
            </div>
	    </div>
    </div>
	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
	<script src="https://unpkg.com/vue@next"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.3/moment.min.js"></script>
	
    <script>
        const app = Vue.createApp({
            data(){
                return {
                	chatContentDto:[],
                	chatRoomListVO:[],
                	chatRoomNo: 0,
                	socket:null,
                	messageList:[],
                	contents:"",
                	div:"",
                };
            },
            computed:{
            	
            },
            methods:{
               talk(chatRoomNo){
            	   this.chatRoomNo = chatRoomNo;
            	   axios({
                       url: "${pageContext.request.contextPath}/chat/talk/"+chatRoomNo,
                       method: "get"
                    }).then(resp=>{
                      this.chatContentDto = resp.data;
                    });

                  	var uri = "${pageContext.request.contextPath}/ws/chat";
         			
      	   			//접속
      	   			this.socket = new SockJS(uri);
       	   			
       	   			this.socket.onopen = this.whenConnected;
       	   			this.socket.onclose = this.whenDisconnected;
       	   			this.socket.onerror = this.whenError;
          			this.socket.onmessage = this.whenMessageReceived;
               },
               whenConnected(){
	   				var message={
	   					type:1,
	   					chatRoomNo:this.chatRoomNo,
	   				};
	   				var json = JSON.stringify(message);
	   				this.socket.send(json);
	   				console.log("join");
               },
               whenDisconnected(){
            		alert("연결 종료");  
               },
               whenError(){
   					alert("서버와의 연결 오류가 발생하였습니다");
               },
               whenMessageReceived(e){
            	   var data = JSON.parse(e.data);
   					console.log(e.data);
   					console.log(data);
	   				var timeObject = moment(data.chatTime).format("MM-DD H:mm");
	   							
	   				if(data.messageType=="string"){
	   					this.div =data;
	   					
	   					if(data.chatRoomNo==this.chatRoomNo){
	   						this.messageList.push(this.div);
	   					}
	   					console.log(this.messageList);
	   					
	   				}else{
	   					var div = $("<div>").addClass("message");
	   					
	   					var img = $("<img>").attr("src", e.data).css("width", "100px").css("height", "100px");
	   					var link = $("<a>").attr("href", e.data).text("다운로드");
	   					
	   					var span1 = $("<span>").addClass("chatter").text(data.chatterNo);
	   					var span3 = $("<span>").addClass("time").text(timeObject);
	   					
	   					//이거 테스트 해봐야 안다... 일단 chatContent 제거함
	   					div.append(span1).append(img).append(link).append(span3);
	   					
	   					$(".message-wrapper").append(div);
	   				}
	              },
	              send(){
	            	  	var text = this.contents;
	        			var messageType = "string";
	        			if(!text) return;
	    				var chatRoom = this.chatRoomNo;
	        			
	        			var message = {
	        		            type:2,
	        		            chatRoomNo:chatRoom,
	        		            message:text,
	        		            messageType:messageType
	        		         };
	        			var senderMessage = JSON.stringify(message);
	        			this.socket.send(senderMessage);//전송 명령
	        			
	        			this.contents="";//초기화
	              },
	              send_file(){
	        			var fileList = document.querySelector(".file-input").files;
	        			
	        			if(fileList.length == 0) return;
	        			var messageType = "binary";
	        			
	        				var reader = new FileReader();
	        				reader.onload = function(e){
	        					var data = {
	        						message:e.target.result,
	        						type:2,
	        						chatRoomNo:this.chatRoomNo,
	        						messageType:messageType
	        					};
	        					
	        					this.socket.send(data);
	        				};
	        				reader.readAsArrayBuffer(fileList[0]);
	              },
	              
	              
            },
            watch:{
            },
            created(){
            	
            	axios({
                    url: "${pageContext.request.contextPath}/chat/list",
                    method: "get"
                 }).then(resp=>{
                   this.chatRoomListVO = resp.data;
                 });

            },
            mounted(){
            },
        });
        app.mount("#app");
    </script>


<%@include file="/WEB-INF/views/template/footer.jsp" %>

