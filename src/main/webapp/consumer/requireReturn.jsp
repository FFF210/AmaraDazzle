<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>반품신청</title>

<!-- Noto Sans -->
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap"
	rel="stylesheet">

<!-- Page CSS -->
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/requireExchange.css?ver=2'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textArea.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/selectbox.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/imageBtn.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">

</head>
<body>
	<header class="site-header">
		<%@ include file="/consumer/header.jsp"%>
	</header>

	<main class="exc_container">
		<section class="exchange_container">
			<h1 class="page-title">반품상품 선택</h1>
			<div class="exchange_main">
				<div class="pd_table">
					<h3>상품 정보</h3>
					<div class="table-wrapper">
						<table class="table">
							<thead>
								<colspan>
								<col style="width: 50%">
								<col style="width: 20%">
								<col style="width: 10%">
								<col style="width: 20%">
								</colspan>
								<tr>
									<th>상품</th>
									<th>구매가</th>
									<th>수량</th>
									<th>구매가</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<div class="pd_info">
											<div class="pd_img">
												<img src="">
											</div>
											<div class="pd_name">
												<div>밀잇</div>
												<div>밀잇 식단관리 단백질쉐이크 40g 5종 택1</div>
											</div>
										</div>
									</td>
									<td>39,000원</td>
									<td>1</td>
									<td>39,000원</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="exchange_reason">
					<h3>반품사유 선택</h3>
					<div class="reason_box">
						<div class="r_select">
							<my:selectbox size="md" items="추천순,인기순,최신순,낮은가격순,높은가격순"
								initial="정렬" />
						</div>
						<div class="r_write">
							<%-- 							<my:textArea name="desc" placeholder="내용을 입력하세요" /> --%>
							<textarea placeholder="사유를 입력해주세요"></textarea>
						</div>
						<div class="img_att">
							<my:imageBtn name="upload1" />
							<my:imageBtn name="upload1" />
							<my:imageBtn name="upload1" />

						</div>
					</div>

				</div>

				<div class="exchange_reInfo">
					<h3>회수지 정보</h3>
					<div class="reInfo_box">
						<div class="reInfo_select">
							<h5>
								배송지 선택<span class="reqired">&nbsp;*</span>
							</h5>
							<my:selectbox size="md" items="추천순,인기순,최신순,낮은가격순,높은가격순"
								initial="배송지명을 선택하세요" />
						</div>
						<div class="reInfo_write">
							<h5>
								보내는 분 <span class="reqired">&nbsp;*</span>
							</h5>
							<div>
								<my:textInput id="" name="" placeholder="보내는 분의 성함을 입력해주세요"
									type="default" size="sm" state="default" />
							</div>
						</div>

						<div class="reInfo_phone">
							<h5>
								연락처 1 <span class="reqired">&nbsp;*</span>
							</h5>
							<my:selectbox size="md" items="010,011,016,017,018" initial="010" />
							<span class="nbsp">-</span>
							<div class="phone_no">
								<my:textInput id="" name="" type="default" size="sm"
									state="default" />
							</div>
							<span class="nbsp">-</span>
							<div class="phone_no">
								<my:textInput id="" name="" type="default" size="sm"
									state="default" />
							</div>
						</div>

						<div class="reInfo_phone">
							<h5>연락처 2</h5>
							<my:selectbox size="md" items="010,011,016,017,018" initial="010" />
							<span class="nbsp">-</span>
							<div class="phone_no">
								<my:textInput id="" name="" type="default" size="sm"
									state="default" />
							</div>
							<span class="nbsp">-</span>
							<div class="phone_no">
								<my:textInput id="" name="" type="default" size="sm"
									state="default" />
							</div>
						</div>
						<div class="reInfo_addr">
							<h5>
								주소 <span class="reqired"> &nbsp;*</span>
							</h5>
							<div>
								<div class="addr_btn">
									<div>
										<my:textInput id="" name="" type="readOnly" size="sm"
											state="default" />
									</div>
									<div>
										<button class="btn btn-outline btn-md">우편번호 찾기</button>
									</div>
								</div>
								<div class="addr_content">
									<my:textInput id="" name="" type="readOnly" size="sm"
										state="default" />
									<my:textInput id="" name="" type="default"
										placeholder="상세주소를 입력하세요" size="sm" state="default" />
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="exchange_btn">
					<button class="btn btn-outline btn-md">이전</button>
					<button class="btn btn-primary btn-md">반품 신청하기</button>
				</div>
			</div>

		</section>

	</main>

	<footer class="site-footer">
		<%@ include file="/consumer/footer.jsp"%>
	</footer>

	<!-- Page JS -->
	<script src="<c:url value='/js/header.js'/>"></script>
	<script src="<c:url value='/js/requireExchange.js'/>"></script>

	<script>
      document.addEventListener("selectChanged", (e) => {
        console.log("선택된 값:", e.detail.value); // 실제 값
        console.log("선택된 텍스트:", e.detail.text); // 표시되는 텍스트
      });
    </script>
</body>
</html>
