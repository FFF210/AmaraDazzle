<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>고객 문의 조회</title>
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
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/alert.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
</head>
<body>
<!-- Toast 알림 컨테이너 -->
	<div id="toast-container"></div>

	<my:layout>
		<div class="page-container">
			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="고객문의조회:" />
			</div>

			<!-- 테이블 필터 -->
			<div class="page-tableFilter">
				<my:tableFilter
					filters="category|문의유형:ALL=전체|PRODUCT=상품|ORDER=주문|CANCEL=취소|REFUND=환불|EXCHANGE=교환|DELIVERY=배송, answerStatus|답변상태:ALL2=전체|PENDING=미답변|ANSWERED=답변완료"
					hasDate="true" searchItems="작성자" />
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
								<th class="sortable">작성일 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>문의유형</th>
								<th>상품명</th>
								<th>작성자</th>
								<th>문의내용</th>
								<th>답변상태</th>
								<th>작업</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="qna" items="${qnaList}">
								<tr>
									<!-- 작성일 (yyyy-MM-dd HH:mm) -->
									<td><fmt:formatDate value="${qna.questionedAt}"
											pattern="yyyy-MM-dd HH:mm" /></td>

									<!-- 문의유형 -->
									<td><c:choose>
											<c:when test="${qna.category eq 'PRODUCT'}">
												<my:tag color="green" size="sm" text="상품" />
											</c:when>
											<c:when test="${qna.category eq 'ORDER'}">
												<my:tag color="yellow" size="sm" text="주문" />
											</c:when>
											<c:when test="${qna.category eq 'CANCEL'}">
												<my:tag color="yellow" size="sm" text="취소" />
											</c:when>
											<c:when test="${qna.category eq 'REFUND'}">
												<my:tag color="yellow" size="sm" text="환불" />
											</c:when>
											<c:when test="${qna.category eq 'EXCHANGE'}">
												<my:tag color="yellow" size="sm" text="교환" />
											</c:when>
											<c:when test="${qna.category eq 'DELIVERY'}">
												<my:tag color="yellow" size="sm" text="배송" />
											</c:when>
											<c:otherwise>
												<my:tag color="gray" size="sm" text="기타" />
											</c:otherwise>
										</c:choose></td>

									<!-- 상품명 -->
									<td>
										<div class="product-name">
											<p>${qna.productName}</p>
										</div>
									</td>

									<!-- 작성자 -->
									<td>${qna.senderName}</td>

									<!-- 문의내용 -->
									<td>
										<div class="product-name">
											<p>${qna.question}</p>
										</div>
									</td>

									<!-- 답변상태 -->
									<td><c:choose>
											<c:when test="${qna.status eq 'ANSWERED'}">
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
												data-qna-id="${qna.memberQnaId}"
												data-type="${qna.type}">상세</button>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<c:set var="queryString">
				<c:if test="${not empty param.category}">category=${param.category}&</c:if>
				<c:if test="${not empty param.answerStatus}">answerStatus=${param.answerStatus}&</c:if>
				<c:if test="${not empty param.searchType}">searchType=${param.searchType}&</c:if>
				<c:if test="${not empty param.searchKeyword}">searchKeyword=${param.searchKeyword}&</c:if>
				<c:if test="${not empty param.startDate}">startDate=${param.startDate}&</c:if>
				<c:if test="${not empty param.endDate}">endDate=${param.endDate}&</c:if>
				page=
			</c:set>

			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="${currentPage}"
					totalPages="${totalPages}" baseUrl="/brand/qnaList?${queryString}" />
			</div>
		</div>
	</my:layout>

<script src="./js/toast.js"></script>
	<script src="../tagjs/selectbox.js"></script>
	<script src="../tagjs/dateInput.js"></script>
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
		    const qnaId = btn.dataset.qnaId;
		    const type = btn.dataset.type;
		    window.location.href = "/brand/qnaDetail?type=" + type + "&qnaId=" + qnaId;
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
		      if (value && value !== 'ALL' && value !== 'ALL2') {
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
		    window.location.href = "/brand/qnaList?" + params.toString();
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
