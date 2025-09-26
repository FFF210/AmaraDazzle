<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>상품 목록</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/dialog.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
</head>
<body>

	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="상품목록:" />
			</div>

			<!-- 세일 등록 버튼 -->
			<div class="page-openSaleDialog">
				<button type="button" class="btn btn-primary btn-md"
					id="openSaleDialog">세일 등록</button>
			</div>

			<!-- 테이블 필터 -->
			<div class="page-tableFilter">
				<my:tableFilter
					filters="판매상태:ALL=전체|SALE=판매중|SOLD_OUT=품절|STOP_SALE=판매중지"
					hasDate="false" searchItems="상품명,카테고리" />
			</div>

			<!-- 총 건수 -->
			<div class="page-totalCount">
				<p>총 ${totalCount} 건</p>
			</div>

			<!-- 결과 테이블 -->
			<div class="page-table">
				<div class="table-wrapper">
					<table class="table">
						<thead>
							<tr>
								<th><input type="checkbox" class="form-check" /></th>
								<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>상품코드</th>
								<th>상품명</th>
								<th>카테고리</th>
								<th class="sortable">판매가 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">할인가 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>판매상태</th>
								<th class="sortable">재고 수 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">누적 판매수 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">리뷰 수 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th>작업</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="product" items="${productList}" varStatus="loop">
								<tr>
									<td><input type="checkbox" class="form-check" /></td>
									<td>${loop.index + 1}</td>
									<td>${product.productId}</td>
									<td>
										<div class="product-name">
											<p>${product.name}</p>
										</div>
									</td>
									<td>${product.categoryPath}</td>
									<td><fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0" groupingUsed="true"/></td>
									<td><fmt:formatNumber value="${product.salePrice}" type="number" maxFractionDigits="0" groupingUsed="true"/></td>
									<td><my:tag
											color="${product.status == 'SALE' ? 'green' : (product.status == 'SOLD_OUT' ? 'red' : 'gray')}"
											size="sm" text="${product.status.getDescription()}" /></td>
									<td>${product.stockQty}</td>
									<td>${product.salesQty}</td>
									<td>${product.reviewCount}</td>
									<td>
										<div class="actions">
											<button type="button" class="btn btn-outline btn-sm">재고
												수정</button>
											<button type="button" class="btn btn-outline btn-sm">수정</button>
											<button type="button" class="btn btn-danger btn-sm">삭제</button>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="${currentPage}"
					totalPages="${totalPages}" baseUrl="/brand/products?page=" />
			</div>
		</div>
	</my:layout>

	<script>
  // tableFilter 이벤트
  document.addEventListener("filterChanged", (e) => {
  console.log("필터 상태:", e.detail);

  if (e.detail.submit) {
    const { filters, searchField, searchKeyword } = e.detail;
    const params = new URLSearchParams();

    // 판매상태
    for (const [key, value] of Object.entries(filters)) {
    	  params.append("status", value);
    	}

    if (searchField) params.append("searchType", searchField);
    if (searchKeyword) params.append("searchKeyword", searchKeyword);

    // 페이지는 1부터 시작
    params.append("page", 1);

    // 최종 URL로 이동 (GET 요청)
    window.location.href = "/brand/productList?" + params.toString();
  }
});

  // "세일 등록" 버튼 클릭 → 다이얼로그 열기
  document.getElementById("openSaleDialog").addEventListener("click", () => {
    document.getElementById("formDialog").classList.add("show");
  });

  // 테이블 정렬
  document.querySelectorAll(".table th.sortable").forEach(th => {
	  th.addEventListener("click", () => {
	    // 모든 헤더 초기화
	    document.querySelectorAll(".table th.sortable").forEach(other => {
	      if (other !== th) {
	        other.classList.remove("asc", "desc");
	        other.querySelector(".sort-icon").className = "bi bi-dash-lg sort-icon";
	      }
	    });

	    const icon = th.querySelector(".sort-icon");

	    if (th.classList.contains("asc")) {
	      th.classList.remove("asc");
	      th.classList.add("desc");
	      icon.className = "bi bi-caret-down-fill sort-icon";
	    } else if (th.classList.contains("desc")) {
	      th.classList.remove("desc");
	      icon.className = "bi bi-dash-lg sort-icon"; // 기본 상태
	    } else {
	      th.classList.add("asc");
	      icon.className = "bi bi-caret-up-fill sort-icon";
	    }
	  });
	});
</script>
</body>
</html>
