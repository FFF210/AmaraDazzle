<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>상품 목록</title>
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
<link rel="stylesheet" href="./css/dialog.css" />
<link rel="stylesheet" href="./css/tag.css" />
<link rel="stylesheet" href="./css/selectbox.css" />
<link rel="stylesheet" href="./css/dateInput.css" />
<link rel="stylesheet" href="./css/textInput.css" />
<link rel="stylesheet" href="./css/breadcrumb.css" />
<link rel="stylesheet" href="./css/pagination.css" />
<link rel="stylesheet" href="./css/tableFilter.css" />
</head>
<body>

	<my:layout>
		<div class="page-container">
		
			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="상품목록:" />
			</div>

			<!-- 세일 등록 버튼 -->
			<div class="page-openSaleDialog">
				<button type="button" class="btn btn-primary btn-md"
					id="openSaleDialog">세일 등록</button>
			</div>

			<!-- 테이블 필터 -->
			<div class="page-tableFilter">
				<my:tableFilter
					filters="결제 상태:결제 대기|결제 완료|결제 실패|취소 요청|결제 취소,
	           				 배송 상태:배송 준비중|배송중|배송 완료|반품 요청|반품 완료"
					searchItems="상품코드,상품명,카테고리" />
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
								<th><input type="checkbox" class="form-check" /></th>
								<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>상품코드</th>
								<th>상품명</th>
								<th>카테고리</th>
								<th class="sortable">판매가 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">할인가 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>판매상태</th>
								<th class="sortable">재고 수 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">누적 판매수 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">리뷰 수 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th>작업</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="i" begin="1" end="10">
								<tr>
									<td><input type="checkbox" class="form-check" /></td>
									<td>${i}</td>
									<td>2025090${i}</td>
									<td>
										<div class="product-name">
											<p>[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트 EX 320ml 더블/듀오
												한정기획 4종 택1</p>
										</div>
									</td>
									<td>화장품</td>
									<td>25,000</td>
									<td>20,000</td>
									<td><my:tag color="green" size="sm" text="세일" /></td>
									<td>123</td>
									<td>456</td>
									<td>78</td>
									<td>
										<div class="actions">
											<button type="button" class="btn btn-outline btn-sm">재고
												수정</button>
											<button type="button" class="btn btn-outline btn-sm">수정</button>
											<button type="button" class="btn btn-danger btn-sm">삭제</button>
										</div>
									</td>
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
