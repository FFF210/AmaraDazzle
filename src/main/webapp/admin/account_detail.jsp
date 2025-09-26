<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>
<title>정산내역 상세보기</title>

<link rel="stylesheet" href="./css/myApplications.css" />
<link rel="stylesheet" href="./css/accounts.css" />
<!-- 헤드부분 end -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<%@ include file="./main_content/account_detail_content.jsp"%>

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
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->


	<!-- 정보수정 & 로그아웃 팝업 -->
	<%@ include file="./modals/login_popup.jsp"%>
	<!-- 정보수정 & 로그아웃 팝업 end -->


	<script>
	  // 버튼 클릭 → 다이얼로그 열기
	  document.getElementById("openDialog").addEventListener("click", () => {
	    document.getElementById("pwDialog").classList.add("show");
	  });
	</script>
	<!-- JS부분 -->
	<%-- 	<%@ include file="../js/admin/common/adminHeader.js"%> --%>
	<!-- JS부분 end -->

</body>
</html>