<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>문의</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/button.css" />
<link rel="stylesheet" href="./css/alert.css" />
<link rel="stylesheet" href="./css/form-controls.css" />
<link rel="stylesheet" href="./css/layout.css" />
<link rel="stylesheet" href="./css/sidebar.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/table.css" />
<link rel="stylesheet" href="./css/dialog.css" />
<link rel="stylesheet" href="./css/tag.css" />
<link rel="stylesheet" href="./css/selectbox.css" />
<link rel="stylesheet" href="./css/dateInput.css" />
<link rel="stylesheet" href="./css/textInput.css" />
<link rel="stylesheet" href="./css/productList.css" />
<link rel="stylesheet" href="./css/breadcrumb.css" />
<link rel="stylesheet" href="./css/pagination.css" />
<link rel="stylesheet" href="./css/tableFilter.css" />
<link rel="stylesheet" href="./css/inquiryList.css" />
</head>
<body>

	<my:layout>
		<div class="page-container">
			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="문의:" />
			</div>

			<!-- 문의 등록 버튼 -->
			<div class="page-openInquiryDialog">
				<button type="button" class="btn btn-primary btn-md"
					id="openInquiryDialog">문의 등록</button>
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
								<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>작성일</th>
								<th>문의유형</th>
								<th>내용</th>
								<th>답변상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="i" begin="1" end="5">
								<tr>
									<td>1</td>
									<td>2025-09-10</td>
									<td><my:tag color="green" size="sm" text="label" /></td>
									<td>
										<div class="product-name">
											<p>문의 내용이 들어갑니다.</p>
										</div>
									</td>
									<td><my:tag color="green" size="sm" text="label" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<!-- 문의 상세 (Q/A) -->
			<div class="inquiry-detail">
				<div class="qa-block q-block">
					<span class="qa-label q">Q</span>
					<div class="qa-content">
						<div class="qa-left">
							<my:tag color="green" size="sm" text="시스템" />
							<p>이 상품은 언제 재입고 되나요?이 상품은 언제 재입고 되나요?이 상품은 언제 재입고 되나요?이 상품은
								언제 재입고 되나요?이 상품은 언제 재입고 되나요?이 상품은 언제 재입고 되나요?이 상품은 언제 재입고 되나요?이
								상품은 언제 재입고 되나요?이 상품은 언제 재입고 되나요?</p>
						</div>
						<span class="qa-date">작성일: 2025-09-10</span>
					</div>
				</div>

				<div class="qa-block a-block">
					<span class="qa-label a">A</span>
					<div class="qa-content">
						<div class="qa-left">
							<p>
								안녕하세요 고객님. 해당 상품은 다음주 월요일(9/15)에 재입고 예정입니다.<br> 감사합니다.
							</p>
						</div>
						<span class="qa-date">답변일: 2025-09-11</span>
					</div>
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

  // "세일 등록" 버튼 클릭 → 다이얼로그 열기
  document.getElementById("openSaleDialog").addEventListener("click", () => {
    document.getElementById("formDialog").classList.add("show");
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
