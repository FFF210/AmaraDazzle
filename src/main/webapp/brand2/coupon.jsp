<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 쿠폰 발급</title>

<!-- Pretendard 폰트 (CDN) -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">

<!-- flatpickr 기본 테마 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/light.css">

<!-- 한글화 & 커스텀 CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/custom-flatpickr.css">
	
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
	
<link rel="stylesheet" href="./css/formLayout.css" />

<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/textArea.css" />
<link rel="stylesheet" href="../tagcss/uploader.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />

<style>
.breadcrumb {
	margin-top: 8px;
	margin-left: 24px;
}

.CWrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: calc(100vh - 76px);
	overflow: hidden; /* 스크롤 강제 차단 */
}

.CContainer {
	background: #fff;
	padding: 40px;
	border-radius: 10px;
	text-align: center;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	margin: 0 auto;
}

h2 {
	margin-bottom: 15px;
	font-size: 20px;
	color: #333;
}

.label {
	font-size: 14px;
	font-weight: bold;
	color: #333;
	margin-bottom: 6px;
}

.grid {
	display: grid;
}

.inline {
	display: flex;
	align-items: center;
	gap: 6px;
}

.muted {
	color: #666;
	font-size: 13px;
}
</style>
</head>
<body>
	<my:layout>
		<my:breadcrumb items="쿠폰 관리:/brand2/coupon " />
		<div class="CWrapper">
			<div class="CContainer">

				<h2>브랜드 쿠폰 발급</h2>

				<!-- ===== 쿠폰 발급 영역 ===== -->
				<div class="coupon-section" style="margin-top:20px; text-align:left;">
					<div class="label">쿠폰 설정</div>
					<div>
						<div class="coupon-box" id="couponBox">
							<!-- grid -->
							<div class="grid"
								style="grid-template-columns: 140px 1fr; gap: 10px 12px">

								<div class="label req">쿠폰명</div>
								<div>
									<my:textInput id="couponName" name="cname"
										placeholder="쿠폰명을 입력하세요." type="default" size="sm"
										state="default" />
								</div>

								<div class="label req">기간</div>
								<div class="inline date-row">
									<input id="couponFrom" name="startDate" type="date"> 
									<span>~</span>
									<input id="couponTo" name="endDate" type="date">
								</div>

								<div class="label req">최소주문</div>
								<div class="inline">
									<div class="text-input-wrapper size--sm state--default">
										<div class="text-input-inner default">
											<input id="couponMin" name="amountCondition" type="number"
												min="0" step="100" placeholder="0" class="text-input">
											<span class="muted">원 이상 구매 시</span>
										</div>
									</div>
								</div>

								<div class="label req">할인</div>
								<div class="inline">
									<div class="text-input-wrapper size--sm state--default">
										<div class="text-input-inner default">
											<input id="couponAmount" name="amount" type="number" min="0"
												step="100" placeholder="0" class="text-input">
											<span class="muted">원 할인</span>
										</div>
									</div>
								</div>
							</div>

							<!-- 쿠폰 발급 버튼 -->
							<div style="margin-top:20px; text-align:right;">
								<button type="button" class="btn btn-primary btn-md">
									쿠폰 발급하기
								</button>
							</div>
						</div>
					</div>
				</div>
				<!-- =========================== -->

			</div>
		</div>
	</my:layout>
</body>
</html>
