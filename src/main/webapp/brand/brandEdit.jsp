<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>브랜드 정보 수정</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/dialog.css" />
<link rel="stylesheet" href="../tagcss/uploader.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/textArea.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/uploader.css" />
<link rel="stylesheet" href="./css/alert.css" />
<link rel="stylesheet" href="./css/detailForm.css" />
</head>

<body class="<c:if test='${not empty product}'>edit-mode</c:if>">
	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="브랜드정보수정:" />
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>브랜드 정보 수정</h2>
			</div>

			<!-- 상품 등록/수정 폼 -->
			<form class="product-form" method="post" action="/brand/brandEdit"
				enctype="multipart/form-data">

				<section class="form-section">
					<h3>기본 정보</h3>

					<div class="form-group">
						<label>브랜드명</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${brandDetail.brandName}" />
					</div>

					<div class="form-group image">
						<label>로고 이미지</label>
						<c:choose>
							<c:when test="${not empty brandDetail.logoFileId}">
								<img src="/upload_file/${brandDetail.logoFileId}" alt="로고 이미지"
									style="width: 120px; height: 120px; object-fit: contain;">
							</c:when>
							<c:otherwise>
								<p style="color: #999;">등록된 로고 이미지가 없습니다.</p>
							</c:otherwise>
						</c:choose>
						<input type="file" name="upload1" accept="image/*">
					</div>

					<div class="form-group image">
						<label>배너 이미지</label>
						<c:choose>
							<c:when test="${not empty brandDetail.heroFileId}">
								<img src="/upload_file/${brandDetail.heroFileId}" alt="배너 이미지"
									style="width: 100%; object-fit: cover;">
							</c:when>
							<c:otherwise>
								<p style="color: #999;">등록된 배너 이미지가 없습니다.</p>
							</c:otherwise>
						</c:choose>
						<input type="file" name="upload2" accept="image/*">
					</div>

					<div class="form-group">
						<label>브랜드 소개</label>
						<my:textArea name="intro" placeholder="브랜드 소개를 입력하세요"
							maxLength="200" showCount="true" value="${brandDetail.intro}" />
					</div>
				</section>

				<section class="form-section">
					<h3>사업자 정보</h3>

					<div class="form-group">
						<label>사업자등록번호</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${brandDetail.brn}" />
					</div>
					<div class="form-group">
						<label>대표자명</label>
						<my:textInput type="default" state="default" size="lg"
							name="managerName" value="${brandDetail.managerName}" />
					</div>
					<div class="form-group">
						<label>연락처</label>
						<my:textInput type="default" state="default" size="lg"
							name="phone" value="${brandDetail.phone}" />
					</div>
				</section>

				<section class="form-section">
					<h3>정산 정보</h3>

					<div class="form-group">
						<label>은행명</label>
						<my:textInput type="default" state="default" size="lg" name="bank"
							value="${brandDetail.bank}" />
					</div>
					<div class="form-group">
						<label>예금주명</label>
						<my:textInput type="default" state="default" size="lg"
							name="accountHolder" value="${brandDetail.accountHolder}" />
					</div>
					<div class="form-group">
						<label>계좌번호</label>
						<my:textInput type="default" state="default" size="lg"
							name="accountNumber" value="${brandDetail.accountNumber}" />
					</div>
				</section>

				<!-- 버튼 -->
				<div class="form-actions">
					<button type="button" class="btn btn-outline btn-xl"
						onclick="history.back()">취소</button>
					<button type="submit" class="btn btn-primary btn-xl">수정</button>
				</div>
			</form>
		</div>
	</my:layout>
	
<script>
document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("form.product-form");

  form?.addEventListener("submit", () => {
    localStorage.setItem(
      "toast",
      JSON.stringify({
        type: "success",
        message: "브랜드 정보가 성공적으로 수정되었습니다.",
      })
    );
  });
});
</script>

</body>
</html>

