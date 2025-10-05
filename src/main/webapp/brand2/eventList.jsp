<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>이벤트 조회</title>

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
	margin: 8px 0 8px 24px;
}

.filter {
	padding: 8px 24px 8px 24px;
}

.tcontainer {
	margin: 0px 24px 24px 24px;
}
</style>

</head>
<body>
	<my:layout>
		<my:breadcrumb items="이벤트 관리:/brand2/eventList.jsp" />
		<div class="filter">
			<my:tableFilter
				filters="status|진행상황:ALL=전체|RECRUIT=모집중|ONGOING=진행중|FINISHED=완료"
				hasDate="true" searchItems="이벤트 종류,이벤트 담당자" />
		</div>
		<div class="tcontainer">
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th><input type="checkbox" class="form-check" /></th>
							<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
							<th>신청일</th>
							<th>이벤트 기간</th>
							<th>이벤트 종류</th>
							<th>이벤트 진행</th>
							<th>이벤트 담당자</th>
							<th>참여 여부</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="event" items="${eventList}" varStatus="status">
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${status.index + 1}</td>
								<td><fmt:formatDate value="${event.applyDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${event.startDate}"
										pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
										value="${event.endDate}" pattern="yyyy-MM-dd" /></td>
								<td><c:choose>
										<c:when test="${not empty event.eventName}">
                                        ${event.eventName}
                                    </c:when>
										<c:otherwise>
                                        ${event.eventType}
                                    </c:otherwise>
									</c:choose></td>
								<td><c:choose>
										<c:when test="${event.status eq 'ONGOING'}">
											<my:tag color="green" size="sm" text="진행중" />
										</c:when>
										<c:when test="${event.status eq 'RECRUIT'}">
											<my:tag color="blue" size="sm" text="모집중" />
										</c:when>
										<c:when test="${event.status eq 'FINISHED'}">
											<my:tag color="gray" size="sm" text="완료" />
										</c:when>
										<c:otherwise>
											<my:tag color="gray" size="sm" text="미참여" />
										</c:otherwise>
									</c:choose></td>
								<td><c:choose>
										<c:when test="${not empty event.writer}">
                                        ${event.writer}
                                    </c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose></td>
								<td><c:choose>
										<c:when test="${event.participateYn eq '참여'}">
											<my:tag color="blue" size="sm" text="참여" />
										</c:when>
										<c:otherwise>
											<my:tag color="gray" size="sm" text="미참여" />
										</c:otherwise>
									</c:choose></td>
								<td>
									<div class="actions">
										<c:choose>
											<c:when
												test="${event.status eq 'ONGOING' and event.participateYn eq '참여'}">
												<button type="button" class="btn btn-outline btn-sm"
													onclick="location.href='/brand2/eventForm.jsp?eventId=${event.eventId}'">상세보기</button>
											</c:when>

											<c:when
												test="${event.status eq 'RECRUIT' and event.participateYn eq '참여'}">
												<button type="button" class="btn btn-outline btn-sm"
													onclick="location.href='/brand2/eventForm.jsp?eventId=${event.eventId}'">수정</button>
												<button type="button" class="btn btn-outline btn-sm"
													onclick="location.href='/brand2/eventForm.jsp?eventId=${event.eventId}'">상세보기</button>
											</c:when>

											<c:when
												test="${event.status eq 'RECRUIT' and event.participateYn eq '미참여'}">
												<button type="button" class="btn btn-outline btn-sm"
													onclick="location.href='/brand2/eventForm.jsp?eventId=${event.eventId}'">신청하기</button>
											</c:when>

											<c:when
												test="${event.status eq 'FINISHED' and event.participateYn eq '참여'}">
												<button type="button" class="btn btn-outline btn-sm"
													onclick="location.href='/brand2/eventForm.jsp?eventId=${event.eventId}'">상세보기</button>
											</c:when>

											<c:otherwise>-</c:otherwise>
										</c:choose>
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
				baseUrl="/brand2/eventList?${queryString}" />
		</div>

	</my:layout>
	<!-- flatpickr 및 tableFilter.js -->
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/tableFilter.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/selectbox.js"></script>

	<script>
	/*********************************************************************************************************
	 * tableFilter 이벤트
	 *********************************************************************************************************/
	 document.addEventListener("filterChanged", (e) => {
	  if (e.detail.submit) {
	    const { filters, searchField, searchKeyword, dateStart, dateEnd } = e.detail;
	    const params = new URLSearchParams();

	    // 이벤트 상태
	    for (const [key, value] of Object.entries(filters)) {
	      params.append("status", value);
	    }

	    // 검색 조건
	    if (searchField) params.append("searchType", searchField);
	    if (searchKeyword) params.append("searchKeyword", searchKeyword);

	    // 날짜 조건
	    if (dateStart) params.append("startDate", dateStart);
	    if (dateEnd) params.append("endDate", dateEnd);

	    // 페이지는 1부터 시작
	    params.append("page", 1);

	    // 최종 URL로 이동 (GET 요청)
	    window.location.href = "/brand2/eventList?" + params.toString();
	  }
	});
</script>
</body>

</html>