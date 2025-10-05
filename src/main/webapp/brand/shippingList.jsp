<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>배송 관리</title>

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

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/dialog.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
</head>
<body>

	<my:layout>
		<div class="page-container">
			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="배송관리:" />
			</div>

			<!-- 테이블 필터 -->
			<div class="page-tableFilter">
				<my:tableFilter
					filters="status|배송상태:ALL=전체|SHIPPING=배송중|DELIVERED=배송완료|COLLECTING=상품 회수중|EXCHANGE SHIPPING=교환 배송중"
					hasDate="true" searchItems="수령인,상품명,송장번호" />
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
								<th class="sortable">주문일 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>주문번호</th>
								<th>수령인</th>
								<th>상품명(옵션)</th>
								<th>송장번호</th>
								<th>배송상태</th>
								<th>메모</th>
								<th>작업</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="shipping" items="${shippingList}"
								varStatus="loop">
								<tr>
									<td><fmt:formatDate value="${shipping.orderDate}" pattern="yyyy-MM-dd" /></td>
									<td>${shipping.orderCode}</td>
									<td>${shipping.shipRecipient}</td>
									<td>
										<div class="product-name">
											<p>${shipping.representProductName}</p>
										</div>
									</td>
									<td>${shipping.trackingNo}</td>
									<td>
										<c:choose>
											<c:when test="${shipping.displayStatus == 'SHIPPING'}">
												<my:tag color="blue" size="sm" text="배송중" />
											</c:when>
											<c:when test="${shipping.displayStatus == 'DELIVERED'}">
												<my:tag color="green" size="sm" text="배송완료" />
											</c:when>
											<c:when test="${shipping.displayStatus == 'COLLECTING'}">
												<my:tag color="red" size="sm" text="상품 회수중" />
											</c:when>
											<c:when test="${shipping.displayStatus == 'EXCHANGE SHIPPING'}">
												<my:tag color="gray" size="sm" text="교환 배송중" />
											</c:when>
										</c:choose>
									</td>
									<td></td>
									<td>
										<div class="actions">
											<button type="button"
												class="btn btn-outline btn-sm btn-detail"
												data-order-id="${shipping.orderId}"
												data-status="${shipping.status}">상세</button>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<c:set var="queryString">
				<c:if test="${not empty param.status}">status=${param.status}&</c:if>
				<c:if test="${not empty param.searchType}">searchType=${param.searchType}&</c:if>
				<c:if test="${not empty param.searchKeyword}">searchKeyword=${param.searchKeyword}&</c:if>
				<c:if test="${not empty param.startDate}">startDate=${param.startDate}&</c:if>
				<c:if test="${not empty param.endDate}">endDate=${param.endDate}&</c:if>
				page=
			</c:set>

			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="${currentPage}"
					totalPages="${totalPages}"
					baseUrl="/brand/shippingList?${queryString}" />
			</div>
		</div>
	</my:layout>

	<script>
	/*********************************************************************************************************
	 * "상세"버튼 클릭 이벤트
	 *********************************************************************************************************/
	 document.querySelectorAll(".btn-detail").forEach(btn => {
		  btn.addEventListener("click", () => {
		    const orderId = btn.dataset.orderId;
		    const status = btn.dataset.status;
		    window.location.href = "/brand/shippingDetail?orderId=" + orderId + "&status=" + status;
		  });
		});
	
	 /*********************************************************************************************************
		 * tableFilter 이벤트
		 *********************************************************************************************************/
		 document.addEventListener("filterChanged", (e) => {
			  console.log("필터 상태:", e.detail);

			  if (e.detail.submit) {
			    const { filters, searchField, searchKeyword, dateStart, dateEnd } = e.detail;
			    const params = new URLSearchParams();

			    // 필터별 파라미터
			    for (const [key, value] of Object.entries(filters)) {
			      if (value && value !== 'ALL') {
			        params.append(key, value);
			      }
			    }

			    // 검색 조건
			    if (searchField) params.append("searchType", searchField);
			    if (searchKeyword) params.append("searchKeyword", searchKeyword);

			    // 날짜 조건 추가
			    if (dateStart) params.append("startDate", dateStart);
			    if (dateEnd) params.append("endDate", dateEnd);

			    // 페이지는 1부터 시작
			    params.append("page", 1);

			    // 최종 URL 이동
			    window.location.href = "/brand/shippingList?" + params.toString();
			  }
			});
	 
	  /*********************************************************************************************************
	   * 테이블 정렬
	   *********************************************************************************************************/
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
