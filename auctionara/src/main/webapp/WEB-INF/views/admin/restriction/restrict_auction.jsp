<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="/WEB-INF/views/admin/template/header.jsp" %>

<script>
	$(function(){
		$(".regist").click(function(e){
			var val = $("#restrictReason").val().length;
			
			if(val <= 0) {
				alert("제재 내용을 작성해주세요.");
				e.preventDefault(e);
			} else {
				var result = confirm("해당 회원 제재 내역을 등록하시겠습니까?");
				
				if(!result) {
					e.preventDefault(e);	
				}
			}
		});
	});
</script>

<div id="app" class="container">
	
	<div class="card">
		<div class="card-body">
			<div class="row p-2 mt-2">
				<h1>회원 제재 등록</h1>
			</div>
		</div>
	</div>
	
	<div class="card">
		<div class="card-body">
			<form method="post">
				<input type="hidden" name="memberNo" value="${memberNo }">
				<input type="hidden" name="auctionReportNo" value="${auctionReportNo}">
				
				<div class="row p-2 mt-2">
					<div class="col">
						<label>제재 유형</label>
					</div>
					<div class="col">
						<select name="restrictionType" class="form-select">
							<option value="비매너 채팅">비매너 채팅</option>
							<option value="허위 매물 작성" selected>허위 매물 작성</option>
							<option value="기타">기타</option>
						</select>
					</div>
				</div>
				
				<div class="row p-2 mt-2">
					<div class="col">
						<label>제재 이유</label>
					</div>
					<div class="col">
						<textarea type="text" name="restrictionReason" class="form-control" v-model="restrictReason" id="restrictReason"></textarea>
						<div class="text-end mt-1" v-if="restrictReason.length <= 100">{{restrictReason.length}} / 100</div>
						<div class="text-end mt-1 text-danger" v-if="restrictReason.length > 100">{{restrictReason.length}} / 100</div>
					</div>
				</div>
				
				<div class="row p-2 mt-2">
					<input type="submit" class="btn btn-primary regist" value="등록">
				</div>
			</form>
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
				restrictReason:"",
			};
		},
		computed:{

		},
		methods:{
			
		},
		created(){

		},
	});
	app.mount("#app");
</script>

<%@include file="/WEB-INF/views/admin/template/footer.jsp" %>