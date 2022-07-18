<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!-- 세션 정보 추가 -->
<c:set var="memberNo" value="${whoLogin}"></c:set>
<c:set var="isLogin" value="${memberNo != null}"></c:set>
<c:set var="isAdmin" value="${auth == '관리자'}"></c:set>
<c:set var="isBlackMamba" value="${auth == '블랙회원'}"></c:set>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>경매나라</title>
<style>
	.chatbotArea {
	  position: fixed; /* 이 부분을 고정 */
	  bottom: 0; /* 하단에 여백 없이 */
	  width: 5%; /* 가로 사이즈를 브라우저에 가득 채움 */
	}
</style>
    <!-- 파비콘 -->
    <link rel="icon" href="${root}/image/favicon.ico">

    <!-- Noto Sans 폰트 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="${root}/css/reset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
    <link rel="stylesheet" type="text/css" href="${root}/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/custom.css">
</head>

<body>
    <div class="container">
        <nav class="navbar navbar-primary bg-white sticky-top pt-3">
            <a class="navbar-brand mb-2" href="${root}/">
                <img src="${root}/image/logo.png" alt="logo" class="d-inline-block">
            </a>
            <form class="position-relative" action="${root}/auction/search" method="get">
                <input class="form-control bg-light rounded-pill border-0" type="search" placeholder="찾으시는 물품의 키워드를 입력해주세요" name="keyword" autocomplete="off" value="">
                <i class="fa-solid fa-magnifying-glass text-secondary position-absolute"></i>
            </form>
            <div class="d-flex">
                <a href="${root}/auction/write"><button class="btn btn-primary rounded-pill"><i class="fa-solid fa-pen-to-square mx-1"></i> 경매 등록</button></a>
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">임시 메뉴</a>
                    <ul class="dropdown-menu ml-4">
                    
                    	<c:choose>
                    		<c:when test="${isLogin}">
                    			<li><a class="dropdown-item" href="${root}/chat">채팅</a></li>
								<li><a class="dropdown-item" href="${root}/mypage/index">마이페이지</a></li>
								<li><a class="dropdown-item" href="${root}/member/logout">로그아웃</a></li>
                    		</c:when>
                    		<c:otherwise>
                    			<li><a class="dropdown-item" href="${root}/member/login">로그인</a></li>
								<li><a class="dropdown-item" href="${root}/member/join">회원가입</a></li>
                    		</c:otherwise>
                    	</c:choose>
                    	

                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="${root}/admin/">관리자 페이지</a></li>
                    </ul>
                </div>
            </div>
        </nav>
			
			</div>
			<div id="appp">
				<button type="button" class="btn btn-primary chatbotArea" data-bs-toggle="modal" data-bs-target="#exampleModal" @click="question()">
				  궁금증
				</button>
			
				<!-- Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">도움을 드려요</h5>
				        <button type="button" class="btn-close" @click="end()" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				      	<div v-for="(chatbotContent, index) in chatbotContentDto" class="chatbotContentDto" :key="index">
				      		<button class="btn" @click="requestion(chatbotContent.chatbotNo)">{{chatbotContent.chatbotContent}}</button>
				      	</div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				      </div>
				    </div>
				  </div>
				</div>
			</div>
    <script src="https://unpkg.com/vue@next"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script>
        //div[id=app]을 제어할 수 있는 Vue instance를 생성
        const appp = Vue.createApp({
            //data : 화면을 구현하는데 필요한 데이터를 작성한다.
            data(){
                return {
                    chatbotContentDto:[],
                    chatbotNo:0,
                };
            },
            //computed : data를 기반으로 하여 실시간 계산이 필요한 경우 작성한다.
            // - 3줄보다 많다면 사용하지 않는 것을 권장한다(복잡한 계산 시 성능 저하가 발생)
            computed:{
                
            },
            //methods : 애플리케이션 내에서 언제든 호출 가능한 코드 집합이 필요한 경우 작성한다.
            methods:{
            	question(){
            		this.chatbotNo=0;
	            	axios({
	                    url: "${pageContext.request.contextPath}/rest/chatbot/list/"+this.chatbotNo,
	                    method: "get"
	                 }).then(resp=>{
	                   this.chatbotContentDto = resp.data;
	                   console.log(resp.data);
	                 });
	          	},
	          	requestion(chatbotNo){
	          		this.chatbotNo = chatbotNo;
	          		console.log(this.chatbotNo);
	          		axios({
	                    url: "${pageContext.request.contextPath}/rest/chatbot/list/"+this.chatbotNo,
	                    method: "get",
	                 }).then(resp=>{
	                   this.chatbotContentDto = resp.data;
	                   console.log(resp.data);
	                 });
	          	},
	          	end(){
	          		this.chatbotNo = 0;
	          	},
            },
            //watch : 특정 data를 감시하여 연계 코드를 실행하기 위해 작성한다
            watch:{
                
            },
        });
        appp.mount("#appp");
    </script>
        <div class="container">
         <!-- vue js도 lazy loading을 사용한다 -->
