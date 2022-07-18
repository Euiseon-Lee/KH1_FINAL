<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
		<style>
			.chatbotArea {
			  position: fixed; /* 이 부분을 고정 */
			  bottom: 10%; /* 하단에 여백 없이 */
			  z-index: 3000;
			  width: 5%; /* 가로 사이즈를 브라우저에 가득 채움 */
			  right: 10%;
			}
		</style>
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
