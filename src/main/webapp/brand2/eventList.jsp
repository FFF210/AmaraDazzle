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
		<my:breadcrumb items="이벤트 관리:/brand2/eventList" />
		<div class="filter">
			<my:tableFilter
				filters="status|진행상황:RECRUIT=모집중|ONGOING=진행중|FINISHED=종료"
				hasDate="false" searchItems="이벤트명,이벤트 담당자" />
		</div>
		<!-- searchItmes는 tableFilter.js 수정, xml 수정 -->
		<div class="tcontainer">
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th><input type="checkbox" class="form-check" /></th>
							<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
							<th>신청일</th>
							<th>이벤트 기간</th>
							<th>이벤트명</th>
							<th>이벤트 진행</th>
							<th>이벤트 담당자</th>
							<th>참여 여부</th>
							<th></th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="event" items="${eventList}">
							<tr>
								<!-- 번호 -->
								<td><input type="checkbox" class="form-check" /></td>
								<td>${event.eventId}</td>
								<!-- 신청일 -->
								<td><fmt:formatDate value="${event.applyDate}"
										pattern="yyyy-MM-dd" /></td>
								<!-- 이벤트 기간 -->
								<td><fmt:formatDate value="${event.startDate}"
										pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
										value="${event.endDate}" pattern="yyyy-MM-dd" /></td>
								<!-- 이벤트명 -->
								<td>${event.eventName}</td>
								<!-- 이벤트 진행 -->
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
									</c:choose></td>
								<!-- 이벤트 담당자 -->
								<td>${event.managerName }</td>
								<td><c:choose>
										<c:when test="${event.participateYn eq '참여'}">
											<my:tag color="blue" size="sm" text="참여" />
										</c:when>
										<c:otherwise>
											<my:tag color="gray" size="sm" text="미참여" />
										</c:otherwise>
									</c:choose></td>
								<!-- 신청하기 -->
								<td><c:choose>
										<c:when
											test="${event.canApply eq 'Y' and event.participateYn eq '미참여'}">
											<button type="button" class="btn btn-outline btn-sm"
												onclick="location.href='/brand2/event?eventId=${event.eventId}'">
												신청하기</button>
										</c:when>
										<c:otherwise>
											<button type="button" class="btn btn-outline btn-sm" disabled>
												신청하기</button>
										</c:otherwise>
									</c:choose></td>

								<!-- 상세보기 -->
								<td><c:choose>
										<c:when test="${event.participateYn eq '참여'}">
											<button type="button" class="btn btn-outline btn-sm"
												onclick="location.href='/brand2/eventFormDetail?eventId=${event.eventId}'">상세보기</button>
										</c:when>
										<c:otherwise>
											<button type="button" class="btn btn-outline btn-sm" disabled>상세보기</button>
										</c:otherwise>
									</c:choose></td>

								<!-- 취소하기 -->
								<td><c:choose>
										<c:when
											test="${event.status eq 'RECRUIT' and event.participateYn eq '참여'}">
											<button type="button" class="btn btn-danger btn-sm"
												onclick="if(confirm('정말 취소하시겠습니까?')) location.href='/brand2/eventDetail?eventId=${event.eventId}'">취소</button>
										</c:when>
										<c:otherwise>
											<button type="button" class="btn btn-outline btn-sm" disabled>취소</button>
										</c:otherwise>
									</c:choose></td>
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
	<script
		src="${pageContext.request.contextPath}/resources/js/selectbox.js"></script>

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

	    // 진행 상황
	    if (searchField) params.append("searchType", searchField);
	    if (searchKeyword) params.append("searchKeyword", searchKeyword);
<%--
	    // 날짜 조건
	    if (dateStart) params.append("startDate", dateStart);
	    if (dateEnd) params.append("endDate", dateEnd);
--%>
	    // 페이지는 1부터 시작
	    params.append("page", 1);

	    // 최종 URL로 이동 (GET 요청)
	    window.location.href = "/brand2/eventList?" + params.toString();
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