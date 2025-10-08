<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반품 신청</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/checkout.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
</head>
<body>
	<%@ include file="/consumer/header.jsp"%>
	
	<main class="main-container">
		<div class="main-content">
			<form action="${pageContext.request.contextPath}/store/exchangeApply" method="post">
				
				<!-- 상품 정보 (읽기전용) -->
				<section class="order-products">
					<h2 class="section-title">교환 상품</h2>
					<div class="product-table">
						<div class="table-header">
							<div class="col-product">상품정보</div>
							<div class="col-price">판매가</div>
							<div class="col-quantity">수량</div>
						</div>
						<div class="table-row">
							<div class="col-product">
								<div class="product-info">
									<img src="placeholder" class="product-image">
									<div class="product-details">
										<div class="brand">[브랜드]</div>
										<div class="product-name">[상품명]</div>
									</div>
								</div>
							</div>
							<div class="col-price">30,000원</div>
							<div class="col-quantity">1</div>
						</div>
					</div>
				</section>

				<!-- 교환 사유 -->
				<section class="shipping-info-section">
					<h2 class="section-title">회수지 정보</h2>
					<div class="delivery-form">
						<div class="form-row">
							<div class="label">보내는 분 <span class="required">*</span></div>
							<div class="input-area">
								<my:textInput name="name" value="${member.name}" size="lg" />
							</div>
						</div>
						
						<div class="form-row phone-row">
							<div class="label">연락처 <span class="required">*</span></div>
							<div class="input-area">
								<div class="phone-group">
									<my:textInput name="phone1" value="" size="sm" />
									<span class="dash">-</span>
									<my:textInput name="phone2" value="" size="sm" />
									<span class="dash">-</span>
									<my:textInput name="phone3" value="" size="sm" />
								</div>
							</div>
						</div>
						
						<!-- 주소 동일하게 -->
					</div>
				</section>

				<div class="button-wrapper">
					<button type="submit" class="btn btn-primary btn-lg">교환 신청하기</button>
				</div>
			</form>
		</div>
	</main>
	
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>