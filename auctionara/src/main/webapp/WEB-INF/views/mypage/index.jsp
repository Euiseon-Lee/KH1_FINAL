<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/template/header.jsp" %>

<div id="app">


	<div class="container d-flex">
	<!-- 사이드바 -->

		<div class="row col-3 mt-4">
			<ul class="nav flex-column text-center">
			  <li class="nav-item border-bottom">
			  	<h4>
			  		<a href="${root}/mypage/" class="nav-link btn-outline-secondary">마이페이지</a>
			  	</h4>
			  </li>
			  <li class="nav-item border-bottom">
			  	<a href="${root}/mypage/info" class="nav-link btn-outline-info">정보수정</a>
			  </li>
			  <li class="nav-item border-bottom">
			    <a href="${root}/mypage/exit" class="nav-link btn-outline-info">회원탈퇴</a>
			  </li>
			  <li class="nav-item border-bottom">
			    <a href="${root}/mypage/auction_history" class="nav-link btn-outline-info">경매내역</a>
			  </li>
			  <li class="nav-item border-bottom">
			    <a href="${root}/mypage/pay_history" class="nav-link btn-outline-info">결제완료내역</a>
			  </li>
			  <li class="nav-item border-bottom">
			    <a href="${root}/mypage/cash_log" class="nav-link btn-outline-info">포인트/현금화</a>
			  </li>
			</ul>
		</div>
		
	<!-- 본문 -->
	<div class="row flex-fill">
		<div class="row col-4 m-3 d-inline">
			<img src="${pageContext.request.contextPath}${profileUrl}"
					class="img-thumbnail center-block">
		</div>
		
		<div class="row col-4 m-5 d-inline">
			<div>${memberDto.memberNick}</div>
			<div>${memberDto.memberEmail}</div>
			
			<table class="table-borderless table-responsive table-sm mt-3">
				<tr>
					<th class="text-left">보유 포인트</th>
					<td class="text-right">
						<a href="${root}/mypage/cash_log">${memberDto.memberHoldingPoints}p ></a>
					</td>
				</tr>
				<tr>
					<th class="text-left">경매/낙찰 횟수</th>
					<td class="text-right">
						<a href="${root}/mypage/auction_history"></a>
					
					</td>
				</tr>
				<tr>
					<th class="text-left">경고횟수</th>
					<td class="text-right">
						${memberDto.memberRedCount}회 >
					</td>
				</tr>

				
	
	
			</table>			
			
		</div>
		
		

		
	
	</div>



</div>





    <!-- vue js도 lazy loading을 사용한다 -->
    <script src="https://unpkg.com/vue@next"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script> 
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script>
        //div[id=app]을 제어할 수 있는 Vue instance를 생성
        const app = Vue.createApp({
            //data 영역: 화면을 구현하는데 필요한 데이터를 작성해둔다
            //만드는 규칙이 정해져 있음
            data(){
                return{

                };
            },


            //computed: data를 기반으로 하여 실시간 계산이 필요한 경우 작성
            // <주의> 3줄보다 많다면 사용하지 않는 것을 권장
            // 복잡한 계산 시 성능저하가 발생하기 때문이다
            computed: {

            },


            //methods: 애플리케이션 내에서 언제든 호출 가능한 코드 집합이 필요한 경우 작성
            //해당 애플리케이션 내에서 코드를 적을 때 this를 빼먹게 되면 에러가 발생하니 주의하도록 한다
            methods:{

            },


            //watch: 특정 data를 감시하여 연계코드를 실행하기 위해 작성
            watch:{


            },


            //Lifcycle에 따른 시점 구분     => created, mounted, updated
            beforeCreate(){         //데이터 및 구성요소 초기화 전 => 사용할 일이 많지 않다

            },

            created(){              
                //데이터 및 구성요소 초기화 후
                //data에 접근 가능하므로 ajax를 여기서 사용하여 초기 데이터를 불러온다
 
            },

            beforeMount(){
                //데이터가 화면에 마운트 되기 전 (== view 생성 전)
  

            },

            mounted(){
                //데이터가 화면에 마운트 된 후 (== view 생성 후)
                //시작하자마자 무언가를 처리해야할 때 사용
                //window.onload 또는 $(function(){})과 같은 효과를 낸다

            },

            beforeUpdate(){

            },

            updated(){

            },

            destoryed(){
                //벌려놓은 일을 정리할 때 사용, 우리는 사용하지 않는다

            },
        });
        app.mount("#app");

    </script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>