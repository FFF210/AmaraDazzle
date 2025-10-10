<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 - 1:1 문의하기</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/writeTicket.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/selectbox.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textArea.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/imageBtn.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
</head>
<body>
	<%-- 헤더 --%>
	<%@ include file="/consumer/header.jsp"%>

	<div class="pageHeader-wrapper">
		<my:pageHeader hasButton="false" title="고객센터" description="무엇을 도와드릴까요" />
	</div>

	<!-- 문의 작성 페이지 -->
	<main class="main-content">

		<!-- 에러 메시지 표시 -->
		<c:if test="${not empty err}">
			<div class="error-message"
				style="color: red; padding: 10px; margin-bottom: 20px; background: #ffe6e6; border-radius: 4px;">
				${err}</div>
		</c:if>

		<form action="<c:url value='/store/mypage/writeTicket'/>"
			method="post" id="ticketForm">

			<!-- 문의 유형 -->
			<div class="inquiry-type">
				<label>문의 유형 <span style="color: red;">*</span></label>
				<my:selectbox id="categorySelect" size="lg"
					items="주문,취소,환불,교환,배송,결제,이벤트,사이트 이용 오류/개선" initial="선택해주세요" />
				<!-- 실제 form 제출용 hidden input -->
				<input type="hidden" name="category" id="categoryInput" required>
			</div>

			<!-- 주문 번호 (주문 관련일 때만 표시) -->
			<div class="order-number" id="orderSection" style="display: none;">
				<label>주문 번호 <span style="color: red;">*</span></label>
				<my:textInput id="orderCode" name="orderCode"
					placeholder="주문 시 발급받은 주문번호를 입력해주세요 (예: 20250104-010001)"
					type="default" size="lg" state="default" />
			</div>

			<!-- 내용 -->
			<div class="write-form">
				<label>내용 <span style="color: red;">*</span></label>
				<my:textArea name="question" placeholder="문의 내용을 입력하세요" />
			</div>

			<!-- 이미지 업로드 (최대 3개) -->
			<%-- <div class="upload-image">
				<label>이미지 첨부 <br>(선택, 최대 3개)</label>
				<div style="display: flex; gap: 10px; margin-top: 10px;">
					<my:imageBtn name="image1" />
					<my:imageBtn name="image2" />
					<my:imageBtn name="image3" />
				</div>
				<!-- 업로드된 파일 ID를 저장할 hidden input -->
				<input type="hidden" name="image1FileId" id="image1FileId">
				<input type="hidden" name="image2FileId" id="image2FileId">
				<input type="hidden" name="image3FileId" id="image3FileId">
			</div> --%>

			<!-- tag부분 안 돼서 기본으로 추가해뒀는데 css를 전혀 건드리지 않아서 엉망이에요... -->
			<!-- 이미지 업로드 (최대 3개) -->
			<div class="upload-image">
				<label>이미지 첨부 (선택, 최대 3개)</label>
				<div class="image-upload-area"
					style="display: flex; gap: 20px; margin-top: 10px;">
					<div class="image-upload-item">
						<label for="imageFile1"
							style="display: block; margin-bottom: 5px; font-size: 14px;">이미지
							1</label> <input type="file" id="imageFile1" accept="image/*"
							onchange="uploadImage(this, 1)" style="margin-bottom: 10px;">
						<input type="hidden" id="image1FileId" name="image1FileId">
						<img id="preview1"
							style="display: none; max-width: 100px; max-height: 100px; border: 1px solid #ddd; margin-top: 5px;">
						<span id="fileName1"
							style="font-size: 12px; color: #666; display: block; margin-top: 5px;"></span>
					</div>
					<div class="image-upload-item">
						<label for="imageFile2"
							style="display: block; margin-bottom: 5px; font-size: 14px;">이미지
							2</label> <input type="file" id="imageFile2" accept="image/*"
							onchange="uploadImage(this, 2)" style="margin-bottom: 10px;">
						<input type="hidden" id="image2FileId" name="image2FileId">
						<img id="preview2"
							style="display: none; max-width: 100px; max-height: 100px; border: 1px solid #ddd; margin-top: 5px;">
						<span id="fileName2"
							style="font-size: 12px; color: #666; display: block; margin-top: 5px;"></span>
					</div>
					<div class="image-upload-item">
						<label for="imageFile3"
							style="display: block; margin-bottom: 5px; font-size: 14px;">이미지
							3</label> <input type="file" id="imageFile3" accept="image/*"
							onchange="uploadImage(this, 3)" style="margin-bottom: 10px;">
						<input type="hidden" id="image3FileId" name="image3FileId">
						<img id="preview3"
							style="display: none; max-width: 100px; max-height: 100px; border: 1px solid #ddd; margin-top: 5px;">
						<span id="fileName3"
							style="font-size: 12px; color: #666; display: block; margin-top: 5px;"></span>
					</div>
				</div>
			</div> 

			<!-- 답변 주체 (hidden, 기본값 ADMIN) -->
			<input type="hidden" name="recieverType" id="recieverTypeInput"
				value="ADMIN">

			<!-- 버튼 -->
			<div class="action-button">
				<button type="button" class="btn btn-outline btn-lg"
					onclick="goBack()">취소</button>
				<button type="submit" class="btn btn-primary btn-lg">등록</button>
			</div>

		</form>

	</main>

	<%-- footer --%>
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
	    
	    fetch('${pageContext.request.contextPath}/store/imageUpload', {
	        method: 'POST',
	        body: formData
	    })
	    .then(response => response.json())
	    .then(data => {
	        if (data.success) {
	            // hidden input에 fileId 저장
	            document.getElementById('image' + imageIndex + 'FileId').value = data.fileId;
	            
	            // 미리보기 이미지 표시
	            const preview = document.getElementById('preview' + imageIndex);
	            preview.src = '${pageContext.request.contextPath}/store/image?fileId=' + data.fileId;
	            preview.style.display = 'block';
	            
	            // 파일명 표시
	            const fileNameSpan = document.getElementById('fileName' + imageIndex);
	            if (fileNameSpan) {
	                fileNameSpan.textContent = '✓ ' + data.fileName;
	            }
	            
	            alert('이미지가 업로드되었습니다.');
	        } else {
	            alert('파일 업로드 실패: ' + data.message);
	            inputElement.value = '';
	        }
	    })
	    .catch(error => {
	        console.error('업로드 에러:', error);
	        alert('파일 업로드 중 오류가 발생했습니다.');
	        inputElement.value = '';
	    });
	}	
	
//========== selectbox 초기화 및 이벤트 처리 ==========
document.addEventListener('DOMContentLoaded', function() {
    const selectBoxes = document.querySelectorAll('.custom-select');
    
    selectBoxes.forEach(selectBox => {
        const header = selectBox.querySelector('.select-header');
        const list = selectBox.querySelector('.select-list');
        const items = selectBox.querySelectorAll('.select-item');
        const label = selectBox.querySelector('.select-label');
        
        header.addEventListener('click', function(e) {
            e.stopPropagation();
            document.querySelectorAll('.custom-select').forEach(otherBox => {
                if (otherBox !== selectBox) {
                    otherBox.classList.remove('open');
                }
            });
            selectBox.classList.toggle('open');
        });
        
        items.forEach(item => {
            item.addEventListener('click', function(e) {
                e.stopPropagation();
                items.forEach(i => i.classList.remove('active'));
                item.classList.add('active');
                
                const text = item.textContent.trim();
                const value = item.getAttribute('data-value');
                label.textContent = text;
                selectBox.classList.remove('open');
                
                const event = new CustomEvent('selectChanged', {
                    detail: { value: value, text: text }
                });
                document.dispatchEvent(event);
            });
        });
    });
    
    document.addEventListener('click', function() {
        document.querySelectorAll('.custom-select').forEach(box => {
            box.classList.remove('open');
        });
    });
});

//========== selectbox 값 변경 시 처리 ==========	
document.addEventListener("selectChanged", (e) => {
    const selectedText = e.detail.text;
    
    // 텍스트 → 코드 매핑
    const categoryMap = {
        '주문': 'ORDER',
        '취소': 'CANCEL',
        '환불': 'REFUND',
        '교환': 'EXCHANGE',
        '배송': 'DELIVERY',
        '결제': 'PAYMENT',
        '이벤트': 'EVENT',
        '사이트 이용 오류/개선': 'SITE_ISSUE'
    };
    
    const categoryCode = categoryMap[selectedText] || '';
    
    // hidden input에 저장
    document.getElementById('categoryInput').value = categoryCode;
    
    // ========== 카테고리별 recieverType 설정 ==========
    const recieverTypeInput = document.getElementById('recieverTypeInput');
    
    // 상품/브랜드 관련 → BRAND_ADMIN
    // 플랫폼/결제/사이트 관련 → ADMIN
    if (categoryCode === 'ORDER' || categoryCode === 'CANCEL' || 
        categoryCode === 'REFUND' || categoryCode === 'EXCHANGE' || 
        categoryCode === 'DELIVERY') {
        recieverTypeInput.value = 'BRAND_ADMIN';  // 브랜드 관리자
    } else {
        recieverTypeInput.value = 'ADMIN';  // 플랫폼 관리자
    }
    
    // 주문 관련 체크
    const orderRelated = ['ORDER', 'CANCEL', 'REFUND', 'EXCHANGE', 'DELIVERY', 'PAYMENT'];
    const orderSection = document.getElementById('orderSection');
    const orderCodeInput = document.getElementById('orderCode');
    
    if (orderRelated.includes(categoryCode)) {
        orderSection.style.display = 'block';
        orderCodeInput.required = true;
    } else {
        orderSection.style.display = 'none';
        orderCodeInput.required = false;
        orderCodeInput.value = '';
    }
});

// ========== 취소 버튼 ==========
function goBack() {
    if (confirm('작성 중인 내용이 사라집니다. 취소하시겠습니까?')) {
        location.href = '<c:url value="/store/mypage/ticketList"/>';
    }
}

// ========== form 제출 전 유효성 검사 ==========
document.getElementById('ticketForm').addEventListener('submit', function(e) {
    const category = document.getElementById('categoryInput').value;
    const orderCode = document.getElementById('orderCode').value;
    const question = document.querySelector('textarea[name="question"]').value;
    
    // 카테고리 체크
    if (!category || category === '선택해주세요') {
        alert('문의 유형을 선택해주세요.');
        e.preventDefault();
        return;
    }
    
    // 주문 관련 카테고리인데 주문번호가 없으면
    const orderRelated = ['ORDER', 'CANCEL', 'REFUND', 'EXCHANGE', 'DELIVERY', 'PAYMENT'];
    if (orderRelated.includes(category) && !orderCode.trim()) {
        alert('주문 관련 문의는 주문번호가 필요합니다.');
        e.preventDefault();
        return;
    }
    
    // 내용 체크
    if (!question.trim()) {
        alert('문의 내용을 입력해주세요.');
        e.preventDefault();
        return;
    }
});
</script>
</body>
</html>