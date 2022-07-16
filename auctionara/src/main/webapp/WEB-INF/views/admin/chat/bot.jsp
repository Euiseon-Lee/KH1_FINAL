<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="/WEB-INF/views/admin/template/header.jsp" %>

<div id="app" class="container">

	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<h1>챗봇 관리</h1>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-5">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<h3>항목 추가 및 수정</h3>
					</div>
					<div class="row mt-4">
						<label>{{superContent}}</label>
					</div>
					<div class="row p-2">
						<input class="form-control" required v-model="currentData.chatbotContent">
					</div>
					<div class="row p-2">
						<button class="btn btn-primary" v-on:click="addItem">{{mode}}</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-7">
			<div class="card">
				<div class="card-body">
					<table class="table table-border">
						<tr v-for="(chatbot, index) in dataList" v-bind:key="index">
							<td>
								<i class="fa-solid fa-arrow-turn-up fa-rotate-90 fa-fw" v-if="chatbot.chatbotSuperNo > 0" class="padding:1px;"></i>
								{{chatbot.chatbotContent}}
							</td>
							<td width="10%" v-if="chatbot.chatbotSuperNo == 0">
								<a href="#" v-on:click.prevent="answerItem(index);">답변</a>
							</td>
							<td width="10%" v-if="chatbot.chatbotSuperNo > 0">
								<span></span>
							</td>
							<td width="10%">
								<a href="#" v-on:click.prevent="selectItem(index);">수정</a>
							</td>
							<td width="10%">
								<a href="#" v-on:click.prevent="deleteItem(index);">삭제</a>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	
</div>

<!-- VueJS -->
<script src="https://unpkg.com/vue@next"></script>

<!-- 배포용 CDN -->
<!-- <script src="https://unpkg.com/vue@next/dist/vue.global.prod.js"></script> -->

<!-- axios CDN -->
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

<script>
	const app = Vue.createApp({
		data(){
			return{
				dataList:[],
				
				superContent:"",
				
				currentData:{
					chatbotNo:"",
					chatbotContent:"",
					chatbotSuperNo:"", 
				},
				
				index:-1,
			};
		},
		computed:{
			mode(){
				return this.index < 0 ? "등록" : "수정";
			},
			isInsertMode(){
				return this.mode == "등록";
			},
			isEditMode(){
				return this.mode == "수정";
			},
		},
		methods:{
			deleteItem(index){
				var choice = window.confirm("해당 항목을 정말 삭제하시겠습니까?");
				if(choice == false) return;  
				
				const chatbotNo = this.dataList[index].chatbotNo;
				
				if(index > 0) {
					if(this.dataList[index].chatbotNo == this.dataList[index + 1].chatbotSuperNo) {
						this.dataList.splice(index, 2);
					} else {
						this.dataList.splice(index, 1);
					}
				} else {
					this.dataList.splice(index, 1);
				}
				
				axios({
					url:"${pageContext.request.contextPath}/rest/chatbot/"+chatbotNo,
					method:"delete", // deleteMapping
				})
				.then(()=>{
					if(index > 0) {
						if(this.dataList[index].chatbotNo == this.dataList[index + 1].chatbotSuperNo) {
							this.dataList.splice(index, 2);
						} else {
							this.dataList.splice(index, 1);
						}
					} else {
						this.dataList.splice(index, 1);
					}
				});
			},
			
			selectItem(index){
				// 선택한 행의 데이터를 현재 데이터로 설정한다. 
				this.currentData = this.dataList[index];	
				this.index = index; // 현재 선택한 줄의 번호 등록 (나중에 갱신해야 되니까) 
			},
			
			answerItem(index) {
				const chatbotNo = this.dataList[index].chatbotNo;
				this.currentData.chatbotSuperNo = chatbotNo;
				
				this.superContent = this.dataList[index].chatbotContent; 
			},
			
			clearItem(){ // 입력창에 들어가있던 데이터를 초기화하는 메소드 
				this.superContent="",
				this.currentData = {
					chatbotNo:"",
					chatbotContent:"",
					chatbotSuperNo:"", 
				}
				this.index = -1; 
			},
			
			addItem(){
				let type;
				if(this.isInsertMode){ // 등록이라면
					type = "post";
				} else if(this.isEditMode){ // 수정이라면 
					type = "put";
				}
				
				if(!type) return; // type이 존재하지 않으면 return 
				
				axios({
					url:"${pageContext.request.contextPath}/rest/chatbot/", 
					method:type, // post or put (위에서 변수처리 한 것)
					data:this.currentData
				})
				.then((resp)=>{ // 실제 등록 / 수정된 결과가 resp.data에 들어있다. 
					// 등록이면 마지막에 추가, 수정이면 해당 위치를 갱신
					if(this.isInsertMode){
						// 서버에 들어가서 등록이 된 데이터가 resp.data에 추가가 되고 그 데이터를 DataList에 추가하는 구조 
						this.dataList.push(resp.data);	
						this.clearItem(); // 등록 후에 입력창에 있던 데이터 지우기 
						window.alert("등록이 완료되었습니다.");
					} else if(this.isEditMode) {
						this.dataList[this.index] = resp.data; // 특정 index의 데이터를 바꾸는 코드 
						this.clearItem(); 
						window.alert("수정이 완료되었습니다.");
					}
				});
			},
		},
		created(){
			axios({
				url:"${pageContext.request.contextPath}/rest/chatbot/",
				method:"get"
			})
			.then((resp) => {
				this.dataList.push(...resp.data);
			})
		},
	});
	app.mount("#app");
</script>

<%@include file="/WEB-INF/views/admin/template/footer.jsp" %>