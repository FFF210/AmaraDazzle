<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
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
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/button.css" />
<link rel="stylesheet" href="./css/form-controls.css" />
<link rel="stylesheet" href="./css/layout.css" />
<link rel="stylesheet" href="./css/sidebar.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/table.css" />
<link rel="stylesheet" href="./css/tag.css" />
<link rel="stylesheet" href="./css/selectbox.css" />
<link rel="stylesheet" href="./css/dateInput.css" />
<link rel="stylesheet" href="./css/textInput.css" />
<link rel="stylesheet" href="./css/productList.css" />
<link rel="stylesheet" href="./css/breadcrumb.css" />
<link rel="stylesheet" href="./css/pagination.css" />
</head>
<body>

	<my:layout>
		<div class="page-container">
			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="정산:/product,정산목록:" />
			</div>

			<!-- 총 건수 -->
			<div class="page-totalCount">
				<p>총 200 건</p>
			</div>

			<!-- 결과 테이블 -->
			<div class="page-table">
				<div class="table-wrapper">
					<table class="table">
						<thead>
							<tr>
								<th class="sortable">정산기간 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>정산번호</th>
								<th class="sortable">총 주문 금액 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">할인 금액 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">순수 매출액 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>플랫폼 수수료</th>
								<th class="sortable">취소/환불차감금액 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">최종 지급액 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">지급일자 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>정산상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="i" begin="1" end="10">
								<tr>
									<td>2025-08-27~2025-09-26</td>
									<td>2025090${i}</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2,000,000</td>
									<td>2025-08-10</td>
									<td><my:tag color="yellow" size="sm" text="label" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="1" totalPages="10"
					baseUrl="/products?page=" />
			</div>
		</div>
	</my:layout>

	<script>
  // 부모에서 필터 이벤트 수신
  document.addEventListener("filterChanged", (e) => {
    console.log("필터 상태:", e.detail);
    if(e.detail.submit){
      // TODO: Ajax 호출 or form submit
    }
  });

  // 테이블 정렬
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
