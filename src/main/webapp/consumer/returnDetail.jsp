<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>반품 상세정보</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/orderDetail.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/mypageMenu.css'/>">
</head>
<body>
	<%-- 헤더 --%>
	<%@ include file="/consumer/header.jsp"%>

	<div class="page-wrap">
		<div class="page-grid">
			<%-- 좌측 마이페이지 메뉴 --%>
			<%@ include file="/consumer/mypageMenu.jsp"%>

			<main class="content">
				<%-- 반품 상세정보 --%>
				<section class="section">
					<h1 class="page-title">반품 상세정보</h1>
					<div class="order-info">
						<div class="info-item">
							<span class="label">신청일자:</span> <span class="value"> <fmt:formatDate
									value="${returns.updatedAt}" pattern="yyyy-MM-dd" />
							</span>
						</div>
						<div class="info-item">
							<span class="label">주문번호:</span> <span class="value order-number">${returns.orderCode}</span>
						</div>
					</div>
				</section>

				<%-- ===== 반품 상품 ===== --%>
				<section class="section">
					<h2 class="section-title">반품 상품</h2>

					<div class="table-wrapper">
						<table class="table">
							<thead>
								<tr>
									<th>상품명</th>
									<th>판매가</th>
									<th>수량</th>
									<th>구매가</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<div class="product-info">
											<span class="brand">${item.brand_name}</span><br> <span
												class="product-name">${item.name}</span>
										</div>
									</td>
									<td>${item.price}</td>
									<td>1</td>
									<td class="price-highlight">${item.price}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</section>

				<%-- ===== 반품 사유 ===== --%>
				<section class="section">
					<h2 class="section-title">반품 사유</h2>
					<div class="form-rows">
						<div class="row">
							<div class="label">사유</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly" name="reason"
									value="${returns.reason}" size="lg" />
							</div>
						</div>
						<div class="row">
							<div class="label">배송비</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly" name="shippingCost"
									value="${returns.shippingCost}원" size="lg" />
							</div>
						</div>
						<div class="row">
							<div class="label">배송비 부담</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly" name="shippingCostPayer"
									value="${returns.shippingCostPayer == 'member' ? '구매자' : '판매자'}"
									size="lg" />
							</div>
						</div>
					</div>
				</section>

				<%-- ===== 회수지 정보 ===== --%>
				<section class="section od-ship">
					<h2 class="section-title">회수지 정보</h2>

					<div class="form-rows">
						<!-- 보내는 분 -->
						<div class="row">
							<div class="label">보내는 분</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly" name="name" value="${member.name}"
									size="lg" />
							</div>
						</div>

						<!-- 주소 -->
						<div class="row">
							<div class="label">주소</div>
							<div class="addr">
								<div class="addr-row">
									<my:textInput type="readOnly" name="postcode"
										value="(${member.postcode})" size="lg" />
								</div>
								<div class="addr-row addr-grid-2">
									<my:textInput type="readOnly" name="mainAddress"
										value="${member.line1}" size="lg" />
									<my:textInput type="readOnly" name="detailAddress"
										value="${member.line2}" size="lg" />
								</div>
							</div>
						</div>

						<!-- 연락처 -->
						<div class="row">
							<div class="label">연락처</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly" name="phoneNumber"
									value="${member.phone}" size="lg" />
							</div>
						</div>

						<!-- 회수 택배사 -->
						<div class="row">
							<div class="label">회수 택배사</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly" name="returnCarrierName"
									value="${returns.returnCarrierName}" size="lg" />
							</div>
						</div>

						<!-- 회수 운송장 번호 -->
						<div class="row">
							<div class="label">회수 운송장 번호</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly" name="returnTrackingNo"
									value="${returns.returnTrackingNo}" size="lg" />
							</div>
						</div>
					</div>
				</section>

				<%-- ===== 환불 정보 ===== --%>
				<section class="section od-payment">
					<h2 class="section-title">환불 정보</h2>

					<div class="form-rows">
						<div class="row">
							<div class="label">결제 수단</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly" value="토스 페이먼츠" size="lg" />
							</div>
						</div>

						<div class="row">
							<div class="label">환불 방법</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly" value="결제하신 수단으로 자동 환불됩니다."
									size="lg" />
							</div>
						</div>

						<div class="row">
							<div class="label">환불 예정일</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly" value="환불 승인 후 3~5 영업일 소요"
									size="lg" />
							</div>
						</div>
					</div>
				</section>

				<div class="page-actions">
					<a
						href="${pageContext.request.contextPath}/store/cancelExchangeReturnList"
						class="btn-primary">목록</a>
				</div>
			</main>
		</div>
	</div>

	<%-- 푸터 --%>
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>