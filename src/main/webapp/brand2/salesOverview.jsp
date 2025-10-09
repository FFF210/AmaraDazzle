<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출 지표</title>

<!-- Pretendard 폰트 (CDN) -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">

<!-- flatpickr 기본 테마 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/light.css">

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<!-- 한글화 & 커스텀 CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/custom-flatpickr.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<link rel="stylesheet" href="./css/dashboard.css" />

<!-- 공통 CSS -->
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />

<style>
.layout-content {
	padding: 8px 24px 8px 24px;
}

.breadcrumb {
	margin-bottom: 8px;
}

.chart-box {
	margin: 16px 0 8px 0;
}

.table-filter {
	margin-bottom: 8px;
}
</style>

</head>
<body>
	<my:layout>
		<my:breadcrumb
			items="대시보드:/brand2/dashboard, 매출지표:/brand2/salesOverview" />

		<!-- 그래프 -->
		<div class="chart-box">
			<h3>카테고리별 매출 추이</h3>
			<canvas id="salesLineChart"></canvas>
		</div>

		<!-- ============= tableFilter start ============= -->
		<div class="table-filter">
			<form method="get" action="/brand2/salesStatus">

				<!-- 날짜 필터 -->
				<div class="filter-row date-row">
					<label>기간:</label>
					<div class="filter_box">
						<div class="date-input">
							<div class="input-wrapper">
								<input type="text" id="startDate" name="startDate"
									class="date-text date-start" value="${param.startDate}"
									placeholder="YYYY-MM-DD" readonly />
								<button type="button" class="calendar-icon-wrapper">
									<i class="bi bi-calendar4 calendar-icon"></i>
								</button>
							</div>
						</div>
						<span>~</span>
						<div class="date-input">
							<div class="input-wrapper">
								<input type="text" id="endDate" name="endDate"
									class="date-text date-end" value="${param.endDate}"
									placeholder="YYYY-MM-DD" readonly />
								<button type="button" class="calendar-icon-wrapper">
									<i class="bi bi-calendar4 calendar-icon"></i>
								</button>
							</div>
						</div>

						<div class="margin"></div>

						<!-- 빠른 선택 버튼 -->
						<div class="date-input">
							<div class="preset-buttons">
								<button type="button" class="preset-btn date-quick"
									data-range="today">오늘</button>
								<button type="button" class="preset-btn date-quick"
									data-range="yesterday">어제</button>
								<button type="button" class="preset-btn date-quick"
									data-range="7">최근 7일</button>
								<button type="button" class="preset-btn date-quick"
									data-range="30">최근 30일</button>
							</div>
						</div>
					</div>
				</div>

				<!-- 카테고리 필터 -->
				<div class="filter-row">
					<label>카테고리:</label>
					<div class="filter-btn-group">
						<!-- 전체 버튼 -->
						<button type="button" class="filter-btn" data-filter="categories"
							data-value="ALL"
							<c:if test="${param.categories == null or param.categories == 'ALL'}">class="active"</c:if>>
							전체</button>

						<!-- depth=1 카테고리만 버튼으로 출력 -->
						<c:forEach var="cat" items="${categories}">
							<c:if test="${cat.depth == 1}">
								<button type="button" class="filter-btn"
									data-filter="categories" data-value="${cat.categoryId}"
									<c:if test="${fn:contains(param.categories, cat.categoryId)}">class="active"</c:if>>
									${cat.name}</button>
							</c:if>
						</c:forEach>
					</div>
				</div>

				<!-- 하단 버튼 -->
				<div class="filter-actions">
					<button type="submit" class="btn btn-primary btn-md">검색</button>
					<button type="reset" class="btn btn-outline btn-md">설정 초기화</button>
				</div>

			</form>
		</div>
		<!-- ============= tableFilter end ============= -->

		<!-- 테이블 -->
		<div class="tcontainer">
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th class="sortable">날짜 <i class="bi bi-dash-lg sort-icon"></i></th>
							<th>전체 매출</th>
							<th>스킨케어</th>
							<th>마스크팩</th>
							<th>클렌징</th>
							<th>선케어</th>
							<th>메이크업</th>
							<th>헤어케어</th>
							<th>바디케어</th>
							<th>향수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${salesList}">
							<tr>
								<td><fmt:formatDate value="${row.date}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatNumber value="${row.total}" type="number" /></td>
								<td><fmt:formatNumber value="${row.skincare}" type="number" /></td>
								<td><fmt:formatNumber value="${row.maskpack}" type="number" /></td>
								<td><fmt:formatNumber value="${row.cleansing}"
										type="number" /></td>
								<td><fmt:formatNumber value="${row.suncare}" type="number" /></td>
								<td><fmt:formatNumber value="${row.makeup}" type="number" /></td>
								<td><fmt:formatNumber value="${row.haircare}" type="number" /></td>
								<td><fmt:formatNumber value="${row.bodycare}" type="number" /></td>
								<td><fmt:formatNumber value="${row.perfume}" type="number" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<!-- 페이징 -->
		<div class="page-pagination">
			<my:pagination currentPage="${currentPage}"
				totalPages="${totalPages}" baseUrl="/brand2/salesOverview" />
		</div>
	</my:layout>

	<%-- =================================================================================================================== --%>
	<script>
	/******************* chart javascript *******************/
		flatpickr("#startDate", {
			dateFormat : "Y-m-d"
		});
		flatpickr("#endDate", {
			dateFormat : "Y-m-d"
		});

		// 서버에서 내려준 JSON 데이터
		const chartData = ${salesChartJson};
		
		// Chart.js 꺾은선그래프
		const ctx = document.getElementById('salesLineChart');
		new Chart(ctx, {
			type : 'line',
			data : chartData,
			options : {
				responsive : true,
				plugins : { legend : { position : 'right' } },
				scales : { y : { beginAtZero : true } }
			}
		});
	</script>
	<script>
	/*******************tableFilter 이벤트*******************/
	document.addEventListener("DOMContentLoaded", () => {
		  const form = document.querySelector(".table-filter form");

		  // ====== 카테고리 버튼 ======
		  const categoryButtons = form.querySelectorAll(".filter-btn[data-filter='categories']");
		  
		  // hidden input 생성 (다중 선택 지원)
		  let hiddenInput = form.querySelector("input[name='categories']");
		  if (!hiddenInput) {
		    hiddenInput = document.createElement("input");
		    hiddenInput.type = "hidden";
		    hiddenInput.name = "categories";
		    form.appendChild(hiddenInput);
		  }

		  categoryButtons.forEach((btn) => {
		    btn.addEventListener("click", () => {
		      // active 토글
		      btn.classList.toggle("active");

		      // 선택된 버튼들의 value 수집
		      const selectedValues = Array.from(categoryButtons)
		        .filter((b) => b.classList.contains("active"))
		        .map((b) => b.dataset.value);

		      // hidden input에 콤마로 연결해서 저장
		      hiddenInput.value = selectedValues.join(",");
		    });
		  });

		  // ====== 날짜 빠른 선택 ======
		  const presetBtns = form.querySelectorAll(".preset-btn.date-quick");
		  presetBtns.forEach((btn) => {
		    btn.addEventListener("click", () => {
		      const range = btn.dataset.range;
		      const startDateInput = form.querySelector("input[name='startDate']");
		      const endDateInput = form.querySelector("input[name='endDate']");
		      const today = new Date();
		      let startDate, endDate;

		      switch (range) {
		        case "today":
		          startDate = endDate = today;
		          break;
		        case "yesterday":
		          startDate = endDate = new Date(today.setDate(today.getDate() - 1));
		          break;
		        case "7":
		          endDate = new Date();
		          startDate = new Date();
		          startDate.setDate(endDate.getDate() - 6);
		          break;
		        case "30":
		          endDate = new Date();
		          startDate = new Date();
		          startDate.setDate(endDate.getDate() - 29);
		          break;
		      }

		      // 날짜 yyyy-MM-dd 포맷 변환
		      const format = (d) => d.toISOString().slice(0, 10);
		      if (startDateInput) startDateInput.value = format(startDate);
		      if (endDateInput) endDateInput.value = format(endDate);
		    });
		  });

		  // ====== 리셋 버튼 ======
		  const resetBtn = form.querySelector("button[type='reset']");
		  if (resetBtn) {
		    resetBtn.addEventListener("click", () => {
		      // 카테고리 버튼 초기화
		      categoryButtons.forEach((btn) => btn.classList.remove("active"));
		      hiddenInput.value = "";

		      // 날짜 초기화
		      form.querySelector("input[name='startDate']").value = "";
		      form.querySelector("input[name='endDate']").value = "";
		    });
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
	<%-- =================================================================================================================== --%>
</body>
</html>
