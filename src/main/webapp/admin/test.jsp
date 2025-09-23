<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<%@ include file="./common/config.jsp"%>
<body>

	<my:layout>
		<button type="button" class="btn btn-primary btn-md" id="openDialog">다이얼로그
			오픈</button>


		<my:dialog id="pwDialog" title="비밀번호 변경" message="새로운 비밀번호를 입력하세요."
			type="form" buttons="취소,저장" />

		<my:dialog id="formDialog" title="비밀번호 변경" type="form" buttons="취소,저장">
			<div class="form-group">
				<label>새로운 비밀번호</label> <input type="password" />
			</div>
			<div class="form-group">
				<label>비밀번호 확인</label> <input type="password" />
			</div>
		</my:dialog>
	</my:layout>

	<script>
	  // 버튼 클릭 → 다이얼로그 열기
	  document.getElementById("openDialog").addEventListener("click", () => {
	    document.getElementById("pwDialog").classList.add("show");
	  });
	</script>

</body>
</html>