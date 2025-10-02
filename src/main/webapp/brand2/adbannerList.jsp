<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배너광고 조회</title>

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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

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

.tcontainer {
	margin: 0px 24px 24px 24px;
}
</style>
<!-- TossPayments SDK -->
<script src="https://js.tosspayments.com/v1/payment"></script>
<!-- tag -->
<script src="../tagjs/selectbox.js"></script>
</head>
<body>
	<my:layout>
		<my:breadcrumb items="배너광고 관리:/brand2/adbannerList.jsp" />

		<my:tableFilter
			filters="status|판매상태:ALL=전체|SALE=판매중|SOLD_OUT=품절|STOP_SALE=판매중지"
			hasDate="false" searchItems="상품명,카테고리" />

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
								<td>미구현</td>
								<td>${banner.managerTel}</td>

								<!-- 상세보기 버튼 전용 열 -->
								<td><c:choose>
										<c:when test="${banner.status eq 'PENDING'}">
											<button type="button" class="btn btn-outline btn-sm"
												onclick="location.href='/brand2/bannerDetail?bannerId=${banner.bannerId}'">
												상세보기</button>
										</c:when>
										<c:when test="${banner.status eq 'APPROVED' and banner.paid}">
											<button type="button" class="btn btn-info btn-sm"
												onclick="location.href='/brand2/bannerDetail?bannerId=${banner.bannerId}'">
												상세보기</button>
										</c:when>
										<c:when
											test="${banner.status eq 'ONGOING' or banner.status eq 'COMPLETED' or banner.status eq 'CANCELED'}">
											<button type="button" class="btn btn-outline btn-sm"
												onclick="location.href='/brand2/bannerDetail?bannerId=${banner.bannerId}'">
												상세보기</button>
										</c:when>
									</c:choose></td>

								<!-- 취소 버튼 전용 열 -->
								<td><c:choose>
										<c:when test="${banner.status eq 'PENDING'}">
											<button type="button" class="btn btn-danger btn-sm"
												onclick="if(confirm('정말 취소하시겠습니까?')) location.href='/brand2/서블릿?bannerId=${banner.bannerId}'">
												취소</button>
										</c:when>
										<c:when test="${banner.status eq 'APPROVED' and banner.paid}">
											<button type="button" class="btn btn-danger btn-sm"
												onclick="location.href='/brand2/서블릿?bannerId=${banner.bannerId}'">
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
			<c:if test="${not empty param.startDate}">startDate=${param.startDate}&</c:if>
			<c:if test="${not empty param.endDate}">endDate=${param.endDate}&</c:if>
				page=
			</c:set>
		<!-- 페이징 -->
		<div class="page-pagination">
			<my:pagination currentPage="${currentPage}"
				totalPages="${totalPages}"
				baseUrl="/brand/productList?${queryString}" />
		</div>

	</my:layout>
	<!-- test_ck_XZYkKL4Mrj9eGzWBRNORV0zJwlEW -->

	<script>
	<%-- 검색 필터 구현 중 --%>
	document.addEventListener("filterChanged", (e) => {
	  console.log("필터 상태:", e.detail);
	
	  if (e.detail.submit) {
	    const { filters, searchField, searchKeyword } = e.detail;
	    const params = new URLSearchParams();
	
	    // 진행상황 필터 처리
	    for (const [key, value] of Object.entries(filters)) {
	      if (key === "진행 상황" && value && value !== "전체") {
	        // 한글 상태 → DB 코드 변환
	        switch (value) {
	          case "대기": params.append("status", "PENDING"); break;
	          case "진행 중": params.append("status", "ONGOING"); break;
	          case "완료": params.append("status", "COMPLETED"); break;
	          case "취소": params.append("status", "CANCELED"); break;
	        }
	      }
	    }
	
	    // 검색 항목 (광고명 / 광고담당자)
	    if (searchField) {
	      params.append("searchType", searchField);
	    }
	
	    if (searchKeyword !== undefined && searchKeyword !== null) {
	    	  params.append("searchKeyword", searchKeyword);
	    	}
	
	    // 페이지는 항상 1부터 시작
	    params.append("page", 1);
	
	    // 최종 URL로 이동 (GET 요청)
	    window.location.href = "/brand2/adbannerList?" + params.toString();
	  }
	});
	<%-- 검색 필터 구현 중 --%>
	
	  /*********************************************************************************************************
	   * tableFilter 이벤트
	   *********************************************************************************************************/
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
	
</script>
</body>
</html>