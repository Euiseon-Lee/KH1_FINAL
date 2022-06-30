<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>회원 제재 입력 테스트</h1>

<form method="post">
	<input type="hidden" name="memberNo" value="${memberNo }">
	
	<div>
		<label>제재 유형</label>
		<select name="restrictionType">
			<option value="비매너 채팅">비매너 채팅</option>
			<option value="허위 매물 작성">허위 매물 작성</option>
			<option value="기타">기타</option>
		</select>
	</div>
	<div>
		<label>제재 이유</label>
		<input type="text" name="restrictionReason">
	</div>
	<div>
		<input type="submit">
	</div>
</form>