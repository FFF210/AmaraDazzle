<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>반품 신청</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/checkout.css'/>">
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

	<!-- 페이지 헤더 -->
	<my:pageHeader hasButton="false" title="반품 신청" />

	<main class="main-container">
		<div class="main-content">
			<form method="post" action="${pageContext.request.contextPath}/store/returnApply" id="returnForm">
				
				<!-- Hidden Fields -->
				<input type="hidden" name="orderItemId" value="${orderItem.orderItemId}">
				<input type="hidden" id="shippingCost" name="shippingCost" value="0">
				<input type="hidden" id="shippingCostPayer" name="shippingCostPayer" value="brand">
				
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
											<img src="${pageContext.request.contextPath}/image?fileId=${orderItem.thumbnailFileId}" 
												 alt="상품" class="product-image">
										</c:when>
										<c:otherwise>
											<img src="https://via.placeholder.com/80x80" alt="상품" class="product-image">
										</c:otherwise>
									</c:choose>
									<div class="product-details">
										<div class="brand">${orderItem.brandName}</div>
										<div class="product-name">${orderItem.productName}</div>
										<c:if test="${not empty orderItem.optionValue}">
											<div class="product-option">옵션: ${orderItem.optionValue}</div>
										</c:if>
									</div>
								</div>
							</div>
							<div class="col-price"><fmt:formatNumber value="${orderItem.unitPrice}" pattern="#,###"/>원</div>
							<div class="col-quantity">${orderItem.quantity}</div>
							<div class="col-total"><fmt:formatNumber value="${orderItem.total}" pattern="#,###"/>원</div>
						</div>
					</div>
				</section>

				<!-- ========== 반품 사유 ========== -->
				<section class="shipping-info-section">
					<h2 class="section-title">반품 사유</h2>
					<div class="delivery-form">
						<div class="form-row">
							<div class="label">사유 <span class="required">*</span></div>
							<div class="input-area">
								<select name="reason" id="reason" class="coupon-select" required onchange="updateShippingCost()">
									<option value="">사유를 선택하세요</option>
									<option value="고객단순변심">고객단순변심</option>
									<option value="상품불만족">상품불만족</option>
									<option value="피부트러블">피부트러블</option>
									<option value="상품불량">상품불량</option>
									<option value="주문오류">주문오류</option>
									<option value="상품파손">상품파손</option>
									<option value="오배송">오배송</option>
								</select>
							</div>
						</div>
						
						<div class="form-row">
							<div class="label">상세 사유</div>
							<div class="input-area">
								<textarea name="detailReason" id="detailReason" 
										  placeholder="상세한 사유를 입력해주세요"
										  style="width: 100%; min-height: 100px; padding: 10px; 
												 border: 1px solid #ddd; border-radius: 4px; 
												 font-family: inherit; resize: vertical;"></textarea>
							</div>
						</div>
						
						<div class="form-row">
							<div class="label">배송비</div>
							<div class="input-area">
								<div class="shipping-cost-display" id="shippingCostDisplay" 
									 style="padding: 10px; background: #f8f9fa; border-radius: 4px; font-weight: 500;">
									사유를 선택하면 배송비가 표시됩니다. 배송비는 착불로 부과됩니다.
								</div>
								<div class="shipping-notice" id="shippingNotice" 
									 style="display:none; margin-top: 10px; padding: 10px; border-radius: 4px; font-size: 13px;">
								</div>
							</div>
						</div>
					</div>
				</section>

				<!-- ========== 이미지 첨부 (주석 처리) ========== -->
				<!-- 
				<section class="shipping-info-section">
					<h2 class="section-title">이미지 첨부 (선택)</h2>
					<div class="delivery-form">
						<div class="image-upload-area" style="display: flex; gap: 15px;">
							<div class="image-upload-item">
								<label style="display: block; margin-bottom: 5px; font-weight: 500;">이미지 1</label>
								<input type="file" id="imageFile1" accept="image/*" onchange="uploadImage(this, 1)" style="width: 100%;">
								<input type="hidden" id="image1FileId" name="image1FileId">
								<img id="preview1" style="display:none; max-width:100px; max-height:100px; margin-top: 10px;">
								<span id="fileName1" style="display: block; margin-top: 5px; font-size: 12px; color: #666;"></span>
							</div>
							<div class="image-upload-item">
								<label style="display: block; margin-bottom: 5px; font-weight: 500;">이미지 2</label>
								<input type="file" id="imageFile2" accept="image/*" onchange="uploadImage(this, 2)" style="width: 100%;">
								<input type="hidden" id="image2FileId" name="image2FileId">
								<img id="preview2" style="display:none; max-width:100px; max-height:100px; margin-top: 10px;">
								<span id="fileName2" style="display: block; margin-top: 5px; font-size: 12px; color: #666;"></span>
							</div>
							<div class="image-upload-item">
								<label style="display: block; margin-bottom: 5px; font-weight: 500;">이미지 3</label>
								<input type="file" id="imageFile3" accept="image/*" onchange="uploadImage(this, 3)" style="width: 100%;">
								<input type="hidden" id="image3FileId" name="image3FileId">
								<img id="preview3" style="display:none; max-width:100px; max-height:100px; margin-top: 10px;">
								<span id="fileName3" style="display: block; margin-top: 5px; font-size: 12px; color: #666;"></span>
							</div>
						</div>
					</div>
				</section>
				-->

				<!-- ========== 회수지 정보 ========== -->
				<section class="shipping-info-section">
					<h2 class="section-title">회수지 정보</h2>
					<div class="delivery-form">
						<!-- 주소 수정 안내 메시지 -->
						<!-- 
						<div class="address-notice" style="background: #fff3cd; padding: 12px; border-radius: 4px; margin-bottom: 15px; border-left: 4px solid #ffc107;">
							<p style="margin: 0; font-size: 14px; color: #856404;">
								⚠️ 주소 변경이 필요하신 경우, <a href="${pageContext.request.contextPath}/store/mypage/updateMember" style="color: #0066cc; text-decoration: underline;">회원정보 수정</a>에서 변경해주세요.
							</p>
						</div>
						-->
						
						<div class="form-row">
							<div class="label">보내는 분</div>
							<div class="input-area">
								<my:textInput type="readOnly" name="senderName" value="${member.name}" size="lg" />
							</div>
						</div>

						<div class="form-row">
							<div class="label">연락처</div>
							<div class="input-area">
								<my:textInput type="readOnly" name="senderPhone" value="${member.phone}" size="lg" />
							</div>
						</div>

						<div class="form-row address-row">
							<div class="label">주소</div>
							<div class="input-area address-row">
								<div class="address-input-group">
									<my:textInput type="readOnly" name="senderPostcode" value="${member.postcode}" size="sm" />
								</div>
								<div class="detail-address">
									<my:textInput type="readOnly" name="senderLine1" value="${member.line1}" size="sm" />
									<my:textInput type="readOnly" name="senderLine2" value="${member.line2}" size="sm" />
								</div>
							</div>
						</div>
					</div>
				</section>

				<!-- ========== 버튼 영역 ========== -->
				<div class="button-wrapper" style="display: flex; justify-content: center; gap: 10px; margin-top: 30px;">
					<button type="button" class="btn btn-outline btn-lg" 
						onclick="history.back()">취소</button>
					<button type="submit" class="btn btn-primary btn-lg">반품 신청</button>
				</div>
			</form>
		</div>
	</main>

	<!-- 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>

	<script>
	// 배송비 자동 계산
	function updateShippingCost() {
	    const reason = document.getElementById('reason').value;
	    const shippingCostInput = document.getElementById('shippingCost');
	    const shippingCostPayerInput = document.getElementById('shippingCostPayer');
	    const shippingCostDisplay = document.getElementById('shippingCostDisplay');
	    const shippingNotice = document.getElementById('shippingNotice');
	    
	    if (!reason) {
	        shippingCostDisplay.textContent = '사유를 선택하면 배송비가 표시됩니다';
	        shippingCostDisplay.style.color = '#666';
	        shippingCostDisplay.style.background = '#f8f9fa';
	        shippingNotice.style.display = 'none';
	        return;
	    }
	    
	    // 고객단순변심, 상품불만족 → 고객 부담 (2,500원)
	    if (reason === '고객단순변심' || reason === '상품불만족') {
	        shippingCostInput.value = '2500';
	        shippingCostPayerInput.value = 'member';
	        shippingCostDisplay.textContent = '2,500원 (고객 부담)';
	        shippingCostDisplay.style.color = '#ff4444';
	        shippingCostDisplay.style.background = '#fff5f5';
	        shippingCostDisplay.style.fontWeight = 'bold';
	        
	        shippingNotice.textContent = '💡 회수 시 택배 기사님께 배송비(2,500원)를 착불로 지불해주세요.';
	        shippingNotice.style.display = 'block';
	        shippingNotice.style.color = '#ff4444';
	        shippingNotice.style.background = '#fff5f5';
	        shippingNotice.style.border = '1px solid #ffcccc';
	    } else {
	        // 피부트러블, 상품불량, 주문오류, 상품파손, 오배송 → 무료
	        shippingCostInput.value = '0';
	        shippingCostPayerInput.value = 'brand';
	        shippingCostDisplay.textContent = '무료 (판매자 부담)';
	        shippingCostDisplay.style.color = '#28a745';
	        shippingCostDisplay.style.background = '#f0f8f5';
	        shippingCostDisplay.style.fontWeight = 'bold';
	        
	        shippingNotice.textContent = '💡 판매자 귀책 사유로 배송비가 무료입니다.';
	        shippingNotice.style.display = 'block';
	        shippingNotice.style.color = '#28a745';
	        shippingNotice.style.background = '#f0f8f5';
	        shippingNotice.style.border = '1px solid #c3e6cb';
	    }
	}

	// ========== 이미지 업로드 함수 (주석 처리) ==========
	/*
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
	    
	    fetch('/imageUpload', {
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
	*/

	// 폼 제출 전 검증
	document.getElementById('returnForm').addEventListener('submit', function(e) {
	    const reason = document.getElementById('reason').value;
	    
	    if (!reason) {
	        e.preventDefault();
	        alert('반품 사유를 선택해주세요.');
	        return false;
	    }
	    
	    return confirm('반품 신청을 하시겠습니까?');
	});
	</script>
</body>
</html>