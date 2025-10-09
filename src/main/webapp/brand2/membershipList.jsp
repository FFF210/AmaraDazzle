<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:useBean id="now" class="java.util.Date" scope="page" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버십 결제내역</title>

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


<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/alert.css" />
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

<!-- 달력 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<style>
.breadcrumb {
	margin-top: 8px;
	margin-left: 24px;
}

.filter {
	margin: 24px 24px 24px 24px;
}

.membership-history {
	margin: 0px 24px 24px 24px;
}

/* 멤버십 상태 영역 */
.membership-status {
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 20px;
	margin: 20px auto 30px;
	padding: 20px;
	max-width: 900px;
	/* 기존 배경/테두리 제거 */
	background: none;
	border: none;
}

/* 박스 모양 전용 */
.notice {
	background: #fff3cd; /* 노란색 */
	border: 1px solid #ffeeba; /* 노란 테두리 */
	color: #856404;
	padding: 16px 20px;
	border-radius: 8px;
	font-size: 15px;
	text-align: center;
	width: 100%;
	max-width: 600px; /* 카드처럼 적당히 제한 */
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05); /* 살짝 그림자 */
}

/* "멤버십 없음" 알림 */
.membership-status .notice {
	background: #fff3cd;
	border: 1px solid #ffeeba;
	color: #856404;
	padding: 12px 16px;
	border-radius: 6px;
	font-size: 14px;
	text-align: center;
	width: 100%;
}

.membership-status .current-membership:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 14px rgba(0, 0, 0, 0.08);
}

.membership-status .current-membership span {
	font-size: 15px;
	color: #444;
	line-height: 1.5;
}

.membership-status .current-membership strong {
	color: #0c8ce9;
	font-weight: 700;
	font-size: 16px;
}

/* 예약 멤버십 문구 */
.membership-status .current-membership p.text-muted {
	color: #6b7280; /* 좀 더 차분한 회색 */
	font-style: italic;
	margin: 0;
}

/* 멤버십 변경 버튼 */
.membership-status .current-membership .btn {
	align-self: center;
	padding: 8px 18px;
	font-size: 14px;
	border-radius: 6px;
	transition: background 0.2s ease, transform 0.2s ease;
}

.membership-status .current-membership .btn:hover {
	background: #0c8ce9;
	color: #fff;
	transform: translateY(-2px);
}

#btnGoPay {
	margin-top: 10px;
}
</style>

</head>
<body>
	<my:layout>
		<my:breadcrumb
			items="멤버십 관리:/brand2/membershipList, 멤버십 결제:/brand2/membership" />
		<!-- 멤버십 상태 영역 -->
		<div class="membership-status">
		<!-- currentMembership/reservedMembership는 dto.membership 사용, membershipList는 dto.brand2.membershipList 사용 -->
			<c:choose>
				<c:when test="${empty currentMembership}">
					<div class="notice">
						보유한 멤버십이 없습니다. 새로운 멤버십을 구독해보세요!<br>
						<button class="btn btn-outline btn-sm" id="btnGoPay"
							onclick="location.href='/brand2/membership' ">멤버십 결제</button>
					</div>
				</c:when>

				<c:otherwise>
					<div class="notice">
						<span> 현재 이용 중 : <br> <strong id="planLabel">
								<c:choose>
									<c:when test="${currentMembership.planId eq 'PLAN_AUTO'}">정기결제 이용권</c:when>
									<c:when test="${currentMembership.planId eq 'PLAN_1M'}">1개월 이용권</c:when>
									<c:when test="${currentMembership.planId eq 'PLAN_3M'}">3개월 이용권</c:when>
									<c:when test="${currentMembership.planId eq 'PLAN_6M'}">6개월 이용권</c:when>
									<c:when test="${currentMembership.planId eq 'PLAN_12M'}">12개월 이용권</c:when>
									<c:otherwise>알 수 없는 이용권</c:otherwise>
								</c:choose>
						</strong><br> <strong id="quotaLabel">${currentMembership.remainQuota}</strong>
							건 메일 발송 가능합니다.
						</span>
						<br>
						<!-- 예약 멤버십 보조 문구 -->
						<c:if test="${not empty reservedMembership}">
							<p class="text-muted" style="font-size: 0.9em; margin-top: 5px;">
								예약분: <strong>${reservedMembership.remainQuota}</strong>건 (
								<c:choose>
									<c:when test="${reservedMembership.planId eq 'PLAN_AUTO'}">정기결제 이용권</c:when>
									<c:when test="${reservedMembership.planId eq 'PLAN_1M'}">1개월 이용권</c:when>
									<c:when test="${reservedMembership.planId eq 'PLAN_3M'}">3개월 이용권</c:when>
									<c:when test="${reservedMembership.planId eq 'PLAN_6M'}">6개월 이용권</c:when>
									<c:when test="${reservedMembership.planId eq 'PLAN_12M'}">12개월 이용권</c:when>
									<c:otherwise>알 수 없는 이용권</c:otherwise>
								</c:choose>
								, 시작일
								<fmt:formatDate value="${reservedMembership.startDate}"
									pattern="yyyy-MM-dd" />
								부터)
							</p>
						</c:if>
						<br>
						<button class="btn btn-outline btn-sm" id="btnGoPay"
							onclick="location.href='/brand2/membership' ">멤버십 추가</button>
					</div>
				</c:otherwise>
			</c:choose>

		</div>

		<div class="membership-history">
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th><input type="checkbox" class="form-check" /></th>
							<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
							<th>결제일</th>
							<th>취소일</th>
							<th>상태</th>
							<th>멤버십 기간</th>
							<th>멤버십</th>
							<th>결제수단</th>
							<th>다음결제일</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="membership" items="${membershipList }">
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${membership.membershipId}</td>
								<!-- 번호 -->
								<td><fmt:formatDate value="${membership.createdAt}"
										pattern="yyyy-MM-dd" /></td>
								<!-- 결제일 -->
								<td><c:if test="${membership.status eq 'CANCELLED'}">
										<fmt:formatDate value="${membership.updatedAt}"
											pattern="yyyy-MM-dd" />
									</c:if></td>
								<!-- 취소일 -->
								<td><c:choose>
										<c:when test="${membership.startDate gt now}">
											<my:tag color="blue" size="sm" text="예약" />
										</c:when>
										<c:when
											test="${membership.startDate le now and membership.endDate ge now}">
											<my:tag color="green" size="sm" text="현재 이용 중" />
										</c:when>
										<c:when test="${membership.endDate lt now}">
											<my:tag color="gray" size="sm" text="만료" />
										</c:when>
										<c:when test="${membership.status eq 'CANCELLED'}">
											<my:tag color="red" size="sm" text="취소" />
										</c:when>
									</c:choose></td>
								<!-- 상태 -->
								<td><fmt:formatDate value="${membership.startDate}"
										pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
										value="${membership.endDate}" pattern="yyyy-MM-dd" /></td>
								<!-- 멤버십 기간 -->
								<td><c:choose>
										<c:when test="${membership.planId eq 'PLAN_AUTO'}">정기결제 이용권</c:when>
										<c:otherwise>${membership.planPeriod}개월 이용권</c:otherwise>
									</c:choose></td>
								<!-- 멤버십 이름 -->
								<td>${membership.paymentMethod}</td>
								<!-- 결제수단 -->
								<td></td>
								<td><c:choose>
										<c:when
											test="${membership.status eq 'ACTIVE' and membership.startDate gt now}">
											<button type="button" class="btn btn-danger btn-sm"
												onclick="if(confirm('정말 취소하시겠습니까?')) location.href='/brand2/membershipDetail?action=cancel&membershipId=${membership.membershipId}'">
												취소</button>
										</c:when>
										<c:otherwise>
											<button type="button" class="btn btn-danger btn-sm" disabled>취소</button>
										</c:otherwise>
									</c:choose></td>
								<!-- 자동결제건인 경우, 날짜 기입 -->
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
				page=
			</c:set>
		<!-- 페이징 -->
		<div class="page-pagination">
			<my:pagination currentPage="${currentPage}"
				totalPages="${totalPages}"
				baseUrl="/brand2/membershipList?${queryString}" />
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
	   /******************* sortable 부분 *******************/
	   
	   
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
	    window.location.href = "/brand2/membershipList?" + params.toString();
	  }
	});
	</script>


</body>
</html>