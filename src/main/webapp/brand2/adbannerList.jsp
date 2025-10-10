<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배너광고 조회</title>

<!-- Pretendard 폰트 (CDN) -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">

<!-- flatpickr 기본 테마 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/light.css">

<!-- 한글화 & 커스텀 CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/custom-flatpickr.css">

<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
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
	margin: 8px 0 8px 24px;
}

.filter {
	margin: 24px 24px 24px 24px;
}

.tcontainer {
	margin: 0px 24px 24px 24px;
}
</style>
<!-- TossPayments SDK -->
<script src="https://js.tosspayments.com/v1/payment"></script>

</head>
<body>
	<my:layout>
		<my:breadcrumb
			items="배너광고 관리:/brand2/adbannerList, 배너광고 신청:/brand2/adbanner" />

		<div class="page-tableFilter">
			<my:tableFilter
				filters="status|진행상황:PENDING=승인대기|APPROVED=승인완료|ONGOING=진행중|COMPLETED=완료|CANCELED=취소"
				hasDate="false" searchItems="광고 담당자,광고명" />
		</div>

		<div class="tcontainer">
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th><input type="checkbox" class="form-check" /></th>
							<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
							<th>신청일</th>
							<th>광고 기간</th>
							<th>광고명</th>
							<th>진행 상황</th>
							<th>광고 담당자</th>
							<th>결제 금액</th>
							<th>담당 연락처</th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="banner" items="${bannerList}">
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${banner.bannerId}</td>
								<td><fmt:formatDate value="${banner.createdAt}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${banner.startDate}"
										pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
										value="${banner.endDate}" pattern="yyyy-MM-dd" /></td>
								<td><p class="product-name">${banner.bannerName}</p></td>
								<td><c:choose>
										<c:when test="${banner.status eq 'PENDING'}">
											<my:tag color="blue" size="sm" text="승인 대기" />
										</c:when>
										<c:when test="${banner.status eq 'APPROVED'}">
											<my:tag color="gray" size="sm" text="승인 완료" />
										</c:when>
										<c:when test="${banner.status eq 'ONGOING'}">
											<my:tag color="green" size="sm" text="진행 중" />
										</c:when>
										<c:when test="${banner.status eq 'COMPLETED'}">
											<my:tag color="green" size="sm" text="완료" />
										</c:when>
										<c:when test="${banner.status eq 'CANCELED'}">
											<my:tag color="red" size="sm" text="취소" />
										</c:when>
									</c:choose></td>
								<td>${banner.managerName}</td>
								<c:set var="calc" value="${banner.period * 140000}" />
								<td><fmt:formatNumber value="${calc}" type="number" />원</td>
								<td>${banner.managerTel}</td>

								<!-- 상세보기 버튼 전용 열 -->
								<td><c:choose>
										<c:when test="${banner.status eq 'PENDING'}">
											<button type="button" class="btn btn-outline btn-sm"
												onclick="location.href='/brand2/adbannerDetail?bannerId=${banner.bannerId}'">상세보기</button>
										</c:when>
										<c:when test="${banner.status eq 'APPROVED'}">
											<button type="button" class="btn btn-outline btn-sm"
												onclick="location.href='/brand2/adbannerDetail?bannerId=${banner.bannerId}'">상세보기</button>
										</c:when>
										<c:when
											test="${banner.status eq 'ONGOING' or banner.status eq 'COMPLETED' or banner.status eq 'CANCELED'}">
											<button type="button" class="btn btn-outline btn-sm"
												onclick="location.href='/brand2/adbannerDetail?bannerId=${banner.bannerId}'">상세보기</button>
										</c:when>
									</c:choose></td>


								<!-- 취소 버튼 전용 열 -->
								<td><c:choose>
										<c:when test="${banner.status eq 'PENDING'}">
											<button type="button" class="btn btn-danger btn-sm"
												onclick="if(confirm('정말 취소하시겠습니까?')) location.href='/brand2/adbannerDetail?action=cancel&bannerId=${banner.bannerId}'">
												취소</button>
										</c:when>
										<c:when test="${banner.status eq 'APPROVED'}">
											<button type="button" class="btn btn-danger btn-sm"
												onclick="if(confirm('정말 취소하시겠습니까?')) location.href='/brand2/adbannerDetail?action=cancel&bannerId=${banner.bannerId}'">
												취소</button>
										</c:when>
										<c:otherwise>
											<button type="button" class="btn btn-danger btn-sm" disabled>취소</button>
										</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<%--
		status/button
		승인 대기 : 상세보기/취소
		승인 완료 : 상세보기/취소
		진행 중 : 상세보기
		완료 : 상세보기
		취소 : 상세보기
		 --%>

		<c:set var="queryString">
			<c:if test="${not empty param.status}">status=${param.status}&</c:if>
			<c:if test="${not empty param.searchType}">searchType=${param.searchType}&</c:if>
			<c:if test="${not empty param.searchKeyword}">searchKeyword=${param.searchKeyword}&</c:if>
				page=
			</c:set>
		<!-- 페이징 -->
		<div class="page-pagination">
			<my:pagination currentPage="${currentPage}"
				totalPages="${totalPages}"
				baseUrl="/brand2/adbannerList?${queryString}" />
		</div>

	</my:layout>

	<!-- flatpickr 및 tableFilter.js -->
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/tableFilter.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/selectbox.js"></script>

	<script>
	  /*********************************************************************************************************
	   * tableFilter 이벤트
	   * tag에 추가 필요
	   *********************************************************************************************************/
	  document.addEventListener("filterChanged", (e) => {
	  if (e.detail.submit) {
	    const { filters, searchField, searchKeyword } = e.detail;
	    const params = new URLSearchParams();

	    // 진행 상황
	    for (const [key, value] of Object.entries(filters)) {
	    	  params.append("status", value);
	    	}

	    // 검색 조건
	    if (searchField) params.append("searchType", searchField);
	    if (searchKeyword) params.append("searchKeyword", searchKeyword);

	    // 페이지는 1부터 시작
	    params.append("page", 1);

	    // 최종 URL로 이동 (GET 요청)
	    window.location.href = "/brand2/adbannerList?" + params.toString();
	  }
	});
	</script>

	<script>
	/******************* sortable 부분 *******************/
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