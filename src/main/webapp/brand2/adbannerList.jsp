<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배너광고 조회</title>

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

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<style>
.pagination {
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
	margin: 20px 0; /* 위아래 여백 */
}

.breadcrumb {
	margin-top: 8px;
	margin-left: 24px;
}

.filter {
	margin: 24px 24px 24px 24px;
}

.tcontainer {
	margin: 0px 24px 24px 24px;
}
</style>
<!-- TossPayments SDK -->
<script src="https://js.tosspayments.com/v1/payment"></script>
</head>
<body>
	<my:layout>
		<my:breadcrumb items="배너광고 관리:/brand2/adbannerList.jsp" />

		<div class="filter">
			<my:tableFilter
				filters="진행 상황:ALL=전체|PENDING=승인 대기|APPROVED=승인 완료|ONGOING=진행 중|COMPLETED=완료|CANCELED=취소"
				searchItems="광고명,광고담당자" />
		</div>

		<div class="tcontainer">
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th><input type="checkbox" class="form-check" /></th>
							<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
							<th>신청일</th>
							<th>광고 기간</th>
							<th>광고명</th>
							<th>진행 상황</th>
							<th>광고 담당자</th>
							<th>결제 금액</th>
							<th>담당 연락처</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="banner" items="${bannerList }">
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${banner.bannerId }</td>
								<td><fmt:formatDate value="${banner.createdAt }"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${banner.startDate}"
										pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
										value="${banner.endDate}" pattern="yyyy-MM-dd" /></td>

								<td>
									<p class="product-name">${banner.bannerName }</p>
								</td>
								<td><c:choose>
										<c:when test="${banner.status eq 'PENDING'}">
											<my:tag color="blue" size="sm" text="승인 대기" />
										</c:when>
										<c:when test="${banner.status eq 'APPROVED'}">
											<my:tag color="gray" size="sm" text="승인 완료" />
										</c:when>
										<c:when test="${banner.status eq 'ONGOING'}">
											<my:tag color="green" size="sm" text="진행 중" />
										</c:when>
										<c:when test="${banner.status eq 'COMPLETED'}">
											<my:tag color="green" size="sm" text="완료" />
										</c:when>
										<c:when test="${banner.status eq 'CANCELED'}">
											<my:tag color="red" size="sm" text="취소" />
										</c:when>
									</c:choose></td>

								<td>${banner.managerName }</td>
								<td>미구현</td>
								<td>${banner.managerTel }</td>


								<td>
									<div class="actions">
										<c:choose>
											<%-- 승인 대기 --%>
											<c:when test="${banner.status eq 'PENDING'}">
												<button type="button" class="btn btn-outline btn-sm"
													onclick="location.href='/miniProj2/brand2/eventForm.jsp?bannerId=${banner.bannerId}'">
													상세보기</button>
												<button type="button" class="btn btn-danger btn-sm"
													onclick="if(confirm('정말 취소하시겠습니까?')) location.href='/miniProj2/brand2/bannerCancel.do?bannerId=${banner.bannerId}'">
													취소</button>
											</c:when>

											<%-- 승인 완료 --%>
											<c:when test="${banner.status eq 'APPROVED'}">
												<button type="button" class="btn btn-success btn-sm"
													onclick="location.href='/miniProj2/brand2/payment.jsp?bannerId=${banner.bannerId}'">
													결제하기</button>
											</c:when>

											<%-- 진행 중 / 완료 / 취소 --%>
											<c:when
												test="${banner.status eq 'ONGOING' or banner.status eq 'COMPLETED' or banner.status eq 'CANCELED'}">
												<button type="button" class="btn btn-outline btn-sm"
													onclick="location.href='/miniProj2/brand2/eventForm.jsp?bannerId=${banner.bannerId}'">
													상세보기</button>
											</c:when>
										</c:choose>
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
			<my:pagination currentPage="${currentPage}"
				totalPages="${totalPages}"
				baseUrl="/brand2/adbannerList?${queryString}&page=" />

		</div>
	</my:layout>
	<script>
document.addEventListener("filterChanged", (e) => {
  console.log("필터 상태:", e.detail);

  if (e.detail.submit) {
    const { filters, searchField, searchKeyword } = e.detail;
    const params = new URLSearchParams();

    // 진행상황 필터 처리
    for (const [key, value] of Object.entries(filters)) {
      if (key === "진행 상황" && value && value !== "전체") {
        // 한글 상태 → DB 코드 변환
        switch (value) {
          case "대기": params.append("status", "PENDING"); break;
          case "진행 중": params.append("status", "ONGOING"); break;
          case "완료": params.append("status", "COMPLETED"); break;
          case "취소": params.append("status", "CANCELED"); break;
        }
      }
    }

    // 검색 항목 (광고명 / 광고담당자)
    if (searchField) {
      params.append("searchType", searchField);
    }

    if (searchKeyword !== undefined && searchKeyword !== null) {
    	  params.append("searchKeyword", searchKeyword);
    	}

    // 페이지는 항상 1부터 시작
    params.append("page", 1);

    // 최종 URL로 이동 (GET 요청)
    window.location.href = "/brand2/adbannerList?" + params.toString();
  }
});

// =============================
// selectbox 관련 코드 수정 부분
// =============================
document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".custom-select").forEach(select => {
    const header = select.querySelector(".select-header");
    const label = select.querySelector(".select-label");
    const list = select.querySelector(".select-list");
    const items = select.querySelectorAll(".select-item");

    // 열기/닫기 토글
    header.addEventListener("click", () => {
      select.classList.toggle("open");
    });

    // 옵션 선택
    items.forEach(item => {
      item.addEventListener("click", () => {
        // 라벨 교체
        label.textContent = item.textContent;

        // active 표시 갱신
        items.forEach(i => i.classList.remove("active"));
        item.classList.add("active");

        // 닫기
        select.classList.remove("open");

        let mappedValue = item.textContent;
        if (mappedValue === "광고명") mappedValue = "bannerName";
        if (mappedValue === "광고담당자") mappedValue = "managerName";

        // 커스텀 이벤트 발생 (value=DB 값, text=화면 표시 값)
        const event = new CustomEvent("selectChanged", {
          detail: {
            value: mappedValue,      // DB에서 사용할 값
            text: item.textContent   // 화면에 보이는 값
          }
        });
        document.dispatchEvent(event);
      });
    });

    // 다른 영역 클릭 시 닫기
    document.addEventListener("click", (e) => {
      if (!select.contains(e.target)) {
        select.classList.remove("open");
      }
    });
  });
});
</script>


</body>
</html>