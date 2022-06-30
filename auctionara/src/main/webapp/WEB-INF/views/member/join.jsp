<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/template/header.jsp" %>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<script>
	$(document).ready(function(){            
	    var now = new Date();
	    var year = now.getFullYear();
	    var mon = (now.getMonth() + 1) > 9 ? ''+(now.getMonth() + 1) : '0'+(now.getMonth() + 1); 
	    var day = (now.getDate()) > 9 ? ''+(now.getDate()) : '0'+(now.getDate());           
	    // 연도 selectbox             
	    for(var i = 1900 ; i <= year ; i++) {
	        $('#year').append('<option value="' + i + '">' + i + '년</option>');    
	    }
	
	    // 월별 selectbox          
	    for(var i=1; i <= 12; i++) {
	        var mm = i > 9 ? i : "0"+i ;            
	        $('#month').append('<option value="' + mm + '">' + mm + '월</option>');    
	    }
	    
	    // 일별 selectbox
	    for(var i=1; i <= 31; i++) {
	        var dd = i > 9 ? i : "0"+i ;            
	        $('#day').append('<option value="' + dd + '">' + dd+ '일</option>');    
	    }
	    $("#year > option[value="+year+"]").attr("selected", "true");        
	    $("#month > option[value="+mon+"]").attr("selected", "true");    
	    $("#day > option[value="+day+"]").attr("selected", "true");       
	  
	})
</script>

<form action="join" method="post">
	
	<div class="container-fluid">
	
		<div class="row">
			<h1>점보트론: 회원 가입</h1>
		</div>
		
		<div class="row">
			<div>
				<label> 이메일
					<input type="email" name="memberEmail" autocomplete="off" placeholder="email">
				</label>
			</div>
			<div>
				<button>인증하기</button>
			</div>
		</div>
		
		<div class="row">
			<div>
				<label> 비밀번호
					<input type="password" name="memberPw" autocomplete="off" placeholder="password">
				</label>
			</div>
			<div>
				<label> 비밀번호 확인
					<input type="password" name="memberPwCheck" autocomplete="off" placeholder="pwCheck">
				</label>
			</div>

		</div>
		
		<div class="row">
			<label> 이름
				<input type="text" name="memberName" autocomplete="off" placeholder="name">
			</label>
		</div>		

		<div class="row">
			<label> 성별
				<select name="memberSex">
					<option selected>==선택==</option>
					<option value="f">여자</option>
					<option value="m">남자</option>
				</select>
			</label>
		</div>	

		<div class="row">
			<label> 생년월일
				<select name="yy" id="year"></select>
				<select name="mm" id="month"></select>
				<select name="dd" id="day"></select>
			</label>
		</div>
		
		<div class="row">
			<label> 닉네임
				<input type="text" name="memberNick" autocomplete="off" placeholder="nickname">
			</label>
		</div>
		
		<div class="row">
	    	<label>프로필
	    		<input type="file" name="attachmentNo">
	    	</label>
	    </div>
		
		<div class="row">
			<label>
				<input type="checkbox">전체 동의		
			</label>
		</div>
		
		<div class="row">
			<button type="submit">회원가입</button>
		</div>
	
	</div>

</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
