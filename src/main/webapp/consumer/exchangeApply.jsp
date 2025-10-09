<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>교환 신청</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/checkout.css'/>">
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

	<!-- 페이지 헤더 -->
	<my:pageHeader hasButton="false" title="교환 신청" />

	<main class="main-container">
		<div class="main-content">
			<form method="post"
				action="${pageContext.request.contextPath}/store/exchangeApply"
				id="exchangeForm">

				<!-- Hidden Fields -->
				<input type="hidden" name="orderId" value="${orderItem.orderId}">
				<input type="hidden" name="orderItemId"
					value="${orderItem.orderItemId}"> <input type="hidden"
					id="shippingCost" name="shippingCost" value="0"> <input
					type="hidden" id="shippingCostPayer" name="shippingCostPayer"
					value="brand">

				<!-- ========== 주문 상품 정보 ========== -->
				<section class="shipping-info-section">
					<h2 class="section-title">주문 상품 정보</h2>
					<div class="product-table">
						<div class="table-header">
							<div class="col-product">상품정보</div>
							<div class="col-price">판매가</div>
							<div class="col-quantity">수량</div>
							<div class="col-total">구매가</div>
						</div>
						<div class="table-row">
							<div class="col-product">
								<div class="product-info">
									<!-- 상품 이미지 -->
									<c:choose>
										<c:when test="${not empty orderItem.thumbnailFileId}">
											<img
												src="${pageContext.request.contextPath}/image?fileId=${orderItem.thumbnailFileId}"
												alt="상품" class="product-image">
										</c:when>
										<c:otherwise>
											<img src="https://via.placeholder.com/80x80" alt="상품"
												class="product-image">
										</c:otherwise>
									</c:choose>
									<div class="product-details">
										<div class="brand">${orderItem.brandName}</div>
										<div class="product-name">${orderItem.productName}</div>
										<div class="product-option">현재 옵션:
											${orderItem.optionValue}</div>
									</div>
								</div>
							</div>
							<div class="col-price">
								<fmt:formatNumber value="${orderItem.unitPrice}" pattern="#,###" />
								원
							</div>
							<div class="col-quantity">${orderItem.quantity}</div>
							<div class="col-total">
								<fmt:formatNumber value="${orderItem.total}" pattern="#,###" />
								원
							</div>
						</div>
					</div>
				</section>

				<!-- ========== 교환 옵션 선택 ========== -->
				<section class="shipping-info-section">
					<h2 class="section-title">교환할 옵션 선택</h2>
					<div class="delivery-form">
						<div class="form-row">
							<div class="label">
								교환 옵션 <span class="required">*</span>
							</div>
							<div class="input-area">
								<select name="productOptionId" class="coupon-select" required>
									<option value="">옵션을 선택하세요</option>
									<c:forEach var="option" items="${availableOptions}">
										<option value="${option.optionId}"
											${option.optionId == orderItem.optionId ? 'disabled' : ''}>
											${option.optionValue} ${option.optionId == orderItem.optionId ? '(현재 구매 옵션)' : ''}
											<c:if test="${option.stockQty <= 0}"> - 품절</c:if>
										</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
				</section>

				<!-- ========== 교환 사유 ========== -->
				<section class="shipping-info-section">
					<h2 class="section-title">교환 사유</h2>
					<div class="delivery-form">
						<div class="form-row">
							<div class="label">
								사유 <span class="required">*</span>
							</div>
							<div class="input-area">
								<select name="reason" id="reason" class="coupon-select" required
									onchange="updateShippingCost()">
									<option value="">사유를 선택하세요</option>
									<option value="상품불량">상품불량</option>
									<option value="상품파손">상품파손</option>
									<option value="오배송">오배송</option>
									<option value="피부트러블">피부트러블</option>
								</select>
							</div>
						</div>
						<div class="form-row">
							<div class="label">상세 사유</div>
							<div class="input-area">
								<textarea name="detailReason" id="detailReason"
									placeholder="상세 사유를 입력해주세요 (선택사항)"
									style="width: 100%; min-height: 100px; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-family: inherit; resize: vertical;"></textarea>
							</div>
						</div>
					</div>
				</section>

				<!-- ========== 이미지 첨부 ========== -->
				<section class="shipping-info-section">
					<h2 class="section-title">이미지 첨부 (선택)</h2>
					<div class="delivery-form">
						<div class="image-upload-area">
							<div class="image-upload-item">
								<label>이미지 1</label>
								<input type="file" id="imageFile1" accept="image/*" onchange="uploadImage(this, 1)">
								<input type="hidden" id="image1FileId" name="image1FileId">
								<img id="preview1" style="display:none; max-width:100px; max-height:100px;">
								<span id="fileName1"></span>
							</div>
							<div class="image-upload-item">
								<label>이미지 2</label>
								<input type="file" id="imageFile2" accept="image/*" onchange="uploadImage(this, 2)">
								<input type="hidden" id="image2FileId" name="image2FileId">
								<img id="preview2" style="display:none; max-width:100px; max-height:100px;">
								<span id="fileName2"></span>
							</div>
							<div class="image-upload-item">
								<label>이미지 3</label>
								<input type="file" id="imageFile3" accept="image/*" onchange="uploadImage(this, 3)">
								<input type="hidden" id="image3FileId" name="image3FileId">
								<img id="preview3" style="display:none; max-width:100px; max-height:100px;">
								<span id="fileName3"></span>
							</div>
						</div>
					</div>
				</section>

				<!-- ========== 회수지 정보 ========== -->
				<section class="shipping-info-section">
					<h2 class="section-title">회수지 정보</h2>
					<div class="delivery-form">
						<!-- 주소 수정 안내 메시지 -->
						<div class="address-notice">
							<!-- 주소 수정 안내 메시지를 아예 써둘까 싶어요...여기서 수정해서 또 데이터 받기가 귀찮아서...-->
							주소 변경이 필요하신 경우, <a
								href="${pageContext.request.contextPath}/store/mypage/updateMember">회원정보
								수정</a>에서 변경해주세요.
						</div>

						<div class="form-row">
							<div class="label">보내는 분</div>
							<div class="input-area">
								<my:textInput type="readOnly" name="senderName"
									value="${member.name}" size="lg" />
							</div>
						</div>

						<div class="form-row">
							<div class="label">연락처</div>
							<div class="input-area">
								<my:textInput type="readOnly" name="senderPhone"
									value="${member.phone}" size="lg" />
							</div>
						</div>

						<div class="form-row address-row">
							<div class="label">주소</div>
							<div class="input-area address-row">
								<div class="address-input-group">
									<my:textInput type="readOnly" name="senderPostcode"
										value="${member.postcode}" size="sm" />
								</div>
								<div class="detail-address">
									<my:textInput type="readOnly" name="senderLine1"
										value="${member.line1}" size="sm" />
									<my:textInput type="readOnly" name="senderLine2"
										value="${member.line2}" size="sm" />
								</div>
							</div>
						</div>
					</div>
				</section>

				<!-- ========== 교환 배송지 정보 ========== -->
				<section class="shipping-info-section">
					<h2 class="section-title">교환 배송지 정보</h2>
					<div class="delivery-form">
						<!-- 주소 수정 안내 메시지를 아예 써둘까 싶어요...여기서 수정해서 또 데이터 받기가 귀찮아서...-->
						<div class="address-notice">
							주소 변경이 필요하신 경우, <a
								href="${pageContext.request.contextPath}/store/mypage/updateMember">회원정보
								수정</a>에서 변경해주세요.
						</div>

						<div class="form-row">
							<div class="label">받는 분</div>
							<div class="input-area">
								<my:textInput type="readOnly" name="receiverName"
									value="${member.name}" size="lg" />
							</div>
						</div>

						<div class="form-row">
							<div class="label">연락처</div>
							<div class="input-area">
								<my:textInput type="readOnly" name="receiverPhone"
									value="${member.phone}" size="lg" />
							</div>
						</div>

						<div class="form-row address-row">
							<div class="label">주소</div>
							<div class="input-area address-row">
								<div class="address-input-group">
									<my:textInput type="readOnly" name="receiverPostcode"
										value="${member.postcode}" size="sm" />
								</div>
								<div class="detail-address">
									<my:textInput type="readOnly" name="receiverLine1"
										value="${member.line1}" size="sm" />
									<my:textInput type="readOnly" name="receiverLine2"
										value="${member.line2}" size="sm" />
								</div>
							</div>
						</div>
					</div>
				</section>

				<!-- ========== 배송 요청사항 ========== -->
				<section class="delivery-request">
					<h2 class="section-title">배송 요청사항</h2>
					<div class="delivery-form">
						<div class="form-row delivery-message">
							<div class="label">배송메시지</div>
							<div class="input-area">
								<my:textInput id="note" name="note" placeholder="요청사항을 입력해주세요"
									type="default" size="md" state="default" />
							</div>
						</div>
					</div>
				</section>

				<!-- ========== 버튼 영역 ========== -->
				<div class="button-wrapper"
					style="display: flex; justify-content: center; gap: 10px; margin-top: 30px;">
					<button type="button" class="btn btn-outline btn-lg"
						onclick="history.back()">취소</button>
					<button type="submit" class="btn btn-primary btn-lg">교환 신청</button>
				</div>
			</form>
		</div>
	</main>

	<!-- 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>

	<script>
		// ========== 이미지 업로드 함수 ==========
		function uploadImage(inputElement, imageIndex) {
		    const file = inputElement.files[0];
		    
		    if (!file) return;
		    
		    if (!file.type.startsWith('image/')) {
		        alert('이미지 파일만 업로드 가능합니다.');
		        inputElement.value = '';
		        return;
		    }
		    
		    if (file.size > 5 * 1024 * 1024) {
		        alert('파일 크기는 5MB 이하만 가능합니다.');
		        inputElement.value = '';
		        return;
		    }
		    
		    const formData = new FormData();
		    formData.append('file', file);
		    
		    fetch('${pageContext.request.contextPath}/imageUpload', {
		        method: 'POST',
		        body: formData
		    })
		    .then(response => response.json())
		    .then(data => {
		        if (data.success) {
		            document.getElementById('image' + imageIndex + 'FileId').value = data.fileId;
		            const preview = document.getElementById('preview' + imageIndex);
		            preview.src = '/image?fileId=' + data.fileId;
		            preview.style.display = 'block';
		            const fileNameSpan = document.getElementById('fileName' + imageIndex);
		            if (fileNameSpan) {
		                fileNameSpan.textContent = data.fileName;
		            }
		        } else {
		            alert('파일 업로드 실패: ' + data.message);
		        }
		    })
		    .catch(error => {
		        console.error('업로드 에러:', error);
		        alert('파일 업로드 중 오류가 발생했습니다.');
		    });
		}
		

		// 폼 제출 전 검증
		document
				.getElementById('exchangeForm')
				.addEventListener(
						'submit',
						function(e) {
							const productOptionId = document
									.querySelector('select[name="productOptionId"]').value;
							const reason = document.getElementById('reason').value;

							if (!productOptionId) {
								e.preventDefault();
								alert('교환할 옵션을 선택해주세요.');
								return false;
							}

							if (!reason) {
								e.preventDefault();
								alert('교환 사유를 선택해주세요.');
								return false;
							}

							return confirm('교환 신청을 하시겠습니까?');
						});
	</script>
</body>
</html>