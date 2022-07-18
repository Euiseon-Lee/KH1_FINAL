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
						<textarea class="form-control" required v-model="currentData.chatbotContent">{{currentData.chatbotContent}}</textarea>
						<div class="text-end mt-1" v-if="currentData.chatbotContent.length <= 100">{{currentData.chatbotContent.length}} / 100</div>
						<div class="text-end mt-1 text-danger" v-if="currentData.chatbotContent.length > 100">{{currentData.chatbotContent.length}} / 100</div>
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
				
				count:0, 
				
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
				
				for(var i = 0; i < this.dataList.length; i++) {
					if(this.dataList[i].chatbotSuperNo == chatbotNo) {
						this.count++; 
					}
				}
				
				console.log(this.count);
				
				axios({
					url:"${pageContext.request.contextPath}/rest/chatbot/"+chatbotNo,
					method:"delete",
				})
				.then(()=>{
					if(this.count > 0) {
						this.dataList.splice(index, this.count+1);
					} else {
						this.dataList.splice(index, 1);
					}
				});
			},
			
			selectItem(index){
				 
				this.currentData = this.dataList[index];	
				this.index = index; 
			},
			
			answerItem(index) {
				const chatbotNo = this.dataList[index].chatbotNo;
				this.currentData.chatbotSuperNo = chatbotNo;
				
				this.superContent = this.dataList[index].chatbotContent; 
			},
			
			clearItem(){  
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
				if(this.isInsertMode){ 
					type = "post";
				} else if(this.isEditMode){  
					type = "put";
				}
				
				if(!type) {
					return;  
				}
				
				axios({
					url:"${pageContext.request.contextPath}/rest/chatbot/", 
					method:type, 
					data:this.currentData
				})
				.then((resp)=>{  
					if(this.isInsertMode){
						if(this.currentData.chatbotContent == "") {
							return;
						}
						this.dataList.push(resp.data);	
						this.clearItem();  
						window.alert("등록이 완료되었습니다.");
					} else if(this.isEditMode) {
						this.dataList[this.index] = resp.data;  
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