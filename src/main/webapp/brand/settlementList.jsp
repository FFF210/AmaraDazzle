<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>정산목록</title>
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
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="./css/table.css" />
</head>
<body>

	<my:layout>
		<div class="page-container">
			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="정산:/brand/settlementDashboard,정산목록:" />
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
								<th class="sortable">정산기간 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th>정산번호</th>
								<th class="sortable">총 주문 금액 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">할인 금액 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">순수 매출액 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th>플랫폼 수수료</th>
								<th class="sortable">최종 지급액 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">지급일자 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th>정산상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="settlement" items="${settlementList}">
								<tr>
									<!-- 정산기간 -->
									<td><fmt:formatDate value="${settlement.startDate}"
											pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
											value="${settlement.endDate}" pattern="yyyy-MM-dd" /></td>

									<!-- 정산번호 -->
									<td>${settlement.settlementId}</td>

									<!-- 총 주문 금액 -->
									<td><fmt:formatNumber value="${settlement.totalSales}"
											pattern="#,###" /></td>

									<!-- 할인 금액 (플랫폼+브랜드 쿠폰+포인트) -->
									<td><fmt:formatNumber
											value="${settlement.pCoupon + settlement.bCoupon + settlement.point}"
											pattern="#,###" /></td>

									<!-- 순수 매출액 -->
									<td><fmt:formatNumber value="${settlement.pureProfit}"
											pattern="#,###" /></td>

									<!-- 플랫폼 수수료 -->
									<td><fmt:formatNumber value="${settlement.fee}"
											pattern="#,###" /></td>

									<!-- 최종 지급액 -->
									<td><fmt:formatNumber value="${settlement.finalAmount}"
											pattern="#,###" /></td>

									<!-- 지급일자 -->
									<td><c:choose>
											<c:when test="${not empty settlement.depositedDate}">
												<fmt:formatDate value="${settlement.depositedDate}"
													pattern="yyyy-MM-dd" />
											</c:when>
											<c:otherwise>-</c:otherwise>
										</c:choose></td>

									<!-- 정산상태 -->
									<td><c:choose>
											<c:when test="${settlement.calcedYN eq 'Waiting'}">
												<my:tag color="gray" size="sm" text="대기중" />
											</c:when>
											<c:when test="${settlement.calcedYN eq 'InProgress'}">
												<my:tag color="yellow" size="sm" text="진행중" />
											</c:when>
											<c:when test="${settlement.calcedYN eq 'Completed'}">
												<my:tag color="green" size="sm" text="완료" />
											</c:when>
											<c:when test="${settlement.calcedYN eq 'error'}">
												<my:tag color="red" size="sm" text="오류" />
											</c:when>
										</c:choose></td>
								</tr>
							</c:forEach>
							<!-- 데이터가 없을 때 -->
							<c:if test="${empty settlementList}">
								<tr>
									<td colspan="10">정산 내역이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>

			<c:set var="queryString"> page=</c:set>
			
			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="${currentPage}"
					totalPages="${totalPages}"
					baseUrl="/brand/settlementList?${queryString}" />
			</div>
		</div>
	</my:layout>
</body>
<script>
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
</html>
