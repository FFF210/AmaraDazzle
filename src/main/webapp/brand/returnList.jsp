<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>반품 관리</title>
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
<link rel="stylesheet" href="./css/productList.css" />
<link rel="stylesheet" href="./css/breadcrumb.css" />
<link rel="stylesheet" href="./css/pagination.css" />
<link rel="stylesheet" href="./css/tableFilter.css" />
</head>
<body>

	<my:layout>
		<div class="page-container">
			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="반품관리:" />
			</div>

			<!-- 테이블 필터 -->
			<div class="page-tableFilter">
				<my:tableFilter
					filters="반품 상태:전체|반품요청|반품승인|회수중|환불대기|반품완료|반품거절"
					searchItems="주문번호,반품번호,주문자,상품명,회수 운송장번호" />
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
								<th class="sortable">반품신청일 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>주문번호</th>
								<th>반품번호</th>
								<th>주문자</th>
								<th>상품명(옵션)</th>
								<th>수량</th>
								<th class="sortable">환불금액 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>회수 운송장번호</th>
								<th>반품상태</th>
								<th>메모</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="i" begin="1" end="10">
								<tr>
									<td><input type="checkbox" class="form-check" /></td>
									<td>2025-08-27</td>
									<td>2025090${i}</td>
									<td>2025090${i}</td>
									<td>김철수</td>
									<td>
										<div class="product-name">
											<p>[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트 EX 320ml 더블/듀오
												한정기획 4종 택1</p>
										</div>
									</td>
									<td>3</td>
									<td>20,000</td>
									<td>2025090${i}</td>
									<td><my:tag color="green" size="sm" text="세일" /></td>
									<td> </td>
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
	      icon.className = "bi bi-dash-lg sort-icon";
	    } else if (th.classList.contains("desc")) {
	      th.classList.remove("desc");
	      icon.className = "bi bi-dash-lg sort-icon"; // 기본 상태
	    } else {
	      th.classList.add("asc");
	      icon.className = "bi bi-dash-lg sort-icon";
	    }
	  });
	});
</script>
</body>
</html>
