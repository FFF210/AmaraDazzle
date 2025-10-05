<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 발송 조회</title>

<!-- Pretendard 폰트 (CDN) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">

<!-- flatpickr 기본 테마 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/light.css">

<!-- 한글화 & 커스텀 CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom-flatpickr.css">

<!-- flatpickr 및 tableFilter.js -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tableFilter.js"></script>
<script src="./js/selectbox.js"></script>

<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/header.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<style>
.pagination {
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
	margin: 20px 0; /* 위아래 여백 */
}

.breadcrumb {
	margin-top: 8px;
	margin-left: 24px;
}

.filter {
	margin: 24px 24px 24px 24px;
}

.table-filter {
	padding-bottom:0px;
}

.tcontainer {
	margin: 0px 24px 24px 24px;
}
</style>

</head>
<body>
	<my:layout>
		<my:breadcrumb
			items="메일 발송:/miniProj2/brand2/mailForm.jsp, 메일 발송 관리:/miniProj2/brand2/mailList.jsp" />

		<c:set var="filters"
			value="발송 유형:전체|할인 쿠폰 안내|신제품 출시 소식|상품 추천,
              발송 상태:전체|완료|예약|실패" />
		<div class="filter">
			<div class="table-filter">
				<c:set var="filterLines" value="${fn:split(filters, ',')}" />
				<c:forEach var="line" items="${filterLines}">
					<c:set var="parts" value="${fn:split(line, ':')}" />
					<c:set var="label" value="${parts[0]}" />
					<c:set var="options" value="${fn:split(parts[1], '|')}" />

					<div class="filter-row">
						<label>${label}:</label>
						<div class="filter-btn-group">
							<c:forEach var="opt" items="${options}">
								<button type="button" class="filter-btn" data-filter="${label}"
									data-value="${opt}">${opt}</button>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>



		<div class="tcontainer">
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th><input type="checkbox" class="form-check" /></th>
							<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
							<th>등록일</th>
							<th>발송 시간</th>
							<th>발송일</th>
							<th>발송 유형</th>
							<th>상품명(옵션)</th>
							<th>발송 상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="i" begin="1" end="10">
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td><my:tag color="green" size="sm" text="즉시" /></td>
								<td>2025-09-07${i}</td>
								<td>할인 쿠폰 안내</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="green" size="sm" text="완료" /></td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td><my:tag color="yellow" size="sm" text="예약" /></td>
								<td>2025-09-10</td>
								<td>신제품 출시 소식</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="yellow" size="sm" text="예약" /></td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td><my:tag color="yellow" size="sm" text="예약" /></td>
								<td>2025-09-07</td>
								<td>상품 추천</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="green" size="sm" text="완료" /></td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td><my:tag color="green" size="sm" text="즉시" /></td>
								<td>2025-09-07</td>
								<td>할인 쿠폰 안내</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="red" size="sm" text="실패" /></td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td><my:tag color="green" size="sm" text="즉시" /></td>
								<td>2025-09-07</td>
								<td>할인 쿠폰 안내</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="red" size="sm" text="실패" /></td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td><my:tag color="yellow" size="sm" text="예약" /></td>
								<td>2025-09-07</td>
								<td>할인 쿠폰 안내</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="red" size="sm" text="실패" /></td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td><my:tag color="green" size="sm" text="즉시" /></td>
								<td>2025-09-07</td>
								<td>할인 쿠폰 안내</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="green" size="sm" text="완료" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="pagination">
			<my:pagination currentPage="1" totalPages="10"
				baseUrl="/products?page=" />
		</div>
	</my:layout>

	<script>
	// 검색 버튼
	const submitBtn = container.querySelector(".filter-submit");
	if(submitBtn){
	  submitBtn.addEventListener("click", () => {
	    dispatch(true);
	  });
	}

	// 초기화 버튼
	const resetBtn = container.querySelector(".filter-reset");
	if(resetBtn){
	  resetBtn.addEventListener("click", () => {
	    container.querySelectorAll("input, .active").forEach(el => {
	      if(el.tagName === "INPUT") el.value = "";
	      el.classList.remove("active");
	    });
	    state.dateStart = "";
	    state.dateEnd = "";
	    state.quickRange = "";
	    state.filters = {};
	    state.searchField = "";
	    state.searchKeyword = "";
	    dispatch();
	  });
	}

	</script>
</body>
</html>