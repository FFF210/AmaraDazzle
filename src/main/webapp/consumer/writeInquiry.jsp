<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<link rel="stylesheet" href="./tagcss/reset.css" />
<link rel="stylesheet" href="./consumer/css/header.css" />
<link rel="stylesheet" href="./consumer/css/footer.css" />
<link rel="stylesheet" href="./tagcss/pageHeader.css" />
<link rel="stylesheet" href="./consumer/css/writeInquiry.css" />
<link rel="stylesheet" href="./tagcss/selectbox.css" />
<link rel="stylesheet" href="./tagcss/textArea.css" />
<link rel="stylesheet" href="./tagcss/textInput.css" />
<link rel="stylesheet" href="./tagcss/imageBtn.css" />


</head>
<body>

	<%-- 헤더 --%>
	<%@ include file="/consumer/header.jsp"%>

	<my:pageHeader hasButton="false" title="고객센터" description="무엇을 도와드릴까요" />

	<!-- 문의 작성 페이지 -->
	<main class="main-content">
		<div class="inquiry-type">
			<label>문의 유형</label>
			<my:selectbox size="lg" items="주문,결제,취소,환불,교환,배송,이벤트,사이트 이용 오류/개선" />
		</div>

		<div class="order-number">
			<label>주문 번호</label>
			<my:textInput id="loginId" name="loginId" placeholder="아이디를 입력하세요"
				type="default" size="lg" state="default" />
		</div>

		<div class="write-form">
			<label>내용</label>
			<my:textArea name="desc" placeholder="문의 내용을 입력하세요" />
		</div>

		<div class="upload-image">
			<my:imageBtn name="upload1" />
		</div>

		<div class="action-button">
			<button class="btn btn-outline btn-lg">취소</button>
			<button class="btn btn-primary btn-lg">등록</button>
		</div>

	</main>


	<%-- footer --%>
	<%@ include file="/consumer/footer.jsp"%>

	<script>
      document.addEventListener("selectChanged", (e) => {
        console.log("선택된 값:", e.detail.value); // 실제 값
        console.log("선택된 텍스트:", e.detail.text); // 표시되는 텍스트
      });
    </script>

</body>
</html>