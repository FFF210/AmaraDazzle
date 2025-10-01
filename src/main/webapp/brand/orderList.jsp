<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>주문 관리</title>
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
				<my:breadcrumb items="주문관리:" />
			</div>

			<!-- 테이블 필터 -->
			<div class="page-tableFilter">
				<my:tableFilter
					filters="status|주문상태:ALL=전체|PAID=결제완료|PREPARING=상품준비중|SHIPPING=배송중|DELIVERED=배송완료|CANCELLED=주문취소|EXCHANGE=교환|RETURN=반품"
					hasDate="true" searchItems="주문자,주문상품명" />
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
								<th>주문자</th>
								<th>상품명(옵션)</th>
								<th class="sortable">총 실결제금액 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th>결제수단</th>
								<th>주문상태</th>
								<th>메모</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="order" items="${ordersList}" varStatus="loop">
								<tr>
									<td><fmt:formatDate value="${order.createdAt}"
											pattern="yyyy-MM-dd HH:mm" /></td>
									<td><a href="/brand/orderDetail?orderId=${order.ordersId}&from=order"><c:out
												value="${order.orderCode}" /></a></td>
									<td><c:out value="${order.memberName}" /></td>
									<td>
										<div class="product-name">
											<p>
												<c:out value="${order.productName}" />
											</p>
										</div>
									</td>
									<td><fmt:formatNumber value="${order.totalAmount}"
											type="number" maxFractionDigits="0" groupingUsed="true" /></td>
									<td>토스페이</td>
									<td><c:choose>
											<c:when test="${order.orderStatus == 'PAID'}">
												<my:tag color="yellow" size="sm" text="결제완료" />
											</c:when>
											<c:when test="${order.orderStatus == 'PREPARING'}">
												<my:tag color="yellow" size="sm" text="상품준비중" />
											</c:when>
											<c:when test="${order.orderStatus == 'SHIPPING'}">
												<my:tag color="yellow" size="sm" text="배송중" />
											</c:when>
											<c:when test="${order.orderStatus == 'DELIVERED'}">
												<my:tag color="yellow" size="sm" text="배송완료" />
											</c:when>
											<c:when test="${order.orderStatus == 'CONFIRMED'}">
												<my:tag color="green" size="sm" text="구매확정" />
											</c:when>
											<c:when test="${order.orderStatus == 'CANCELLED'}">
												<my:tag color="red" size="sm" text="주문취소" />
											</c:when>
											<c:when test="${order.orderStatus == 'COLLECTING'}">
												<my:tag color="gray" size="sm" text="상품회수중" />
											</c:when>
											<c:when
												test="${fn:startsWith(order.orderStatus, 'EXCHANGE')}">
												<my:tag color="red" size="sm" text="교환" />
											</c:when>
											<c:when test="${fn:startsWith(order.orderStatus, 'RETURN')}">
												<my:tag color="red" size="sm" text="반품" />
											</c:when>
										</c:choose></td>

									<td></td>
								</tr>
							</c:forEach>
							<c:if test="${empty ordersList}">
								<tr>
									<td colspan="7">조회된 주문이 없습니다.</td>
								</tr>
							</c:if>
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
					baseUrl="/brand/orderList?${queryString}" />
			</div>
		</div>
	</my:layout>

	<script src="./js/selectbox.js"></script>
	<script>
	
	/*********************************************************************************************************
	 * tableFilter 이벤트
	 *********************************************************************************************************/
	 document.addEventListener("filterChanged", (e) => {
		  console.log("필터 상태:", e.detail);

		  if (e.detail.submit) {
		    const { filters, searchField, searchKeyword, dateStart, dateEnd } = e.detail;
		    const params = new URLSearchParams();

		    // 주문 상태
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
		    window.location.href = "/brand/orderList?" + params.toString();
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
