<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="appp">
	<button type="button" class="btn btn-primary rounded-circle chatbotArea" data-bs-toggle="modal" data-bs-target="#chatbotModal" @click="question()">
		<i class="fa-solid fa-robot fa-2x"></i>
	</button>
	<div class="modal fade" id="chatbotModal" tabindex="-1" aria-labelledby="chatbotModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="chatbotModalLabel">&#129302; 도움을 드려요</h5>
					<button type="button" class="btn-close close" data-bs-dismiss="modal" @click="end()">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div v-for="(chatbotContent, index) in chatbotContentDto" class="chatbotContentDto" :key="index">
						<button class="btn btn-primary rounded mt-2 mx-2 text-start" @click="requestion(chatbotContent.chatbotNo)">{{chatbotContent.chatbotContent}}</button>
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
<script>
const appp = Vue.createApp({
	data(){
		return {
			chatbotContentDto: [],
			chatbotNo: 0,
		};
	},
	methods:{
		question(){
			this.chatbotNo = 0;
			axios({
				url: "${pageContext.request.contextPath}/rest/chatbot/list/" + this.chatbotNo,
				method: "get"
			}).then(resp=>{
				this.chatbotContentDto = resp.data;
				});
			},
			requestion(chatbotNo){
				this.chatbotNo = chatbotNo;
				axios({
					url: "${pageContext.request.contextPath}/rest/chatbot/list/"+this.chatbotNo,
					method: "get",
				}).then(resp=>{
					this.chatbotContentDto = resp.data;
				});
			},
			end(){
				this.chatbotNo = 0;
			},
		},
	});
	appp.mount("#appp");
</script>