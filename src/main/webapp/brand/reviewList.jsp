<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>리뷰 조회</title>

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
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/rating.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="./css/alert.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
</head>
<body>
<c:set var="currentSortField" value="${param.sortField}" />
<c:set var="currentSortOrder" value="${param.sortOrder}" />

	<!-- Toast 알림 컨테이너 -->
	<div id="toast-container"></div>

	<my:layout>
		<div class="page-container">
			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="리뷰조회:" />
			</div>

			<!-- 테이블 필터 -->
			<div class="page-tableFilter">
				<my:tableFilter
					filters="answerStatus|답변상태:ALL=전체|PENDING=미답변|ANSWERED=답변완료"
					searchItems="상품명,작성자" />
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
								<th class="sortable" data-sort="questioned_at">작성일 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>상품명</th>
								<th>내용</th>
								<th class="sortable" data-sort="rating">별점 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>작성자</th>
								<th>답변상태</th>
								<th>작업</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="review" items="${reviewList}">
								<tr>
									<td><fmt:formatDate value="${review.questionedAt}"
											pattern="yyyy-MM-dd HH:mm" /></td>
									<td>
										<div class="product-name">
											<p>${review.productName}</p>
										</div>
									</td>

									<td>
										<div class="product-name">
											<p>${review.content}</p>
										</div>
									</td>

									<td>
										<div>
											<my:rating rating="${review.rating}" readonly="true" />
										</div>
									</td>

									<td>${review.memberName}</td>

									<td><c:choose>
											<c:when test="${review.answerStatus eq 'ANSWERED'}">
												<my:tag color="green" size="sm" text="답변완료" />
											</c:when>
											<c:otherwise>
												<my:tag color="red" size="sm" text="미답변" />
											</c:otherwise>
										</c:choose></td>

									<td>
										<div class="actions">
											<button type="button"
												class="btn btn-outline btn-sm btn-detail"
												data-review-id="${review.reviewId}">상세</button>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<c:set var="queryString">
				<c:if test="${not empty param.answerStatus}">answerStatus=${param.answerStatus}&</c:if>
				<c:if test="${not empty param.searchType}">searchType=${param.searchType}&</c:if>
				<c:if test="${not empty param.searchKeyword}">searchKeyword=${param.searchKeyword}&</c:if>
				<c:if test="${not empty param.startDate}">startDate=${param.startDate}&</c:if>
				<c:if test="${not empty param.endDate}">endDate=${param.endDate}&</c:if>
				<c:if test="${not empty param.sortField}">sortField=${param.sortField}&</c:if>
				<c:if test="${not empty param.sortOrder}">sortOrder=${param.sortOrder}&</c:if>
				page=
			</c:set>

			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="${currentPage}"
					totalPages="${totalPages}"
					baseUrl="/brand/reviewList?${queryString}" />
			</div>
		</div>
	</my:layout>

	<script src="./js/toast.js"></script>
	<script>
	/*********************************************************************************************************
	 * toast 호출
	 *********************************************************************************************************/
	 <c:if test="${not empty sessionScope.toastMessage}">
	    document.addEventListener("DOMContentLoaded", () => {
	      const msg = "${sessionScope.toastMessage}";
	      if (msg) {
	        showToast("success",msg);
	      }
	    });
	  <c:remove var="toastMessage" scope="session"/>
	</c:if>
		
	/*********************************************************************************************************
	 * "상세"버튼 클릭 이벤트
	 *********************************************************************************************************/
	 document.querySelectorAll(".btn-detail").forEach(btn => {
		  btn.addEventListener("click", () => {
		    const reviewId = btn.dataset.reviewId;
		    window.location.href = "/brand/reviewDetail?reviewId=" + reviewId;
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
		    window.location.href = "/brand/reviewList?" + params.toString();
		  }
		});

	 /*********************************************************************************************************
	  * 테이블 정렬
	  *********************************************************************************************************/
	 document.addEventListener("DOMContentLoaded", () => {
		  // -----------------------------
		  // 1. 현재 URL 파라미터 상태 반영
		  // -----------------------------
		  const params = new URLSearchParams(window.location.search);
		  const currentSortField = params.get("sortField");
		  const currentSortOrder = params.get("sortOrder");

		  if (currentSortField && currentSortOrder) {
		    const th = document.querySelector(`.table th[data-sort="${currentSortField}"]`);
		    if (th) {
		      const icon = th.querySelector(".sort-icon");
		      th.dataset.state = currentSortOrder;
		      th.classList.add(currentSortOrder);
		      icon.className =
		        currentSortOrder === "asc"
		          ? "bi bi-caret-up-fill sort-icon"
		          : "bi bi-caret-down-fill sort-icon";
		    }
		  }

		  // -----------------------------
		  // 2. 클릭 시 3단계 순환 (asc → desc → none)
		  // -----------------------------
		  document.querySelectorAll(".table th.sortable").forEach(th => {
		    th.addEventListener("click", () => {
		      const icon = th.querySelector(".sort-icon");
		      const currentState = th.dataset.state || "none";

		      // 다른 헤더 초기화
		      document.querySelectorAll(".table th.sortable").forEach(other => {
		        if (other !== th) {
		          other.dataset.state = "none";
		          other.classList.remove("asc", "desc");
		          const otherIcon = other.querySelector(".sort-icon");
		          otherIcon.className = "bi bi-dash-lg sort-icon";
		        }
		      });

		      // 상태 전환
		      let nextState;
		      if (currentState === "none") {
		        nextState = "asc";
		        th.classList.add("asc");
		        th.classList.remove("desc");
		        icon.className = "bi bi-caret-up-fill sort-icon";
		      } else if (currentState === "asc") {
		        nextState = "desc";
		        th.classList.remove("asc");
		        th.classList.add("desc");
		        icon.className = "bi bi-caret-down-fill sort-icon";
		      } else {
		        nextState = "none";
		        th.classList.remove("asc", "desc");
		        icon.className = "bi bi-dash-lg sort-icon";
		      }

		      th.dataset.state = nextState;

		      // URL 파라미터 갱신
		      const sortField = th.dataset.sort;
		      const params = new URLSearchParams(window.location.search);

		      if (nextState === "none") {
		        params.delete("sortField");
		        params.delete("sortOrder");
		      } else {
		        params.set("sortField", sortField);
		        params.set("sortOrder", nextState);
		      }

		      // 새 URL로 이동 (정렬 요청)
		      window.location.href = "/brand/reviewList?" + params.toString();
		    });
		  });
		});
	 </script>
</body>
</html>
