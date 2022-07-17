<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="/WEB-INF/views/admin/template/header.jsp" %>

<div id="app" class="container">
	
	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<h1>평가 항목 관리</h1>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-6">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<h3>항목 추가 및 수정</h3>
					</div>
					<div class="row mt-4">
						<div class="col-4">
							<label>평가 분류</label>
						</div>
						<div class="col-8">
							<select class="form-select" v-model="currentData.ratingSortNo">
								<option value="1" selected>긍정 평가</option>
								<option value="0">부정 평가</option>
							</select>						
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-4">
							<label>평가 내용</label>
						</div>
						<div class="col-8">
							<input type="search" class="form-control" required v-model="currentData.ratingContent"></input>
							<div class="text-end mt-1" v-if="currentData.ratingContent.length <= 30">{{currentData.ratingContent.length}} / 30</div>
							<div class="text-end mt-1 text-danger" v-if="currentData.ratingContent.length > 30">{{currentData.ratingContent.length}} / 30</div>
						</div>
					</div>
					<div class="row mt-3">
						<button class="btn btn-primary" v-on:click="addItem">{{mode}}</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-6">
			<div class="card">
				<div class="card-body">
					<table class="table table-border">
						<thead>
							<tr>
								<th>평가 분류</th>
								<th style="width:50%;">평가 내용</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="(rating, index) in dataList" v-bind:key="index">
								<td v-if="rating.ratingSortNo == 0" class="text-danger">
									부정평가
								</td>
								<td v-if="rating.ratingSortNo == 1" class="text-primary">
									긍정평가
								</td>
								<td>{{rating.ratingContent}}</td>
								<td>
									<a href="#" v-on:click.prevent="selectItem(index);">선택</a>
									&nbsp|&nbsp
									<a href="#" v-on:click.prevent="deleteItem(index);">삭제</a>
								</td>
							</tr>
						</tbody>
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
				
				currentData:{
					ratingItemNo:"",
					ratingSortNo:"",
					ratingContent:"", 
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
				
				const ratingItemNo = this.dataList[index].ratingItemNo;
				
				axios({
					url:"${pageContext.request.contextPath}/rest/rating/"+ratingItemNo,
					method:"delete", 
				})
				.then(()=>{
					this.dataList.splice(index, 1);
				});
			},
			
			selectItem(index){
				this.currentData = this.dataList[index];	
				this.index = index;  
			},
			
			clearItem(){  
				this.currentData = {
					ratingItemNo:"",
					ratingSortNo:"",
					ratingContent:"", 
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
				
				if(!type) return;  
				
				axios({
					url:"${pageContext.request.contextPath}/rest/rating/", 
					method:type, 
					data:this.currentData
				})
				.then((resp)=>{ 
					if(this.isInsertMode){
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
				url:"${pageContext.request.contextPath}/rest/rating/",
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